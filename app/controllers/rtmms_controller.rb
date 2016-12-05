class RtmmsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :set_cors_header
	before_action :authenticate_user!, :except => [:get_data, :del_data, :get_msg]
	def index
		@category = RtmmCategory.all
		@history  = RtmmHistory.all
		@user     = RtmmUser.all
		@daycount 			= RtmmHistory.find_by_sql("select SUBSTRING(IFNULL(created_at,''),1,10) as sdate, COUNT(SUBSTRING(IFNULL(created_at,''),1,10)) as pa from `rtmm_histories` group by SUBSTRING(IFNULL(created_at,''),1,10)").last(7)
	end
	def get_data
		who = Digest::MD5.hexdigest(params[:who]).downcase
		check_rtmm = RtmmUser.find_by_who(who)
    if check_rtmm.present?
			rtmm = Rtmm.new
	    rtmm.who = who
	    rtmm.key = params[:key].to_s
	    rtmm.val = params[:val].to_s
	    rtmm.save!
	  else
	  	i = 1
	  	loop do
	  		i += 1
	  		who = who + i.to_s
	  		break if Rtmm.where(:who => who).blank?
	  	end
	  	rtmm = Rtmm.new
	    rtmm.who = who
	    rtmm.key = params[:key].to_s
	    rtmm.val = params[:val].to_s
	    rtmm.save!	
	    user = RtmmUser.find_or_create_by(who: who) 
	  end
	  user.is_online = true
	  user.save
    render :text => ""
  end
  def del_data
		if params[:who].present? & params[:key].present? & params[:val].present?
      who = Digest::MD5.hexdigest(params[:who]).downcase
      key = params[:key].to_s
      val = params[:val].to_s
			rtmm = Rtmm.where(:who => who, :key => key, :val => val)
			rtmm.destroy_all
			history = RtmmHistory.new
			history.who = who
			history.key = key
			history.val = val
			history.residence_time = params[:residence_time].to_s
			history.save
			user = RtmmUser.find_or_create_by(who: who)
			user.is_online = false
			user.save
		end
		render :text => ""
	end
  def get_msg
  	message = ""
  	if params[:who].present?
  		who = Digest::MD5.hexdigest(params[:who]).downcase
  		user = RtmmUser.find_by_who(who)
  		message = user.rtmm_category.rtmm_message.messages if user.present? && user.try(:rtmm_category).present?
  	end
  	render :text => message
  end
   
	def set_cors_header
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
	end
	def talk
  	who = params[:who].to_s
  	@ad_msg = AdMsg.where(["to_user = ? or from_user = ?", who, who]).order("created_at DESC").limit(3).reverse
		render :layout => false
  end

  def cate_params
  	params.require(:ad_msg).permit(:msg,:to_user, :from_user)
  end
end
