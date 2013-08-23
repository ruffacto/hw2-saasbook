class Movie < ActiveRecord::Base
  def self.all_ratings
    ['G','PG','PG-13','R']  
  end
  def self.checked(ratings)
    checked = Hash.new
    all_ratings.each {|rating|
      checked[rating] = ratings.include?(rating)
    }
    checked
  end  
end
