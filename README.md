# ruby-llog

An extension of ruby's built in logger which implements our logging spec and
allows for a key/value hash to be passed into all logging functions (while still
being backwards compatible). See [go-llog](https://github.com/levenlabs/go-llog)
for more on the log spec itself.

## Usage

```ruby
require("levenlabs/llog")

l = LLog::Logger.new
l.info("OHAI")
l.info("this is a test", {:a => "foo", :b => "bar\""})
# blocks will be evaluated only if this log would actually be shown
l.warn("") { "some nonsense" }
l.info("", {:a => "ok"}) { "some nonsense" }
```
