# frozen_string_literal: true

require_relative '../test_helper'

class Ufebs::Response::BicDirectoryTest < MiniTest::Test
  def setup
    xml = File.open('test/files/ed_807.xml').read
    @parsed_xml = Ufebs::ED807(xml)
  end

  def test_current_ed
    assert_equal('700000938', @parsed_xml.ed_no)
    assert_equal('2018-07-01', @parsed_xml.ed_date)
    assert_equal('4583001999', @parsed_xml.ed_author)
  end

  def test_initial_ed
    assert_equal('1', @parsed_xml.initial_ed.ed_no)
    assert_equal('1900-01-01', @parsed_xml.initial_ed.ed_date)
    assert_equal('EDAuthor1', @parsed_xml.initial_ed.ed_author)
  end

  def test_info_type_code
    assert_equal('FIRR', @parsed_xml.info_type_code)
  end

  def test_creation_reason
    assert_equal(['SOBD'], @parsed_xml.creation_reason_codes)
  end
end
