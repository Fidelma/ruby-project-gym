require_relative('../models/member')
require_relative('../models/class')
require_relative('../models/schedule')

require('pry')

member1 = Member.new({
  'first_name' => 'Fidelma',
  'last_name' => 'Beagan'
  })

  member1.save()

  binding.pry
  nil
