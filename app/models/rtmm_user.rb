class RtmmUser < ActiveRecord::Base
	belongs_to :rtmm_category, :foreign_key => "category"
end
