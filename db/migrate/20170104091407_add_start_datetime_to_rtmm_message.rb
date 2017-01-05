class AddStartDatetimeToRtmmMessage < ActiveRecord::Migration
  def change
  	add_column :rtmm_messages, :start_date, :datetime
  	add_column :rtmm_messages, :end_date, :datetime
  end
end
