class CreateContentsTags < ActiveRecord::Migration[5.1]
  def change
    create_table :contents_tags do |t|
      t.references :content
      t.references :tag
      t.timestamps
    end
  end
end
