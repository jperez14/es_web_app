class ProjectMessage < ActiveRecord::Base
	belongs_to :project

	def self.publish_all
		self.all.each do |project_message|

			begin 
				Publisher.publish("projects", JSON.parse(project_message.message))
				project_message.destroy
			rescue Bunny::Exception
				puts "Please make sure rake publish_messages is run again when the server is available"
			end
		end
	end
end
