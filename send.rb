require 'bunny'

connection = Bunny.new
connection.start

channel = connection.create_channel

queue = channel.queue('hello')

channel.default_exchange.publish('eat shit nerds', routing_key: queue.name)

puts " [x] SENT 'HELLO WORLD!' "

connection.close
