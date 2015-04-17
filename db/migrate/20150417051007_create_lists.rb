class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name, :required => true
      t.timestamps
    end
  end
end
