class Rtmm::HistoryController < RtmmsController
	def index
		@history = RtmmHistory.all.order(:id).reverse_order.limit(100)
	end
	def show
		@history_list = RtmmHistory.where(who: params[:id])
		@history = RtmmHistory.where.not(:category => "NULL").where(who: params[:id]).group(:category).count
	end
end
