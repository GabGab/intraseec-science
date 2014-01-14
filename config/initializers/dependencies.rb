require "#{Rails.root}/lib/rack/ssl_middleware"
IntraseecScience::Application.config.middleware.use(Rack::Sociabliz::Ssl)