# uri = ENV["REDISTOGO_URL"] || "redis://localhost:6379/" if Rails.env = "test"

uri =  "redis://redistogo:d75f4da8cefca8ba1a5652b5b8d3d1c3@jack.redistogo.com:9471/"

REDIS = Redis.new(:url => uri)
