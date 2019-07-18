require('sinatra')
require('sinatra/reloader')
require('pry')
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

get '/gym/members/:id' do
  @member = Member.find(params[:id])
  erb(:'members/show')
end

get '/gym/members/:id/edit' do
  @member = Member.find(params[:id])
  erb(:'members/edit')
end


post '/gym/members/:id' do
  Member.new(params).update
  redirect to '/gym/members'
end
