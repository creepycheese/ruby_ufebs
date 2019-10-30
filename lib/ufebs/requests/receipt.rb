module Ufebs
  module Requests
    class Receipt
      include HappyMapper
      include Ufebs::Fields::Header

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      tag 'ED211'
      namespace 'ed'

      attribute :abstract_date,       String, tag: 'AbstractDate'
      attribute :abstract_kind,       String, tag: 'AbstractKind'
      attribute :acc,                 String, tag: 'Acc'
      attribute :bic,                 String, tag: 'BIC'
      attribute :end_time,            String, tag: 'EndTime'
      attribute :enter_bal,           String, tag: 'EnterBal'
      attribute :inquiry_session,     String, tag: 'InquirySession'
      attribute :last_movet_date,     String, tag: 'LastMovetDate'
      attribute :out_bal,             String, tag: 'OutBal'
      attribute :reserved_sum,        String, tag: 'ReservedSum'
      attribute :credit_limit_sum,    String, tag: 'CreditLimitSum'
      # attribute :rtgs_unconfirmed_ed, String, tag: 'RTGSUnconfirmedED'
      attribute :arrest_sum,          String, tag: 'ArrestSum'
      attribute :part_aggregate_id,   String, tag: 'PartAggregateID'
      attribute :debit_sum,           String, tag: 'DebetSum'
      attribute :credit_sum,          String, tag: 'CreditSum'

      has_many :trans_infos, Ufebs::Entities::TransInfo
      has_one :fps_info, 'Ufebs::Requests::Receipt::FpsInfo'

      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :abstract_date      then @abstract_date      = Date.parse(value.to_s).strftime('%Y-%m-%d')
          when :end_time           then @end_time           = DateTime.parse(value.to_s).strftime('%H:%M:%S')
          when :last_movet_date    then @last_movet_date    = Date.parse(value.to_s).strftime('%Y-%m-%d')
          when :trans_infos        then @trans_infos        = set_trans_infos(value)
          when :processing_details then @processing_details = Ufebs::Entities::ProcessingDetails.new(value)
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end

      def set_trans_infos(value)
        value.map { |params| Ufebs::Entities::TransInfo.new(params) }
      end

      class FpsInfo
        include HappyMapper

        namespace 'ed'
        tag 'FPSInfo'

        attribute :fps_liquidity, Integer, tag: 'FPSLiquidity'
        attribute :enter_balance, Integer, tag: 'EnterBalance'
        attribute :current_balance, Integer, tag: 'CurrentBalance'
        attribute :fps_credit_sum, Integer, tag: 'FPSCreditSum'
        attribute :fps_debet_sum, Integer, tag: 'FPSDebetSum'
      end
    end
  end
end

# <?xml version="1.0" encoding="windows-1251"?>
# <ED211 xmlns="urn:cbr-ru:ed:v2.0" AbstractDate="2018-01-09" AbstractKind="1" Acc="30101810945250000420" BIC="044525000" EndTime="00:47:07"
# EnterBal="72619100" EDAuthor="4583001999" EDDate="2018-01-09" EDNo="1006815" EDReceiver="4525420000" InquirySession="0" LastMovetDate="2017-12-29" OutBal="72619100" RTGSUnconfirmedED="0">
# <FPSInfo FPSLiquidity="100000000" EnterBalance="40087530967" CurrentBalance="39421851223" FPSCreditSum="5643726423" FPSDebetSum="7589454673"/>
# </ED211>
