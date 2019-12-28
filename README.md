# Merah

Merah is a JVM implementation by Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'merah'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install merah

## Usage

```
$ (bundle exec) merah <prath/to/your/classfile>
```

## Reference
[RubyでJVMを実装してみる (平成Ruby会議01発表スライド)](https://speakerdeck.com/daikimiura/implement-jvm-with-ruby)

## TODO
`./tmp/exec.rb`を`jrubyc`コマンドでClassFileに変換した`./tmp/exec.class`を評価できるようにする(セルフホストもどき).
 
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/merah. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Merah project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/merah/blob/master/CODE_OF_CONDUCT.md).
