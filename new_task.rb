require 'bunny'

connection = Bunny.new(automatically_recover: false)
connection.start

channel = connection.create_channel

queue = channel.queue('task_queue', durable: true)

message = ARGV.empty? ? 'Suck it nerds!' : ARGV.join(' ')

queue.publish(message, persistent: true)

puts " [x] SENT #{message} "

connection.close
