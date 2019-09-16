# frozen_string_literal: true

require_relative '../test_helper'

class Ufebs::Response::ParticipantProfileTest < MiniTest::Test
  def setup
    xml = File.open('test/files/ed_808.xml').read
    @parsed_xml = Ufebs::ED808(xml)
  end

  def test_ed_attributes
    assert_equal('1900-01-01', @parsed_xml.business_day)
    assert_equal('1', @parsed_xml.change_number)
    assert_equal('FIRR', @parsed_xml.info_type_code)
    assert_equal(%w[ACCH AICH ALCH], @parsed_xml.creation_reason_codes)
  end

  def test_initial_ed
    assert_equal('1', @parsed_xml.initial_ed.ed_no)
    assert_equal('1900-01-01', @parsed_xml.initial_ed.ed_date)
    assert_equal('EDAuthor1', @parsed_xml.initial_ed.ed_author)
  end

  def test_bic_directory
    swift_bic = @parsed_xml.bic_directory.swift_bics.first

    assert_equal('BIC1', @parsed_xml.bic_directory.bic)
    assert_equal('ADDD', @parsed_xml.bic_directory.change_type)
    assert_equal('SWBIC__1', swift_bic.bic)
    assert_equal(true, swift_bic.default)
  end

  def test_participant_info
    participant_info = @parsed_xml.bic_directory.participant_info

    assert_equal('NameP1', participant_info.name)
    assert_equal('EnglName1', participant_info.eng_name)
    assert_equal('RegN1', participant_info.number)
    assert_equal('C1', participant_info.country_code)
    assert_equal('R1', participant_info.region_code)
    assert_equal('Ind1', participant_info.postcode)
    assert_equal('Tnp1', participant_info.settlement_type)
    assert_equal('Nnp1', participant_info.settlement_name)
    assert_equal('Adr1', participant_info.address)
    assert_equal('PrntBIC1', participant_info.head_organization_bic)
    assert_equal('1900-01-01', participant_info.date_in)
    assert_equal('1900-01-01', participant_info.date_out)
    assert_equal('P1', participant_info.type)
    assert_equal('1', participant_info.services)
    assert_equal('1', participant_info.exchange_type)
    assert_equal('UID1', participant_info.uid)
    assert_equal('1', participant_info.nps_participant)
    assert_equal('1900-01-01', participant_info.to_nps_date)
    assert_equal('PSAC', participant_info.status)

    assert_equal('NORS', participant_info.restricts.first.resctrict)
    assert_equal('1900-01-01', participant_info.restricts.first.date)
  end

  def test_accounts
    accounts = @parsed_xml.bic_directory.accounts

    assert_equal('Account1', accounts.first.account)
    assert_equal('BANA', accounts.first.regulation_account_type)
    assert_equal('C1', accounts.first.control_key)
    assert_equal('AccountCBRBIC1', accounts.first.account_cbrbic)
    assert_equal('1900-01-01', accounts.first.date_in)
    assert_equal('1900-01-01', accounts.first.date_out)
    assert_equal('ACAC', accounts.first.status)
    assert_equal('NORS', accounts.first.restricts.first.resctrict)
    assert_equal('1900-01-01', accounts.first.restricts.first.date)
  end

  def test_participant_profile_info
    skip
    assert_equal('P1', accounts.participant.profile_info.type)
    assert_equal('ServCBRBIC1', accounts.participant.profile_info.serv_cbrbic)
    assert_equal('D1', accounts.participant.profile_info.default_arm_number)
    assert_equal('3', accounts.participant.profile_info.channel_mode)
  end
end
