class CreateBlog < ActiveRecord::Migration[7.1]
  def change
    create_table :blogs do |t|
      t.integer :user_id
      t.string :title
      t.text :content
      
      t.timestamps
    end
  end
end
