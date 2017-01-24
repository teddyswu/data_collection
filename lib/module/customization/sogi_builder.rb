require "net/http"
require "cgi"
require "rexml/document"
require "nokogiri"

module SogiBuilder

  class Analysis    
    def self.rtmm_to_his
      rtmms = Rtmm.where(['created_at < ?', Time.now])
      rtmms.each do |rtmm|
        rh = RtmmHistory.new
        rh.who = rtmm.who
        rh.key = rtmm.key
        rh.val = rtmm.val
        rh.residence_time = 6
        rh.save!
        rtmm.destroy
      end
    end
    def self.rtmm_to_user
      rtmm_his = RtmmHistory.where(['created_at > ?', (Time.now - 1.day).strftime("%Y-%m-%d")]).find_each( :batch_size => 1000 ) do |rtmm_hi|
        rh = RtmmUser.find_or_create_by(who: rtmm_hi.who)
      end
    end
    def self.brand_analysis
      RtmmHistory.where.not(:who => "").where(:category => nil).find_each( :batch_size => 1000 ) do |history|
        history.category = "other"
        history.category = "samsung" if history.val.downcase.include?("samsung")
        history.category = "sony" if history.val.downcase.include?("sony")
        history.category = "asus" if history.val.downcase.include?("asus")
        history.category = "huawei" if history.val.downcase.include?("huawei")
        history.category = "htc" if history.val.downcase.include?("htc")
        history.category = "apple" if history.val.downcase.include?("apple")
        history.category = "apple" if history.val.downcase.include?("iPhone")
        history.category = "apple" if history.val.downcase.include?("iPad")
        history.save!
      end
    end
    def self.brand_other_analysis
      RtmmHistory.where.not(:who => "").where(:category => "other").find_each( :batch_size => 1000 ) do |history|
        history.category = "apple" if history.val.downcase.include?("apple")
        history.category = "apple" if history.val.downcase.include?("iPhone")
        history.category = "apple" if history.val.downcase.include?("iPad")
        history.save!
      end
    end
  end

  class Category
    def self.start
      RtmmUser.all.find_each( :batch_size => 100 ) do |user|
        history_all = RtmmHistory.where(:who => user.who).count
        history_curr = RtmmHistory.where(:who => user.who).where.not(:category => "other", :category => "apple").count
        if history_curr != 0
          user.category = 1 if (history_curr / history_all * 100) > RtmmCategory.first.total_percent.to_i
          user.save!
        end
        apple_curr = RtmmHistory.where(:who => user.who, :category => "apple").count
        apple_total_percent = RtmmCategory.find(2).total_percent.to_i
        if history_curr != 0
          user.category = 2 if ( apple_curr / history_all * 100) >  apple_total_percent
          user.save!
        end
      end
    end
  end

	#######################################################################################################################
  #######################################################################################################################
  #######################################################################################################################
  # 站台工作排程的log可以用此來記錄, task若沒有依賴environment就無法使用這個class了要注意一下
  # task若沒有依賴environment, 就無法使用所有Rails的class包含專案內的所有class都不能使用, 只能使用Ruby的class
  class CustomizedLog
    def self.write(file_name, string)
      File.open("#{Rails.root}/log/#{file_name}", "a+") do |file|
        file.syswrite(%(#{Time.now.iso8601}: #{string} \n---------------------------------------------\n\n))
      end
    end
  end
  #######################################################################################################################
  #######################################################################################################################
  #######################################################################################################################
end