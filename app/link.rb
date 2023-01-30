

require 'yaml'
require 'mechanize'



class Link < ActiveRecord::Base

  scope :recents, -> {where(:created_at => Time.now.beginning_of_day-6.days .. Time.now)}
  scope :clicky, -> {where("clicks > 1")}
  scope :hot, -> {order(clicks: :desc)}

  def self.hotshit
    Link.hot.clicky.limit(5)
  end

  # Default search title/urlstring
  # Search by user with user:string
  # Search by date maybe in the future
  def self.search(pattern)
    if pattern =~ /user:/
      pattern = pattern.split(':')[1]
      return where("user like ?", "%#{pattern}%").limit(20)
    end
    return where("title like ?", "%#{pattern}%").where("url like ?", "%#{pattern}%").limit(20)
  end

  def get_title
    webpage = Mechanize.new.get(url)
    # TODO handle errors
    self.content_type = webpage.header['content-type']
    if self.content_type =~ /image/
      save!
      return false
    else
      self.title = webpage.title
      if self.title == '' or self.title.nil?
        self.title=url
      end
    end
    save!
    @title
  end

  def self.page(num)
    start_range = Time.now.end_of_day.weeks_ago(num)
    end_range = Time.now.beginning_of_day.weeks_ago(num + 1)
    where(:created_at => end_range..start_range)
  end

  def payload()
    db_config = YAML::load(File.open('config/database.yml'))
    # Need to figure out if it's an image first, I think
    if self.content_type =~ /image/
      return "<a href='#{db_config['weburi']}/link/#{self.id}'><img src='#{self.url}'></a>"
    end
    # Tweets
    if self.url =~ /twitter.com\/[a-zA-z]*\/status/
      tweetid = self.url.split("/status/")[1]
      %Q{
              <blockquote class="twitter-tweet">
                 <a href="https://twitter.com/x/status/#{tweetid}"></a>
              </blockquote>
              <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>}
    # Youtube embeds
    elsif self.url =~ /youtube.com/ or self.url =~ /youtu.be/
      if self.url =~ /youtu.be/
        ytid = self.url.split('youtu.be')[-1][1..-1]
      elsif self.url =~ /\/shorts\//
        ytid = self.url.split('/')[-1]
      else
        ytid=self.url.split('v=')[-1]
      end
      url = "http://youtube.com/embed/#{ytid}"
      %Q{<object data="#{url}" width=480 height=320> </object><br />}
    # Normal links
    elsif self.content_type =~ /text\/html/
      "<a href='#{db_config['weburi']}/link/#{self.id}'>#{self.title}</a>"
    # spotify
    # amazon preview card
    # gist
    # github repo
    # google maps
    # instagram
    end


  end
end
