class CreateGame < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :genre
      t.string :publisher
      t.string :developer
    end
  end
end
