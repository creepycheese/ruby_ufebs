# frozen_string_literal: true

module Ufebs
  module Entities
    class DateTimeInterval
      include HappyMapper
      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      namespace 'ed'

      attribute :begin_time, String, tag: 'BeginTime'
      attribute :end_time, String, tag: 'EndTime'

      def initialize(begin_time: Time.now, end_time: Time.now)
        @begin_time = DateTime.parse(begin_time.to_s).strftime('%Y-%m-%dT%H:%M:%SZ')
        @end_time = DateTime.parse(end_time.to_s).strftime('%Y-%m-%dT%H:%M:%SZ')
      end
    end

    class BusinessDay
      include HappyMapper

      attribute :abstract_date, String, tag: 'AbstractDate'

      def initialize(abstract_date: '')
        @abstract_date = Date.parse(abstract_date.to_s).strftime('%Y-%m-%d')
      end
    end

    class RequestInfo
      include HappyMapper
      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      namespace 'ed'

      attribute :bic, String, tag: 'BIC'
      attribute :correspondent_account, String, tag: 'CorrespAcc'
      attribute :sum, Integer, tag: 'Sum'
      attribute :liquidity_trans_kind, String, tag: 'LiquidityTransKind'

      has_one :date_time_interval, DateTimeInterval, tag: 'DateTimeInterval'
      has_one :business_day, BusinessDay, tag: 'BusinessDay'

      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :date_time_interval
            @date_time_interval = DateTimeInterval.new(begin_time: value[:begin_time], end_time: value[:end_time])
          when :business_day
            @business_day = BusinessDay.new(abstract_date: value[:abstract_date])
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end
    end
  end
end
