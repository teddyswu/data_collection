class CreateRtmmRecords < ActiveRecord::Migration
  def change
    create_table :rtmm_records do |t|
    	t.string 		:who
    	t.datetime 	:date

      t.timestamps null: false
    end
  end
end
