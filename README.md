# Inflector (port of dry-inflector) [![Build Status](https://travis-ci.org/phoffer/inflector.cr.svg?branch=master)](https://travis-ci.org/phoffer/inflector.cr)

This is an attempt to bring Dry::Inflector Inflector](https://github.com/dry-rb/ry-inflector) to Crystal. 

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
    inflector:
    github: dsisnero/dry-inflector.cr
    version: "~> 0.1.8"
```

Somewhere in your app initialization, `require "dry-inflector"`.

Inflector.cr passes specs with Crystal versions starting at `0.17.4` and continuing through `0.24.2`.

Additionally, there are core extensions to `String` and `Int`. If you want these, then `require "inflector/core_ext` instead of the standard `require`.

## Usage

Some examples are probably best. There is a full set of examples in spec/inflector/readme_spec.cr

```crystal
inflector = Dry::Inflector.new
inflector.camelize("active_model")                    # => "ActiveModel"
inflector.underscore("ActiveModel")                   # => "active_model"
inflector.humanize("employee_salary")                 # => "Employee salary"
inflector.humanize("author_id")                       # => "Author"
inflector.upcase_first("what a Lovely Day")           # => "What a Lovely Day"
inflector.titleize("x-men: the last stand")           # => "X Men: The Last Stand"
inflector.classify("ham_and_eggs")                    # => "HamAndEgg"
inflector.demodulize("CoreExt::String::Inflections")  # => "Inflections"
inflector.deconstantize("Net::HTTP")                  # => "Net"
inflector.foreign_ey("Message")                      # => "message_id"
inflector.ordinalize(1)                               # => "1st"
inflector.ordinal(1)                                  # => "st"
inflector.dasherize("puni_puni")                      # => "puni-puni"
```


## TODO

- [ ] Enable additional tests (tests have been mostly ported from ActiveSupport::Inflector)
- [x] Hook up Travis CI

## Contributing

1. Fork it ( https://github.com/dsisnero/dry-inflector.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [dry-rb](https://dry-rb) Dry-Rb Core Team is greatly appreciated for what they have built and extensive documentation
- [dsisnero](https://github.com/dsisnero) Paul Hoffer - creator, maintainer

## License

See `LICENSE` file.
