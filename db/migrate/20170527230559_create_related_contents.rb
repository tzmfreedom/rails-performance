class CreateRelatedContents < ActiveRecord::Migration[5.1]
  def change
    create_table :related_contents do |t|
      t.references :content
      t.integer :related_contents_id
      t.timestamps
    end
  end
end
