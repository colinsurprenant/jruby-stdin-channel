# jruby-stdin-channel

JRuby Java extension gem which extracts an *interruptible* FileChannel from Java `System.in` *stdin*. Using this gem, calling `close` on the blocking `read` method will unblock it, unlike the normal JRuby `$stdin`.

Escaping the blocking read using `close` **only works with Java 8**. When using Java 7, the behaviour is identical to the normal JRuby `$stdin` where an input character needs to be typed for the read method to unblock.

## Background

This was created to help solve an issue in [logstash](http://github.com/elastic/logstash) with the stdin input plugin that prevents normally exiting logstash upon `SIGINT` or `SIGTERM`. See https://github.com/elastic/logstash/issues/1769 for details.

## Installation

```ruby
gem "jruby-stdin-channel"
```

## Usage

```ruby
stdin = StdinChannel::Reader.new

# blocking reads stdin upto a maximum of 1024 bytes, similar to IO#sysread
data = stdin.read(1024)

# close stdin to unblock read
stdin.close
```

## Example


```ruby
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
rescue => e
  puts("> exception e=#{e.inspect}")
end
puts("> end")
```


## Author
**Colin Surprenant**
* http://github.com/colinsurprenant/
* [@colinsurprenant](http://twitter.com/colinsurprenant/)
* colin.surprenant@gmail.com
* http://colinsurprenant.com/

## License
Apache License, Version 2.0. See the `LICENSE.md` file.