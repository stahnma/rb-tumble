
require 'bundler/setup'
Bundler.require

require "sinatra"
require "sinatra/reloader" if development?
require 'yaml'
require 'active_record'

db_config = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(db_config)

require_relative 'quote'


set :bind, '0.0.0.0'

set :public_folder, __dir__ + '/static'

get '/quote' do
  #.. show something ..
end

post '/quote' do
  @params = params
  @quote = @params[:quote]
  @author = @params[:author]
  puts "The quote is #{@quote}"
  puts "The author is #{@author}"
  q = Quote.new(:author => @author, :quote => @quote)
  q.save!
  
end

delete '/quote', :agent => "special crunchy agent" do
  #.. create something ..
end

