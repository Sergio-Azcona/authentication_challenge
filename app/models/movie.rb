class Movie < ApplicationRecord
    validates_presence_of :title, :rating, :description



end 