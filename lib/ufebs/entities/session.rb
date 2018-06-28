module Ufebs
  module Entities
    class Session
      include HappyMapper

      tag 'Session'
      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      namespace 'ed'

      attribute :session_type, String, tag: 'SessionType'

      element :session_id, String, tag: 'SessionID'
      element :settlement_time, String, tag: 'SettlementTime'

      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :session_id      then @session_id = value
          when :session_type    then @session_type = value
          when :settlement_time then @settlement_time = value
          end
        end
      end
    end
  end
end
