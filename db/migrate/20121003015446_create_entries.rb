class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :name
      t.integer :priority
      t.references :user
      t.timestamps
    end
  end
end
