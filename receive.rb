require 'bunny'

connection = Bunny.new
connection.start

channel = connection.create_channel

queue = channel.queue('hello')

begin
  puts ' [w] Waiting for messages. To exit yada yada'
  puts '----------------------------------------------'
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    puts " [x] Received #{body} "
    puts " [y] delivery info: #{_delivery_info} "
    puts " [z] properties #{_properties} "
  end
rescue Interrupt => _
  puts " -------- so long sucker! --------- "
  connection.close
  exit(0)
end