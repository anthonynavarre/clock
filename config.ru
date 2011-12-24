require 'sinatra'
require 'sprockets'
require 'slim'

class FractalClock < Sinatra::Base
  get '/' do
    slim :index
  end
end

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'app/assets/javascripts'
  environment.append_path 'app/assets/stylesheets'
  environment.append_path 'app/assets/images'
  run environment
end

map '/' do
  run FractalClock
end
