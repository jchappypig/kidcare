class WaitingList < ActiveRecord::Base
  serialize :days_required, Array
  validates :child_full_name, presence: true
  validates :child_dob, presence: true
  validates :parent_full_name, presence: true
  validates :home_phone, presence: true
  validates :mobile_phone, presence: true
  validates :address, presence: true
  validates :postcode, presence: true
end
