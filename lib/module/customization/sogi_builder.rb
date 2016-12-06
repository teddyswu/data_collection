require "net/http"
require "cgi"
require "rexml/document"
require "nokogiri"

module SogiBuilder

  class Analysis    
    def self.brand_analysis
      historys = RtmmHistory.where.not(:who => "").where(:category => nil)
      historys.each do |history|
        history.category = "other"
        history.category = "samsung" if history.val.downcase.include?("samsung")
        history.category = "sony" if history.val.downcase.include?("sony")
        history.category = "asus" if history.val.downcase.include?("asus")
        history.category = "huawei" if history.val.downcase.include?("huawei")
        history.category = "htc" if history.val.downcase.include?("htc")
        history.save!
      end
    end
  end

  class Category
    def self.start
      users = RtmmUser.where(category: nil)
      users.each do |user|
        history_all = RtmmHistory.where(:who => user.who).count
        history_curr = RtmmHistory.where(:who => user.who).where.not(:category => "other").count
        if history_curr != 0
          user.category = 1 if (history_curr / history_all * 100) > RtmmCategory.first.total_percent.to_i
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