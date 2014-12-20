class Task < ActiveRecord::Base
  belongs_to :user
	validates :title,  presence: true, length: { maximum: 20 }
	validates :description, length: { minimum: 5 }, allow_blank: true

	def self.cleanup
    @tasks = user.tasks.all
    @tasks.each do |task|
	    if task.complete_date
	      task.destroy if task.complete_date < 30.days.ago
	    end
    end
	end
end
