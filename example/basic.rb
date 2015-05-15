require "jruby-stdin-channel"

stdin = StdinChannel::Reader.new
puts("> starting")

trap('INT') do
  puts("\n> INT")
  Thread.new{stdin.close}
end

begin
  loop do
    data = stdin.read(1024)
    puts("> read:#{data.inspect}")
  end
rescue EOFError
  puts("> EOF")
rescue => e
  puts("> exception e=#{e.inspect}")
ensure
  puts("> end")
end
