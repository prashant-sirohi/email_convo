class CreateEmailers < ActiveRecord::Migration
  def change
    create_table :emailers do |t|

      t.timestamps null: false
    end
  end
end
