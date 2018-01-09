module Ufebs
  module Requests
    class Receipt
      include HappyMapper
      include Ufebs::Fields::Header

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      tag 'ED211'
      namespace 'ed'

      attribute :abstract_date, String, tag: 'AbstractDate'
      attribute :abstract_kind, String, tag: 'AbstractKind'
      attribute :acc, String, tag: 'Acc'
      attribute :bic, String, tag: 'BIC'
      attribute :end_time, String, tag: 'EndTime'
      attribute :enter_bal, String, tag: 'EnterBal'
      attribute :inquiry_session, String, tag: 'InquirySession'
      attribute :last_movet_date, String, tag: 'LastMovetDate'
      attribute :out_bal, String, tag: 'OutBal'
      attribute :rtgs_unconfirmed_ed, String, tag: 'RTGSUnconfirmedED'

      def initialize(params = {})
        params.each do |key, value|
          @abstract_date =  Date.parse(value.to_s).strftime('%Y-%m-%d') if key.to_sym == :abstract_date
          @end_time =  DateTime.parse(value.to_s).strftime('%H:%M:%S') if key.to_sym == :end_time
          @last_movet_date =  Date.parse(value.to_s).strftime('%Y-%m-%d') if key.to_sym == :last_movet_date

          instance_variable_set("@#{key}".to_sym, value)
        end
      end
    end
  end
end

# <?xml version="1.0" encoding="windows-1251"?>
# <ED211 xmlns="urn:cbr-ru:ed:v2.0" AbstractDate="2018-01-09" AbstractKind="1" Acc="30101810945250000420" BIC="044525000" EndTime="00:47:07"
# EnterBal="72619100" EDAuthor="4583001999" EDDate="2018-01-09" EDNo="1006815" EDReceiver="4525420000" InquirySession="0" LastMovetDate="2017-12-29" OutBal="72619100" RTGSUnconfirmedED="0"></ED211>
