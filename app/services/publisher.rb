class Publisher
	# basic RabbitMQ fanout exchange, it publishes message to all listening
	def self.publish(exchange, message = {})
		exchange = channel.fanout("project.#{exchange}")
		
		exchange.publish(message.to_json, :persistent => true)
	end

	def self.channel
		@channel ||= connection.create_channel
	end

	def self.connection
		@connection ||= Bunny.new.tap do |c|
			c.start
		end
	end
end
