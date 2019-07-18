require('sinatra')
require('sinatra/reloader')
require_relative('./models/member.rb')
require_relative('./models/session.rb')
require_relative('./models/schedule.rb')
also_reload('./models/*')


get '/gym' do
  erb(:index)
end

get '/gym/members' do
  @members = Member.all()
  erb(:'members/index')
end

get '/gym/members/new' do
  erb(:'members/new')
end

post '/gym/members' do
  @member = Member.new(params)
  @member.save()
  redirect to '/gym/members'
end
