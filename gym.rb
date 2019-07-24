require('sinatra')
require('sinatra/reloader')
require('sinatra/namespace')
require('pry')
require_relative('./models/member.rb')
require_relative('./models/session.rb')
require_relative('./models/schedule.rb')
require_relative('controllers/members_controller.rb')
require_relative('controllers/sessions_controller.rb')
require_relative('controllers/memberships_controller.rb')
also_reload('./models/*')


get '/gym' do
  @members = Member.number_of_members()
  @sessions = Session.all()
  @sorted_sessions = Session.sorted_sessions()
  erb(:index)
end
