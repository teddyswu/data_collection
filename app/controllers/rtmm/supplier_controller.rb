class Rtmm::SupplierController < RtmmsController
	def index
		@cate = RtmmCategory.all
	end
	def get_user
    
	end
	def show
		@users = RtmmUser.where(:category => params[:id], :is_online => true)
		@category = RtmmCategory.find(params[:id])
	end
end
