class CreateContents < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      t.string :title
      t.text :body
      t.references :content_type
      t.references :author
      t.timestamps
    end
  end
end
