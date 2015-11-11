module Rtmm::HistoryHelper
	def render_category_name(id)
		category = RtmmCategory.find(id)
		return category.name
	end
	def render_value(total, value)
		v = (value.to_f/total) * 100
	end
end
