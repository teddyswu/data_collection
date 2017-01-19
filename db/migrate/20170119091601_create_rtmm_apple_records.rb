class CreateRtmmAppleRecords < ActiveRecord::Migration
  def change
    create_table :rtmm_apple_records do |t|
    	t.string 		:who
    	t.datetime 	:date

      t.timestamps null: false
    end
  end
end
