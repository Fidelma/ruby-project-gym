require("minitest/autorun")
require_relative("../member.rb")

class TestPizzaOrder < MiniTest::Test

  def setup()
    @member = Member.new({
      'first_name' => 'Fi',
      'last_name' => 'Be'
      })
  end

  def test_pretty_name()
    assert_equal("Fi Be", @member.pretty_name())
  end


end
