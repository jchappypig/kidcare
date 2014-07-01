json.array!(@stories) do |story|
  json.extract! story, :id, :title, :content, :time_line
  json.url story_url(story, format: :json)
end
