class Links < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :url, null: false
      t.string :user, null: false, default: ''
      t.string :title, null: false, default: ''
      t.integer :clicks, null: false, default: 0
      t.string :content_type
      t.timestamps
    end
  end
end
