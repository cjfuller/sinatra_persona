# SinatraPersona

A Sinatra extension for logging in with [persona](https://persona.org/about) and verifying persona assertions.

## Installation

Add this line to your application's Gemfile:

    gem 'sinatra_persona'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra_persona

## Usage

### Include the extension in your app.

For a classic-style app:
```ruby
require 'sinatra_persona'
enable :sessions
```

For a modular-style app:
```ruby
require 'sinatra/base'
require 'sinatra_persona'

class MyApp < Sinatra::Base
  enable :sessions
  register Sinatra::Persona
  # Application code here
end
```

### URL handlers

The extension defines a POST handler at `/auth/perona_verifier` to which the
assertions to be verified are sent.  You don't need to use this explicitly if
you use the supplied login button helper and scripts helper.

### Interface

Several helpers are available for interacting with persona:

- `persona` gets the e-mail by which a user has identified or nil if not
  identified.
- `persona?` is an alias for `persona` (if you want to use it to check if
  someone has identified and follow the boolean-with-question-mark convention)
- `clear_persona!` clears out the persona information from the session. This
  will require users to log in again.
- `persona_button` returns a string containing an html button element that will
  trigger login. This is not styled by default, but has id
  `persona-login-button` so you can style it however you like.
- `persona_scripts` returns a string containing html script tags that will
  include the persona scripts from persona.org, a script to set the click
  action of the persona button on the page, and jQuery hosted by google.  See
  the settings section below if don't want to inlcude the default jQuery and
  instead supply your own self-hosted one.

### Settings

Several optional settings are available via the normal Sinatra settings
mechanism (i.e. to set setting `foo` to `'value'`, do `set :foo, 'value'` in
your app.

- `persona_login_button_text`: the text to display on the login button returned
  by the `persona_button` helper.  Defaults to "Log in with Persona".

- `persona_verifier_uri`: a stdlib URI (not a string) that is a location that
  verifies persona assertions.  Defaults to
  "https://verifier.login.persona.org/verify". Make sure this uses https.

- `after_persona_redirect`: a string that is the location to redirect to after
  verifying the persona assertion.  Defaults to '/'.

- `persona_no_jquery`: set to true if you don't want to use the google-hosted
  jQuery version.  At the moment, the scripts returned by the `persona_scripts`
  helper require jQuery, so you'll need to supply your own if you turn this
  off.

## Contributing

License: MIT.  See LICENSE.txt for the full text.

Pull requests welcome!


