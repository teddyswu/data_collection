class ChangAppleRecordDateType < ActiveRecord::Migration
  def change
  	RtmmAppleRecord.destroy_all
  	change_column :rtmm_apple_records, :date, :date
  end
end
