require_relative('../models/member')
require_relative('../models/session')
require_relative('../models/schedule')

require('pry')

Member.delete_all()

member1 = Member.new({
  'first_name' => 'Fidelma',
  'last_name' => 'Beagan'
  })

  member1.save()

  class1 = Session.new({
    'type' => 'Dance',
    'start_time' => '11:00',
    'duration' => '1 hour'
    })

  binding.pry
  nil
