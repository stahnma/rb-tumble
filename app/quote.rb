

class Quote < ActiveRecord::Base
  scope :recents, -> {where(:created_at => Time.now.beginning_of_day-6.days .. Time.now)}

  def self.page(num)
    start_range = Time.now.end_of_day.weeks_ago(num)
    end_range = Time.now.beginning_of_day.weeks_ago(num + 1)
    where(:created_at => end_range..start_range)
  end
end
