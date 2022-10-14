
#require 'bundler/setup'
#Bundler.require

require 'date'
require "sinatra"
require "sinatra/reloader"
require 'yaml'
require 'active_record'
require_relative 'quote'
require_relative 'link'
require 'awesome_print'



db_config = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(db_config)

set :bind, '0.0.0.0'
set :public_folder, __dir__ + '/public'

def main_page(weeks = 0)
  puts "Weeks is " + weeks.to_s
  @tumble_items = []
  Quote.page(weeks).each do| q|
    @tumble_items.push q
  end
  Link.page(weeks).each do |l|
    @tumble_items.push l
  end
  ti = @tumble_items.sort_by! { |item| item[:created_at] }
  ti.reverse!
  # Get all items from quote, irclink and render them
  ti
end

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
    @hotshit = Link.hotshit()
    erb :index
  end

  get '/quote' do
    redirect to('/')
  end

  #TODO Error handling?
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

  # Get simple link posting working
  # TODO error handling and validation of URL
  post '/link' do
    @params = params
    #TODO get title via a lookup
    link  = Link.new(:user => @params[:user], :url => @params[:url])
    link.get_title()
    link.save!
    link.save
    #TODO allow link edits
    #TODO tell fools when they've already posted a link
    puts link.id
    "http://giga2:4567/link/#{link.id}"
  end

  get '/link/:id' do
    # What if not found?
    l = Link.find_by_id(params['id'])
    l.clicks += 1
    l.save
    redirect l.url
  end


  not_found do
    'This is nowhere to be found.'
  end


  ActiveRecord::Base.connection.close
