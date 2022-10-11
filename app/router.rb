
#require 'bundler/setup'
#Bundler.require

require 'date'
require "sinatra"
require "sinatra/reloader" 
require 'yaml'
require 'active_record'
require_relative 'quote'
require 'awesome_print'



db_config = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(db_config)

set :bind, '0.0.0.0'
set :public_folder, __dir__ + '/public'

def main_page(weeks = 0)
  puts "Weeks is " + weeks.to_s
  @tumble_items = Quote.page(weeks)
  ap @tumble_items
  # Get all items from quote, irclink and render them
  @tumble_items
end

#class Tumble < Sinatra::Application
#
  helpers do
    def partial (template, locals = {})
      erb(template, :layout => false, :locals => locals)
    end
  end

    register Sinatra::Reloader 
    after_reload do
     puts "reloaded"
    end

  get '/' do 
    if @params.has_key?(:i)
      @page=@params[:i].to_i
    else
      @page = 0
    end
    @tumble_items = main_page(@page)
    erb :index
  end

  get '/quote' do
    redirect to('/')
  end

  post '/quote' do
    @params = params
    @quote = @params[:quote]
    @author = @params[:author]
    #puts "The quote is #{@quote}"
    #puts "The author is #{@author}"
    q = Quote.new(:author => @author, :quote => @quote)
    q.save!
    "Quote added...probably"
  end

  #TODO
  delete '/quote', :agent => "special crunchy agent" do
    #.. create something ..
  end

  not_found do
    'This is nowhere to be found.'
  end


  ActiveRecord::Base.connection.close

#   run! if app_file == $0
#end



