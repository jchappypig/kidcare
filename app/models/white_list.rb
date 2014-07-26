class WhiteList < ActiveRecord::Base
  validates :email, presence: true
end
