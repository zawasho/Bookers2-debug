class CreateBookIds < ActiveRecord::Migration[5.2]
  def change
    create_table :book_ids do |t|

      t.timestamps
    end
  end
end
