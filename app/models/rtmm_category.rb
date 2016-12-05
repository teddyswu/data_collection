class RtmmCategory < ActiveRecord::Base
	has_one :rtmm_message,   :foreign_key => "rtmm_category_id"
	has_many :rtmm_users, 	 :foreign_key => "category"
end
