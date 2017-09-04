json.extract! micropost, :id, :contents, :uid, :created_at, :updated_at
json.url micropost_url(micropost, format: :json)
