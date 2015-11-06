class CreateRtmms < ActiveRecord::Migration
  def change
    create_table :rtmms do |t|
    	t.string 	:who
    	t.string 	:key
    	t.string	:val
      t.integer	:rtmm_category

      t.timestamps null: false
    end
  end
end
