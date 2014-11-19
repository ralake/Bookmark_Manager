require 'sinatra/base'
require 'sinatra/partial'
require 'data_mapper'
require 'rack-flash'
require './lib/link'
require './lib/tag'
require './lib/user'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  register Sinatra::Partial

  enable :sessions
  enable :partial_underscores
  set :session_secret, 'super secret'
  set :partial_template_engine, :erb
  use Rack::Flash
  use Rack::MethodOverride

  run! if app_file == $0

end

require_relative './controllers/links'
require_relative './controllers/application'
require_relative './controllers/sessions'
require_relative './controllers/tags'
require_relative './controllers/users'
