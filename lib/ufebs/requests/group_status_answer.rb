module Ufebs
  module Requests
    class GroupStatusAnswer
      include HappyMapper
      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      tag 'ED207'
      namespace 'ed'

      attribute :ed_author,   String, tag: 'EDAuthor'
      attribute :ed_date,     String, tag: 'EDDate'
      attribute :ed_no,       String, tag: 'EDNo'
      attribute :ed_receiver, String, tag: 'EDReceiver'
      attribute :status_code, String, tag: 'StatusCode'
      attribute :quantity_ed, String, tag: 'QuantityED'
      attribute :sum,         String, tag: 'Sum'

      has_one :initial_ed,
              Ufebs::Entities::EdRefId,
              tag: 'InitialED'

      has_many :ed_infos,
               Ufebs::Entities::EdInfo,
               tag: 'EDInfo'

      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :initial_ed then @initial_ed = Ufebs::Entities::EdRefId.new(value)
          when :ed_infos   then @ed_infos   = set_ed_infos(value)
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end

      def set_ed_infos(value)
        value.map { |params| Ufebs::Entities::EdInfo.new(params) }
      end
    end
  end
end

# <?xml version="1.0" encoding="WINDOWS-1251"?>
# <ED207 xmlns="urn:cbr-ru:ed:v2.0"
#        EDNo="90" EDDate="2018-07-16" EDAuthor="4583001999"
#        EDReceiver="4525545000"
#        StatusCode="01" QuantityED="2" Sum="6000000" EDDayNo="10">
#   <InitialED EDNo="9" EDDate="2018-07-16"
#              EDAuthor="4525545000"></InitialED>
#   <EDInfo Sum="2400000">
#     <EDRefID EDNo="7" EDDate="2018-07-16" EDAuthor="4525545000"/>
#   </EDInfo>
#   <EDInfo Sum="3600000">
#     <EDRefID EDNo="16" EDDate="2018-07-16" EDAuthor="4525545000"/>
#   </EDInfo>
# </ED207>
