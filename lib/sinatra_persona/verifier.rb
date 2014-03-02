require 'sinatra/base'
require 'json'
require 'net/https'

module Persona
  module Verifier

    DEFAULT_VERIFIER_URI = URI("https://verifier.login.persona.org/verify")

    def self.verify_assertion(assertion, audience, verifier_uri: nil)
      verifier_uri ||= DEFAULT_VERIFIER_URI
      Net::HTTP.start(verifier_uri.host, verifier_uri.port, use_ssl: true) do |conn|
        params = {assertion: assertion, audience: audience}
        verifier_uri.query = URI.encode_www_form(params)
        request = Net::HTTP::Post.new verifier_uri
        response = conn.request request
        if not response.code == '200' or response.body.nil? then
          return nil
        end
        parsed = JSON.parse response.body
        if parsed['status'] == 'okay' then
          parsed['email']
        else
          nil
        end
      end
    end
  end
end
