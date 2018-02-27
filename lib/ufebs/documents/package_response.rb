require_relative 'payment_response'
require_relative '../entities/session'

module Ufebs
  module Documents
    class PackageResponse
      include HappyMapper
      register_namespace 'ed', "urn:cbr-ru:ed:v2.0"
      tag 'PacketESID'
      namespace 'ed'

      attribute :ed_author, String, tag: 'EDAuthor'
      attribute :ed_creation_time, String, tag: 'EDCreationTime'
      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_no, String, tag: 'EDNo'
      attribute :ed_receiver, String, tag: 'EDReceiver'

      has_many :payment_responses, Ufebs::Documents::PaymentResponse
      has_one :session, ::Ufebs::Entities::Session, tag: 'Session', state_when_nil: false
      has_one :initial_packet, ::Ufebs::Entities::InitialPacket, tag: 'InitialPacketED', state_when_nil: false
    end
  end
end
