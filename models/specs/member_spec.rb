require("minitest/autorun")
require_relative("../member.rb")

class TestMember < MiniTest::Test

  def setup()
    @member = Member.new({
      'first_name' => 'Fi',
      'last_name' => 'Be'
      })
  end

  def test_pretty_name()
    assert_equal("Fi Be", @member.pretty_name())
  end

  # def test_find_by_name()
  #   member = Member.find_by_name('Fidelma', 'Beagan')
  #   assert_equal({
  #     'first_name' => 'Fidelma',
  #     'last_name' => 'Beagan',
  #     'id' => 19
  #     }, member)
  # end


end
