require "net/http"
require "cgi"
require "rexml/document"
require "nokogiri"

module SogiBuilder

  class Analysis
    @assort = ""
    def self.history
      history = RtmmHistory.where.not(:who => "").where(:category => nil)
      history.each do |history|
        @assort = ""
        group(history)
        SogiBuilder::CustomizedLog.write("jobs.log", "history")
      end
    end

    def self.group(history)
      case history.key
      when "article"
        article = Article.find_by_url_keyword(history.val)
        if article.created_at + 5.days < Time.now #最新科技
          @assort << "1"
          position(history)
          SogiBuilder::CustomizedLog.write("jobs.log", "group")
        end
      when "product"
        case history.val
        when /apple/
          history.category = 15
          history.save
        when /samsung/
          history.category = 16
          history.save
        when /sony/
          history.category = 17
          history.save
        when /htc/
          history.category = 18
          history.save
        when /nokia/
          history.category = 20
          history.save
        when /mobia/
          history.category = 20
          history.save
        when /小米/
          history.category = 19
          history.save
        end
      end
    end

    def self.position(history)
      @assort << "0"
      price(history)
      SogiBuilder::CustomizedLog.write("jobs.log", "position")
    end

    def self.price(history)
      @assort << "0"
      brand_preference(history)
      SogiBuilder::CustomizedLog.write("jobs.log", "price")
    end

    def self.brand_preference(history)
      @assort << "0"
      product_color(history)
    end

    def self.product_color(history)
      @assort << "0"
      prefecture(history)
    end

    def self.prefecture(history)
      @assort << "0"
      other_prefecture(history)
    end
    
    def self.other_prefecture(history)
      @assort << "0"
      set_cate(history)
    end

    def self.set_cate(history)
      id = RtmmCategory.first.id
      history.category = id
      history.save
    end
  end

  class Category
    def self.start
      users = RtmmUser.where(category: nil)
      users.each do |user|
        history = RtmmHistory.where(:who => user.who).group(:category).count
        sorthash = Hash[history.sort_by{|key, val|val}]
        sorttop = sorthash.keys.last
        user.category = sorttop
        user.save
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