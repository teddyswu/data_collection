class Rtmm::CustomerBaseController < RtmmsController
  before_filter :get_option, :only => [:new, :edit]

	def index
		@cate = RtmmCategory.all
	end
	
  def new 
  	@cate = RtmmCategory.new
  end

  def create
  	@cate = RtmmCategory.new(cate_params)
    @cate.save

    redirect_to rtmm_customer_base_index_path
  end

  def edit
    @cate = RtmmCategory.find(params[:id])
  end

  def update
    @cate = RtmmCategory.find(params[:id])
    @cate.update(cate_params)

    redirect_to rtmm_customer_base_index_path
  end

  def get_option
    @brand_preference = RtmmBrandPreference.all
    @group            = RtmmGroup.all
    @position         = RtmmPosition.all
    @price            = RtmmPrice.all
    @product_color    = RtmmProductColor.all
    @prefecture       = RtmmPrefecture.all
    @other_prefecture = RtmmOtherPrefecture.all
  end

  private

  def cate_params
    params.require(:rtmm_category).permit(:name, :group, :position, :price, :brand_preference, :product_color, :prefecture, :other_prefecture)
  end
end
