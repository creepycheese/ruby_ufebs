# frozen_string_literal: true

module Ufebs
  module Requests
    class AccountStatement
      include HappyMapper
      include Ufebs::Common

      register_namespace 'ed', 'urn:cbr-ru:ed:v2.0'

      tag 'ED210'
      namespace 'ed'

      attribute :ed_no, String, tag: 'EDNo'
      attribute :ed_date, String, tag: 'EDDate'
      attribute :ed_author, String, tag: 'EDAuthor'
      attribute :abstract_request, String, tag: 'AbstractRequest'
      attribute :abstract_date, String, tag: 'AbstractDate'
      attribute :begin_time, String, tag: 'BeginTime'
      attribute :end_time, String, tag: 'EndTime'
      attribute :account, String, tag: 'Acc'
      attribute :session_id, String, tag: 'SessionID'
      attribute :bic, String, tag: 'BIC'

      def initialize(params = {})
        params.each do |key, value|
          case key.to_sym
          when :ed_date then @ed_date = Date.parse(value.to_s).strftime('%Y-%m-%d')
          when :abstract_date then @abstract_date = Date.parse(value.to_s).strftime('%Y-%m-%d')
          when :begin_time
            @begin_time = Time.parse(value.to_s).strftime('%H:%M:%S') if present?(value)
          when :end_time
            @end_time = Time.parse(value.to_s).strftime('%H:%M:%S') if present?(value)
          else instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end

      def to_xml(encoding: 'UTF-8')
        super(Nokogiri::XML::Builder.new(encoding: encoding)).to_xml
      end
    end
  end
end

# <ED210 xmlns="urn:cbr-ru:ed:v2.0"
#   EDNo="11" EDDate="2018-07-16" EDAuthor="4525545000" EDReceiver="4583001999"
#   AbstractRequest="1" AbstractDate="2018-07-16" BeginTime="09:40:00" EndTime="10:10:00" Acc="30101810300000000545"/>
