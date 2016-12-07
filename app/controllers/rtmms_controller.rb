class RtmmsController < ApplicationController
	skip_before_filter :verify_authenticity_token
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
	  end
	  user = RtmmUser.find_or_create_by(who: who)
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

	def data_ana
		@user = RtmmUser.where.not(:category => nil).count
		all_total = RtmmHistory.where.not(:category => nil, :category=> "other").count
		htc_total = RtmmHistory.where(:category => "htc").count
		samsung_total = RtmmHistory.where(:category => "samsung").count
		sony_total = RtmmHistory.where(:category => "sony").count
		asus_total = RtmmHistory.where(:category => "asus").count
		huawei_total = RtmmHistory.where(:category => "huawei").count
		@htc = htc_total != 0 ? ( htc_total.to_f / all_total.to_f * 100) : 0
		@samsung = samsung_total != 0 ? ( samsung_total.to_f / all_total.to_f * 100) : 0
		@sony = sony_total != 0 ? ( sony_total.to_f / all_total.to_f * 100) : 0
		@asus = asus_total != 0 ? ( asus_total.to_f / all_total.to_f * 100) : 0
		@huawei = huawei_total != 0 ? ( huawei_total.to_f / all_total.to_f * 100) : 0
	end

  def get_msg
  	message = ""
  	if params[:who].present?
  		who = Digest::MD5.hexdigest(params[:who]).downcase
  		user = RtmmUser.find_by_who(who)
  		message = user.rtmm_category.rtmm_message.messages if user.present? && user.try(:rtmm_category).present?
  	  RtmmRecord.find_or_create_by(who: who, date: Time.now.strftime('%Y-%m-%d')) if message != ""
  	end
  	render :text => message
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
