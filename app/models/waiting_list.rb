class WaitingList < ActiveRecord::Base
  serialize :days_required, Array
  validates :child_full_name, presence: true
  validates :child_dob, presence: true
  validates :parent_full_name, presence: true
  validates :home_phone, presence: true
  validates :mobile_phone, presence: true
  validates :address, presence: true

  before_create :set_date_contacted

  private

  def set_date_contacted
    if date_contacted.nil?
      self.date_contacted = created_at.to_date
    end
  end

end
