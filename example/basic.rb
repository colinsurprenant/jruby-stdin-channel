require "jruby-stdin-channel"

stdin = StdinChannel::Reader.new

trap('INT') do
  puts("\n> INT")
  Thread.new{stdin.close}
end

puts("> start")
begin
  loop do
    data = stdin.read(1024)
    puts("> read:#{data.inspect}")
  end
rescue EOFError
  puts("> EOF")
rescue StdinChannel::ClosedChannelError
  puts("> closed")
rescue => e
  puts("> exception e=#{e.inspect}")
end
puts("> end")
