require 'json'
require 'sinatra'
require 'sinatra/activerecord'

require './config/database'

# Load Models
Dir["./app/models/*.rb"].each do |file|
  require file
end

class App < Sinatra::Base
  get '/' do
    'Hello world!'
  end
end
