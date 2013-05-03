#!/usr/bin/ruby

require 'rubygems'
require 'sinatra/base'
require 'slim'

class SassHandler < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/templates/sass'

  get '/css/*.css' do
    filename = params[:splat].first
    sass filename.to_sym

  end

end

class CoffeeHandler < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/templates/coffee'

  get "/js/*.js" do
    filename = params[:splat].first
    coffee filename.to_sym

  end

end

class Wordcount < Sinatra::Base
  use SassHandler
  use CoffeeHandler

  set :views,  File.dirname(__FILE__)    + '/views'
  set :public_dir,  File.dirname(__FILE__)    + '/public_dir'
  
  get '/' do
    slim :index
  end

  post '/result' do
    @text_to_count = params[:text_to_count]
    @final_count   = @text_to_count.scan(/\w+/).size
    slim :index

  end

end