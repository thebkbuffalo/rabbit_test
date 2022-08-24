require 'bunny'

connection = Bunny.new(automatically_recover: false)
connection.start

channel = connection.create_channel

queue = channel.queue('task_queue', durable: true)

begin
  puts ' [w] Waiting for messages. To exit yada yada'
  puts '----------------------------------------------'
  queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, body|
    puts "-------------------------------------------------------"
    puts " [x] Received Message - #{body} "
    # puts " [y] delivery info: #{_delivery_info} "
    # puts " [z] properties #{_properties} "
    # imitading a large task with sleep
    sleep body.count('.').to_i
    puts " - task is done - "
    channel.ack(delivery_info.delivery_tag)
    puts "Deliver Ack info #{delivery_info.delivery_tag}"
    puts "-------------------------------------------------------"
  end
rescue Interrupt => _
  puts " -------- so long sucker! --------- "
  connection.close
  # exit(0)
end