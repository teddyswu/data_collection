module Rtmm::CustomerBaseHelper

	def render_brand_preference(id)
		rend = RtmmBrandPreference.find(id.to_i)
		return rend.name
	end

	def render_price(id)
		rend = RtmmPrice.find(id.to_i)
		return rend.name
	end

	def render_position(id)
		rend = RtmmPosition.find(id.to_i)
		return rend.name
	end

	def render_group(id)
		rend = RtmmGroup.find(id.to_i)
		return rend.name
	end

	def render_product_color(id)
		rend = RtmmProductColor.find(id.to_i)
		return rend.name
	end

	def render_prefecture(id)
		rend = RtmmPrefecture.find(id.to_i)
		return rend.name
	end

	def render_other_prefecture(id)
		rend = RtmmOtherPrefecture.find(id.to_i)
		return rend.name
	end 
end
