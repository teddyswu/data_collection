class RtmmMessage < ActiveRecord::Base
	belongs_to :rtmm_category
	scope :enabled, -> {where(["start_date < ? and end_date > ?", Time.now, Time.now])}
end
