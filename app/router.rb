require 'date'
require "sinatra"
require "sinatra/reloader"
require 'yaml'
require 'active_record'
require_relative 'quote'
require_relative 'link'
require 'awesome_print'
require 'json'

db_config = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(db_config)

set :bind, '0.0.0.0'
set :public_folder, __dir__ + '/public'

def main_feed(weeks = 0)
  @tumble_items = []
  Quote.page(weeks).each do |q|
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

configure :development do
   set :logging, Logger::DEBUG
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
  @page = 0
  @tumble_items = main_feed()
  @hotshit = Link.hotshit()
  erb :index
end

get '/:page' do
  if @params.has_key?(:page)
    @page=@params[:page].to_i
  else
    @page = 0
  end
  @tumble_items = main_feed(@page)
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
  content_type :text
  ap request.env


  @params = params
  #TODO get title via a lookup
  link  = Link.new(:user => @params[:user], :url => @params[:url])
  link.channel = @params['channel'] if @params.has_key?('channel')
  begin
    link.get_title()
  rescue
    status 400 # Bad Request
    return "Problem validating link."
  end
  link.save!
  link.save
  ap link
  #TODO allow link edits
  #TODO tell fools when they've already posted a link
  "#{db_config['weburi']}/link/#{link.id}"
end

post '/link/' do
  redirect '/link'
end

get '/link/:id' do
  # What if not found?
  l = Link.find_by_id(params['id'])
  l.clicks += 1
  l.save
  redirect l.url
end

#not_found do
#  'This is nowhere to be found.'
#end

ActiveRecord::Base.connection.close
