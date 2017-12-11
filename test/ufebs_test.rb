require_relative 'test_helper'

class UfebsTest < MiniTest::Test
  def test_ed999
    pr = Ufebs::Requests::TestRequest.new(
      number: '8',
      ed_date: '2003-04-14',
      ed_author: '4525545000')

    doc = Nokogiri::XML(pr.to_xml)
    assert Ufebs.validate(doc)
  end
end
