require 'cgi'
require 'redis'
require 'json'

STDOUT.sync = true
Thread.abort_on_exception = true

chat = CGI.new.params.fetch('chat').first
messages_key = "messages:#{chat}"
subscription_key = "subscription:#{chat}"

$redis = Redis.new(host: 'redis')
emoji = ['🐶', '🐱', '🐭', '🐹', '🐰', '🐻', '🐼', '🐨', '🐯', '🦁', '🐮', '🐷', '🐽', '🐸', '🐙', '🐵', '🙈', '🙉', '🙊', '🐒', '🐔', '🐧', '🐦', '🐤', '🐣', '🐥', '🐺', '🐗', '🐴', '🦄', '🐝', '🐛', '🐌', '🐞', '🐜', '🕷', '🦂', '🦀', '🐍', '🐢', '🐠', '🐟', '🐡', '🐬', '🐳', '🐋', '🐊', '🐆', '🐅', '🐃', '🐂', '🐄', '🐪', '🐫', '🐘', '🐐', '🐏', '🐑', '🐎', '🐖', '🐀', '🐁', '🐓', '🦃', '🕊', '🐕', '🐩', '🐈', '🐇', '🐿', '😀', '😬', '😁', '😂', '😃', '😄', '😅', '😆', '😇', '😉', '😊', '🙂', '🙃', '☺️', '😋', '😌', '😍', '😘', '😗', '😙', '😚', '😜', '😝', '😛', '🤑', '🤓', '😎', '🤗', '😏', '😶', '😐', '😑', '😒', '🙄', '🤔', '😳', '😞', '😟', '😠', '😡', '😔', '😕', '🙁', '☹️', '😣', '😖', '😫', '😩', '😤', '😮', '😱', '😨', '😰', '😯', '😦', '😧', '😢', '😥', '😪', '😓', '😭', '😵', '😲', '🤐', '😷', '🤒', '🤕', '😴', '💤', '💩', '😈', '👿', '👹', '👺', '💀', '👻', '👽', '🤖', '😺', '😸', '😹', '😻', '😼', '😽', '🙀', '😿', '🗿'].sample

$redis.lrange(messages_key, 0, 100).each do |message|
  puts(message)
end

Thread.new do
  Redis.new(host: 'redis').subscribe(subscription_key) do |subscription|
    subscription.message do |_, message|
      puts(message)
    end
  end
end

while body = STDIN.readline.strip
  message = JSON.parse(body).merge(author_emoji: emoji, created_at: Time.now.to_i)
  json = message.to_json
  $redis.rpush(messages_key, json)
  $redis.publish(subscription_key, json)
end
