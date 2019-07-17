require_relative('../models/member')
require_relative('../models/session')
require_relative('../models/schedule')

require('pry')

Schedule.delete_all()
Member.delete_all()
Session.delete_all()

member1 = Member.new({
  'first_name' => 'Fidelma',
  'last_name' => 'Beagan'
  })

  member1.save()

member2 = Member.new({
  'first_name' => 'Filip',
  'last_name' => 'Kaklin'
  })

  member2.save()



  class1 = Session.new({
    'type' => 'Dance',
    'start_time' => '11:00',
    'duration' => '1 hour'
    })

  class1.save()

  schedule1 = Schedule.new({
    'member_id' => member1.id,
    'session_id' => class1.id
    })

    schedule1.save()

  schedule2 = Schedule.new({
    'member_id' => member2.id,
    'session_id' => class1.id
    })

    schedule2.save()


  binding.pry
  nil
