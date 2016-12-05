class Rtmm::MessagesController < RtmmsController
	def index
		@groups = RtmmCategory.select("id","name").all
	end
	
	def edit
		@message = RtmmMessage.find(params[:id])
	end

	def update
	  @message = RtmmMessage.find(params[:id])
	  @message.messages = params[:rtmm_message][:messages]
	  @message.save!

	  redirect_to :action => :index
	end
end
