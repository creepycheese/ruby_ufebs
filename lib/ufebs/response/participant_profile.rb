module Ufebs
  module Response
    class ParticipantProfile
      include HappyMapper

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'

      tag 'ED808'
      namespace 'ed'

      attribute :ed_receiver, String, tag: 'EDReceiver'
      attribute :ed_no, String, tag: 'EDNo'
      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'
      attribute :request_code, String, tag: 'RequestCode'
      attribute :creation_date_time, String, tag: 'CreationDateTime'
      attribute :info_type_code, String, tag: 'InfoTypeCode'
      attribute :business_day, String, tag: 'BusinessDay'
      attribute :change_number, String, tag: 'ChangeNumber'

      has_one :creation_reason, 'Ufebs::Response::CreationReason', tag: 'CreationReason'
      has_one :bic_directory, 'Ufebs::Response::BicDirectory', tag: 'BICDirectoryEntry'

      def creation_reason_codes
        @creation_reason.codes
      end
    end

    class BicDirectory
      include HappyMapper

      attribute :bic, String, tag: 'BIC'
      attribute :change_type, String, tag: 'ChangeType'

      has_one :participant_info, 'Ufebs::Response::ParticipantInfo', tag: 'ParticipantInfo'
      has_many :accounts, 'Ufebs::Response::Account', tag: 'Accounts'
      has_many :swift_bics, 'Ufebs::Response::SwiftBics', tag: 'SWBICS'
    end

    class SwiftBics
      include HappyMapper

      attribute :bic, String, tag: 'SWBIC'
      attribute :default, Boolean, tag: 'DefaultSWBIC'
    end

    class Account
      include HappyMapper

      attribute :account, String, tag: 'Account'
      attribute :regulation_account_type, String, tag: 'RegulationAccountType'
      attribute :control_key, String, tag: 'CK'
      attribute :account_cbrbic, String, tag: 'AccountCBRBIC'
      attribute :date_in, String, tag: 'DateIn'
      attribute :date_out, String, tag: 'DateOut'
      attribute :status, String, tag: 'AccountStatus'

      has_many :restricts, 'Ufebs::Response::AccountRestrict', tag: 'AccRstrList'
    end

    class ParticipantInfo
      include HappyMapper

      attribute :name, String, tag: 'NameP'
      attribute :eng_name, String, tag: 'EnglName'
      attribute :number, String, tag: 'RegN'
      attribute :country_code, String, tag: 'CntrCd'
      attribute :region_code, String, tag: 'Rgn'
      attribute :postcode, String, tag: 'Ind'
      attribute :settlement_type, String, tag: 'Tnp'
      attribute :settlement_name, String, tag: 'Nnp'
      attribute :address, String, tag: 'Adr'
      attribute :head_organization_bic, String, tag: 'PrntBIC'
      attribute :date_in, String, tag: 'DateIn'
      attribute :date_out, String, tag: 'DateOut'
      attribute :type, String, tag: 'PtType'
      attribute :services, String, tag: 'Srvcs'
      attribute :exchange_type, String, tag: 'XchType'
      attribute :uid, String, tag: 'UID'
      attribute :nps_participant, String, tag: 'NPSParticipant'
      attribute :to_nps_date, String, tag: 'ToNPSDate'
      attribute :status, String, tag: 'ParticipantStatus'

      has_many :restricts, 'Ufebs::Response::ParticipantRestrict', tag: 'RstrList'
    end

    class ParticipantRestrict
      include HappyMapper

      attribute :resctrict, String, tag: 'Rstr'
      attribute :date, String, tag: 'RstrDate'
    end

    class AccountRestrict
      include HappyMapper

      attribute :resctrict, String, tag: 'AccRstr'
      attribute :date, String, tag: 'AccRstrDate'
    end

    class CreationReason
      include HappyMapper

      has_many :codes, String, tag: 'CreationReasonCode'
    end
  end
end
