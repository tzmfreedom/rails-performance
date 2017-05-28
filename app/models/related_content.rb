class RelatedContent < ApplicationRecord
  belongs_to :content
  belongs_to :related_content, class_name: 'Content', foreign_key: 'related_contents_id'
end
