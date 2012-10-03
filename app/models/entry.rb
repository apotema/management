class Entry < ActiveRecord::Base
  attr_accessible :name, :priority

  validates :name, presence: true
  validates :priority, presence: true
end
