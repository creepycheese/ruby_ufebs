module Ufebs
  module Entities
    class EdRefId
      include HappyMapper
      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'
      namespace 'ed'
      tag 'EDRefID'

      attribute :ed_no,     String, tag: 'EDNo'
      attribute :ed_date,   String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'
    end
  end
end
