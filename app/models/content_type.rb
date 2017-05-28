class ContentType < ApplicationRecord
  has_many :contents
  has_many :conditional_contents, -> {
    where('id < ?', 1000)
  }, class_name: 'Content'

end
