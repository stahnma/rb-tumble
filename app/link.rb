


require 'mechanize'

class Link < ActiveRecord::Base

  scope :recents, -> {where(:created_at => Time.now.beginning_of_day-6.days .. Time.now)}
  scope :clicky, -> {where("clicks > 1")}
  scope :hot, -> {order(clicks: :desc)}

  def self.hotshit
    Link.hot.clicky.limit(5)
  end

  def get_title
    webpage = Mechanize.new.get(url)
    # TODO handle errors
    self.content_type = webpage.header['content-type']
    self.title = webpage.title
    save!
    @title
  end

  def self.page(num)
    start_range = Time.now.end_of_day.weeks_ago(num)
    end_range = Time.now.beginning_of_day.weeks_ago(num + 1)
    where(:created_at => end_range..start_range)
  end

  def payload()
    if self.content_type =~ /text\/html/
      "<a href='http://giga2:4567/link/#{self.id}'>#{self.title}</a>"
    end
  end
end
