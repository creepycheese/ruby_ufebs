# Ufebs

Обертка для XML форматов УФЕБС 2018 и 2017 годов. Для валидации и сборки XML используются Nokogiri и HappyMapper.

[Форматы](http://www.cbr.ru/analytics/?PrtId=Formats)

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

## Generate doc

```sh
yard doc
```

## Usage

Configuration:

```
Ufebs.configure do |config|
  config.standard = '2018'  # использовать стандарты УФЕБС 2018
end
```

ED101:

```ruby
ed101 = Ufebs::ED101(
  number: 7,
  sum: 150000,
  receipt_date: Time.now,
  acc_doc: { number: '3', date: Time.now },
  purpose: 'оплата в том числе ндс 4000 руб',
  payer: {
    name: 'ООО ТЕСТ',
    account: '40702810200203001037',
    inn: '7726274727',
    bank_bic: '044525545',
    bank_account: '30101810300000000545'
  },
  payee: {
    name: 'ООО ТЕСТ',
    account: '40702810200203001037',
    inn: '7726274727',
    bank_bic: '044525545',
    bank_account: '30101810300000000545'
  },
  departmental_info: {
    kbk: '18210301000010000110',
    okato: '45263591000',
    drawer_status: '01',
    tax_period: 'МС.03.2017',
    tax_payt_kind: 'НС',
    doc_no: '111',
    payt_reason: 'ТП'
  }
)
```

# вывод в UTF-8

```ruby
puts ed101.to_xml(Nokogiri::XML::Builder.new(encoding: 'UTF-8'), nil, nil).to_xml
```

```
 <?xml version="1.0" encoding="UTF-8"?>
 <ed:ED101 xmlns:ed="urn:cbr-ru:ed:v2.0" EDNo="7" EDDate="2017-12-11" EDAuthor="4525595000" Sum="150000" TransKind="01" ChargeOffDate="2017-12-11" ReceiptDate="2017-12-11" SystemCode="01" Priority="0">
   <ed:AccDoc AccDocNo="003" AccDocDate="2017-12-11"/>
   <ed:Payer INN="7726274727" PersonalAcc="40702810200203001037">
     <ed:Name>ООО ТЕСТ</ed:Name>
     <ed:Bank BIC="044525545" CorrespAcc="30101810300000000545"/>
   </ed:Payer>
   <ed:Payee INN="7726274727" PersonalAcc="40702810200203001037">
     <ed:Name>ООО ТЕСТ</ed:Name>
     <ed:Bank BIC="044525545" CorrespAcc="30101810300000000545"/>
   </ed:Payee>
   <ed:Purpose>оплата в том числе ндс 4000 руб</ed:Purpose>
   <ed:DepartmentalInfo CBC="18210301000010000110" OKATO="45263591000" TaxPeriod="МС.03.2017" DrawerStatus="01" PaytReason="ТП" DocNo="111" TaxPaytKind="НС" DocDate="2017-12-11"/>
 </ed:ED101>
```

## Development
Форкните гем.

Сначала: `bundle`
Guard: `guard`
Тесты: `rake test`
Консолб `bin/console`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/creepycheese/ruby_ufebs
