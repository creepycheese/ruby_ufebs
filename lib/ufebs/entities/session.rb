module Ufebs
  module Entities
    class Session
      include HappyMapper

      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      namespace 'ed'

      element :session_id, String, tag: 'SessionID'

      def initialize(session_id: nil)
        @session_id = session_id
      end
    end
  end
end
