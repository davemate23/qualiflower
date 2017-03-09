json.extract! job_category, :id, :name, :description, :entry, :tasks, :related, :ancestry, :created_at, :updated_at
json.url job_category_url(job_category, format: :json)