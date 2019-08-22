module Ufebs
  module Entities
    class DateTimeInterval
      include HappyMapper
      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      namespace 'ed'

      attribute :begin_time, String, tag: 'BeginTime'
      attribute :end_time, String, tag: 'EndTime'

      def initialize(begin_time: Time.now, end_time: Time.now)
        @begin_time = DateTime.parse(begin_time.to_s).strftime('%Y-%m-%dT%H:%M:%SZ')
        @end_time = DateTime.parse(end_time.to_s).strftime('%Y-%m-%dT%H:%M:%SZ')
      end
    end
    
    class RequestInfo
      include HappyMapper
      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      namespace 'ed'

      attribute :bic, String, tag: 'BIC'
      attribute :correspondent_account, String, tag: 'CorrespAcc'
      attribute :sum, Integer, tag: 'Sum'
      attribute :liquidity_trans_kind, String, tag: 'LiquidityTransKind'
      
      has_one :date_time_interval, DateTimeInterval, tag: 'DateTimeInterval'

      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :date_time_interval then @date_time_interval = DateTimeInterval.new(value)
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end
    end
  end
end
