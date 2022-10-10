class Quotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.string :quote, null: false
      t.string :author, null: false
      t.timestamps
    end
  end
end
