require_relative '../test_helper'

class Ufebs::Entities::PackageRequestTest < MiniTest::Test
  def setup
    @acc_doc = Ufebs::Entities::AccDoc.new(number: 1, date: Date.today)
  end

  def test_it_adds_leading_zeroes_to_number
    assert_equal(@acc_doc.number[0..4], '00000')
  end
end
