require 'cgi'
require 'redis'
require 'json'

STDOUT.sync = true

$redis = Redis.new(host: 'redis')

puts({ body: 'hey everyone', message_type: 'message', author_emoji: '😚' }.to_json)
puts({ body: 'hey everyone', message_type: 'message', author_emoji: '😚' }.to_json)
puts({ body: 'hey everyone', message_type: 'message', author_emoji: '😚' }.to_json)
puts({ body: 'hey everyone', message_type: 'message', author_emoji: '😚' }.to_json)
puts({ body: 'hey everyone', message_type: 'message', author_emoji: '😚' }.to_json)
100.times do
  puts({ body: 'hey everyone', message_type: 'message', author_emoji: '😚' }.to_json)
end

# puts $redis.inspect

while foo = STDIN.readline.strip
  puts eval(foo).inspect
end


# $redis.rpush 'chat:room', { body: '', message_type '', author_emoji: '' }.to_json
