# frozen_string_literal: true

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

      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :ed_date then @ed_date = Date.parse(value.to_s).strftime('%Y-%m-%d')
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end
    end
  end
end
