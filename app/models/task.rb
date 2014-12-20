class Task < ActiveRecord::Base
	validates :title,  presence: true, length: { maximum: 20 }
	validates :description, length: { minimum: 30 }, allow_blank: true

  belongs_to :user
end
