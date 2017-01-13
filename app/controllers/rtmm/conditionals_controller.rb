class Rtmm::ConditionalsController < ApplicationController
	def index
		@categorys = RtmmCategory.all
	end

	def edit
		@category = RtmmCategory.find(params[:id])
	end

	def update
	  @category = RtmmCategory.find(params[:id])
	  @category.total_percent = params[:rtmm_category][:total_percent]
	  @category.save!

	  redirect_to :action => :index
	end
end
