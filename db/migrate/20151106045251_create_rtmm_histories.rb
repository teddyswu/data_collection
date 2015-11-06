class CreateRtmmHistories < ActiveRecord::Migration
  def change
    create_table :rtmm_histories do |t|
    	t.string	:who
      t.string 	:key
      t.string	:val
      t.integer	:residence_time
    	t.string	:category

      t.timestamps null: false
    end
  end
end
