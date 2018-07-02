# simpleSlack

TODO: Write a description here

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  simpleSlack:
    github: a3104/CrystalSimpleSlack
```

## Usage

```crystal
require "simpleSlack"

  slack = SimpleSlack::Notifier.new("#{INGRESS_HOOK_URL}")
  slack.send("#test_channel", "test_user", "test message", ":ghost:")

```



## Contributing

1. Fork it (<https://github.com/a3104/simpleSlack/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [a3104 (https://github.com/a3104)  - creator, maintainer
