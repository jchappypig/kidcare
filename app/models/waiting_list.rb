class WaitingList < ActiveRecord::Base
  serialize :days_per_week, Array
  validates :child_name, presence: true
  validates :child_age, presence: true
  validates :parent_name, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :postcode, presence: true
end
