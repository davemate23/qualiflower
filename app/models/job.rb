class Job < ApplicationRecord
	mount_uploader :image, ImageUploader
end
