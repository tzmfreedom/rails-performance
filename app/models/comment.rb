class Comment < ApplicationRecord
  belongs_to :content
  belongs_to :author
end
