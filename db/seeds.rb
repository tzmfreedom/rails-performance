# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

content_types = (1..10).map do |i|
  ContentType.create(name: "contenttype_#{i}")
end

tags = (1..10).map do |i|
  Tag.create(name: "tag_#{i}")
end

authors = (1..3).map do |i|
  Author.create(name: "author_#{i}")
end

contents = []
contents_tags = []
comments = []
related_contents = []
(1..8000).each do |i|

  contents << Content.new(
      title: sprintf("title_%06d", i),
      body: sprintf("contents_%06d", i),
      content_type: content_types[i % 10]
  )
end

puts "contents loading..."
Content.import contents

contents = Content.order(title: :asc).to_a
contents.each do |content|
  related_contents << RelatedContent.new(content: content, related_content: contents.sample)

  contents_tags.push ContentsTag.new(content: content, tag: tags[content.id % 10]),
                     ContentsTag.new(content: content, tag: tags[(content.id+1) % 10]),
                     ContentsTag.new(content: content, tag: tags[(content.id+2) % 10])

  comments.push Comment.new(body: sprintf("body_%06d", content.id), content: content, author: authors[0]),
                Comment.new(body: sprintf("body_%06d", content.id), content: content, author: authors[1]),
                Comment.new(body: sprintf("body_%06d", content.id), content: content, author: authors[2])
end

puts "contents_tags loading..."
ContentsTag.import contents_tags
puts "comments loading..."
Comment.import comments
puts "related_contents loading..."
RelatedContent.import related_contents

