json.id topic.id
json.title topic.title
json.content topic.content
json.user do
  json.id topic.user.id
  json.display_name topic.user.display_name
  json.email topic.user.email
end
json.views_count topic.views_count

json.photo_original_url asset_url(topic.photo.url)
json.photo_medium_url asset_url(topic.photo.url(:medium))
json.photo_thumb_url asset_url(topic.photo.url(:thumb))

json.photo_file_name topic.photo_file_name
json.photo_content_type topic.photo_content_type
json.photo_file_size topic.photo_file_size
json.photo_updated_at topic.photo_updated_at

json.created_at topic.created_at
json.updated_at topic.updated_at
