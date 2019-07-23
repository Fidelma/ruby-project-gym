require("minitest/autorun")
require_relative("../session.rb")

class TestSession < MiniTest::Test

  def setup()
    @session = Session.new({
      'type' => 'Dance',
      'start_time' => '13:00',
      'duration' => '30 mins',
      'capacity' => 20
      })
  end

  def test_number_of_participants()
    
  end


end
