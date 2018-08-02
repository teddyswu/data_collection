class RtmmsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	skip_before_action :authenticate_user!, :only => [:get_data, :del_data, :get_msg]

	caches_action :index, :cache_path => Proc.new {
    cache_path = "#{request.path}_index_action_cache"
  }, :expires_in => 12.hour, :layout => false

  caches_action :data_cht, :cache_path => Proc.new {
    cache_path = "#{request.path}_data_cht_action_cache"
  }, :expires_in => 12.hour, :layout => false

  caches_action :data_apple, :cache_path => Proc.new {
    cache_path = "#{request.path}_data_apple_action_cache"
  }, :expires_in => 12.hour, :layout => false

	def index
		@category = RtmmCategory.all
		@history  = RtmmHistory.all
		@user     = RtmmUser.all
		@daycount = RtmmHistory.find_by_sql("select SUBSTRING(IFNULL(created_at,''),1,10) as sdate, COUNT(SUBSTRING(IFNULL(created_at,''),1,10)) as pa from `rtmm_histories` group by SUBSTRING(IFNULL(created_at,''),1,10)").last(7)
	end
	def get_data
		who = Digest::MD5.hexdigest(params[:who].to_s).downcase
		#check_rtmm = RtmmUser.find_by_who(who)
    #if check_rtmm.present?
			rtmm = Rtmm.new
	    rtmm.who = who
	    rtmm.key = params[:key].to_s
	    rtmm.val = params[:val].to_s
	    rtmm.save!
	  #else
	  # 	i = 1
	  # 	loop do
	  # 		i += 1
	  # 		who = who + i.to_s
	  # 		break if Rtmm.where(:who => who).blank?
	  # 	end
	  # 	rtmm = Rtmm.new
	  #   rtmm.who = who[0..253]
	  #   rtmm.key = params[:key].to_s
	  #   rtmm.val = params[:val].to_s
	  #   rtmm.save!	
	  # end
	 #  if ['samsung','sony','asus','huawei','htc'].any? { |word| params[:val].to_s.downcase.include?(word) }
		#   user = RtmmUser.find_or_create_by(who: who)
		#   user.category = 1
		#   user.save
		# end
    render :text => ""
  end
  def del_data
		if params[:who].present? & params[:key].present? & params[:val].present?
      who = Digest::MD5.hexdigest(params[:who][0..253]).downcase
      key = params[:key].to_s
      val = params[:val].to_s
			# rtmm = Rtmm.where(:who => who, :key => key, :val => val)
			# rtmm.destroy_all
			history = RtmmHistory.new
			history.who = who
			history.key = key
			history.val = val
			history.residence_time = params[:residence_time].to_s
			history.save
			# user = RtmmUser.find_or_create_by(who: who)
			# user.is_online = false
			# user.save
		end
		render :text => ""
	end

	def data_list
		@ta = RtmmCategory.all
	end

	def data_apple
		@user 				= RtmmUser.where(:category => "apple").count
		all_total 		= RtmmHistory.where.not(:category => nil, :category=> "other").count
		htc_total 		= RtmmHistory.where(:category => "htc").count
		samsung_total = RtmmHistory.where(:category => "samsung").count
		sony_total 		= RtmmHistory.where(:category => "sony").count
		asus_total 		= RtmmHistory.where(:category => "asus").count
		huawei_total 	= RtmmHistory.where(:category => "huawei").count
		apple_total 	= RtmmHistory.where(:category => "apple").count
		other_total 	= RtmmHistory.where(:category => "other").count
		all_in_other_total = RtmmHistory.where.not(:category => nil).count
		
		@htc 					= htc_total != 0 ? ( htc_total.to_f / all_total.to_f * 100) : 0
		@samsung 			= samsung_total != 0 ? ( samsung_total.to_f / all_total.to_f * 100) : 0
		@sony 				= sony_total != 0 ? ( sony_total.to_f / all_total.to_f * 100) : 0
		@asus 				= asus_total != 0 ? ( asus_total.to_f / all_total.to_f * 100) : 0
		@huawei 			= huawei_total != 0 ? ( huawei_total.to_f / all_total.to_f * 100) : 0
		@apple 				= apple_total != 0 ? ( apple_total.to_f / all_total.to_f * 100) : 0

		@htc_o 				= htc_total != 0 ? ( htc_total.to_f / all_in_other_total.to_f * 100) : 0
		@samsung_o 		= samsung_total != 0 ? ( samsung_total.to_f / all_in_other_total.to_f * 100) : 0
		@sony_o 			= sony_total != 0 ? ( sony_total.to_f / all_in_other_total.to_f * 100) : 0
		@asus_o 			= asus_total != 0 ? ( asus_total.to_f / all_in_other_total.to_f * 100) : 0
		@huawei_o 		= huawei_total != 0 ? ( huawei_total.to_f / all_in_other_total.to_f * 100) : 0
		@other 				= other_total != 0 ? ( other_total.to_f / all_in_other_total.to_f * 100) : 0
		@apple_o 			= apple_total != 0 ? ( apple_total.to_f / all_in_other_total.to_f * 100) : 0
	end

	def data_cht
		@user = RtmmUser.where.not(:category => nil).count
		all_total = RtmmHistory.where.not(:category => nil, :category=> "other").count
		htc_total = RtmmHistory.where(:category => "htc").count
		samsung_total = RtmmHistory.where(:category => "samsung").count
		sony_total = RtmmHistory.where(:category => "sony").count
		asus_total = RtmmHistory.where(:category => "asus").count
		huawei_total = RtmmHistory.where(:category => "huawei").count
		other_total = RtmmHistory.where(:category => "other").count
		all_in_other_total = RtmmHistory.where.not(:category => nil).count
		
		@htc = htc_total != 0 ? ( htc_total.to_f / all_total.to_f * 100) : 0
		@samsung = samsung_total != 0 ? ( samsung_total.to_f / all_total.to_f * 100) : 0
		@sony = sony_total != 0 ? ( sony_total.to_f / all_total.to_f * 100) : 0
		@asus = asus_total != 0 ? ( asus_total.to_f / all_total.to_f * 100) : 0
		@huawei = huawei_total != 0 ? ( huawei_total.to_f / all_total.to_f * 100) : 0

		@htc_o = htc_total != 0 ? ( htc_total.to_f / all_in_other_total.to_f * 100) : 0
		@samsung_o = samsung_total != 0 ? ( samsung_total.to_f / all_in_other_total.to_f * 100) : 0
		@sony_o = sony_total != 0 ? ( sony_total.to_f / all_in_other_total.to_f * 100) : 0
		@asus_o = asus_total != 0 ? ( asus_total.to_f / all_in_other_total.to_f * 100) : 0
		@huawei_o = huawei_total != 0 ? ( huawei_total.to_f / all_in_other_total.to_f * 100) : 0
		@other = other_total != 0 ? ( other_total.to_f / all_in_other_total.to_f * 100) : 0

		@daycount = RtmmRecord.find_by_sql("select SUBSTRING(IFNULL(date,''),1,10) as rdate, COUNT(SUBSTRING(IFNULL(date,''),1,10)) as pa from `rtmm_records` group by SUBSTRING(IFNULL(date,''),1,10)")
	end

  def get_msg
  	message = ""
  	if params[:who].present?
  		who = Digest::MD5.hexdigest(params[:who][0..253]).downcase
  		user = RtmmUser.find_by_who(who)
  		if user.present?
				cat = user.rtmm_category 
				message = RtmmMessage.where(rtmm_category_id: cat).enabled[0].try(:messages) if user.rtmm_category.present?
			end
  		#RtmmRecord.find_or_create_by(who: who, date: Time.now.strftime('%Y-%m-%d')) if message != "" or message != nil
  		RtmmAppleRecord.find_or_create_by(who: who, date: Time.now.strftime('%Y-%m-%d')) if message != "" and message != nil
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
