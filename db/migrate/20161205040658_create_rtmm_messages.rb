class CreateRtmmMessages < ActiveRecord::Migration
  def change
    create_table :rtmm_messages do |t|
    	t.integer :rtmm_category_id
    	t.text		:messages

      t.timestamps null: false
    end
  end
end
