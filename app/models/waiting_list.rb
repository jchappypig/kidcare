class WaitingList < ActiveRecord::Base
  serialize :days_per_week, Array
end
