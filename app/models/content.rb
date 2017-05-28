class Content < ApplicationRecord
  belongs_to :content_type
  has_many :comments
  has_many :contents_tags
  has_many :related_contents
  has_many :tags, through: :contents_tags
  has_many :related, through: :related_contents, source: :related_content

  has_many :conditional_comments, -> {
    joins(:author).where(author_id: 1)
  }, class_name: 'Comment'
end