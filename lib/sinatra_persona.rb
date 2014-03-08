require 'sinatra_persona/version'
require 'sinatra_persona/verifier'
require 'sinatra_persona/js'
require 'sinatra/base'

module Sinatra
  module Persona

    def self.registered(app)
      app.helpers Persona::Helpers
      app.post '/auth/persona_verifier' do
        assertion = params[:assertion]
        audience = request.host_with_port
        verifier_uri = settings.respond_to?(:persona_verifier_uri) ? settings.persona_verifier_uri : nil
        email = ::Persona::Verifier.verify_assertion(assertion, audience, verifier_uri: verifier_uri)
        if email.nil?
          session.delete(:persona)
        else
          session[:persona] = email
        end
        if session.respond_to? :after_persona_redirect
          redirect to settings.after_persona_redirect
        else
          redirect to '/'
        end
      end
    end

    module Helpers

      DEFAULT_LOGIN_TEXT = "Log in with Persona"

      def persona?
        session[:persona]
      end
      
      def persona
        session[:persona]
      end

      def clear_persona!
        session[:persona] = nil
      end

      def persona_button
        login_text = DEFAULT_LOGIN_TEXT
        if settings.respond_to? :persona_login_button_text
          login_text = settings.persona_login_button_text
        end
        "<button id='persona-login-button'>Log in with Persona</button>"
      end
      
      def persona_scripts
        if settings.respond_to? :persona_no_jquery and settings.persona_no_jquery
          PersonaJS.scripts_no_jquery
        else
          PersonaJS.scripts
        end
      end
    end
  end
  register Persona
end


