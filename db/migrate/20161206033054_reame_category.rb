class ReameCategory < ActiveRecord::Migration
  def change
  	rename_column :rtmm_categories, :group, :keyword_one
		rename_column :rtmm_categories, :position, :keyword_two
		rename_column :rtmm_categories, :price, :keyword_three
		rename_column :rtmm_categories, :brand_preference, :keyword_four
		rename_column :rtmm_categories, :product_color, :keyword_five
		rename_column :rtmm_categories, :prefecture, :total_percent
  end
end
