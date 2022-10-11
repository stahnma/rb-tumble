
require 'bundler/setup'

require 'date'
require 'yaml'
require 'active_record'
require 'awesome_print'



db_config = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(db_config)

require_relative 'quote'
require_relative 'link'


def main_page
  # find all tumble items that are of a certain age
  #  now = Date.today
#  n_days_ago = (now - 6)
  # Select all the quotes in the range (old..new)
#  puts Quote.where(created_at: (n_days_ago.beginning_of_day - 6.day)..now.end_of_day)
#  ActiveRecord::Base.establish_connection(db_config)

#  puts Quote.all
  #Quote.all do |q|
  #Quote.where(created_at:  Time.now - 6.. Time.now)
#  ap Quote.where(:created_at => Time.now.beginning_of_day-6.days .. Time.now)
#  puts Quote.recents.to_sql
#  Quote.recents.each do |q|
#    ap q
#  end


#  puts "older"
#  Quote.weeks.each do |q|
#    ap q
#  end


#  (0..5).each do |n|
#    puts n
##    puts Quote.page(n).to_sql
#    Quote.page(n).each do |q|
#      ap q
#    end
#  end

  Link.all.each do |l|
    ap l
    ap l.render()
  end
end


main_page


