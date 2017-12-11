# Ufebs

Обертка для XML форматов УФЕБС 2018 и 2017 годов. Для валидации и сборки XML используются Nokogiri и HappyMapper

!!!UNDER DEVELOPMENT!!!

## Installation

Добавить в Gemfile:

```ruby
gem 'ruby_ufebs'
```

Затем:

    $ bundle

Или:

    $ gem install ruby_ufebs

## Usage

Configuration:

```
Ufebs.configure do |config|
  config.standard = '2018'  # использовать стандарты УФЕБС 2018
end
```

ED101:

```ruby

```

## Development

Сначала: `bundle`
Guard: `guard`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/creepycheese/ruby_ufebs