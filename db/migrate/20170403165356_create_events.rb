class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :tag
      t.string :repeat
      t.boolean :payed, default: false
      t.boolean :booked, default: false

      t.timestamps
    end
  end
end
