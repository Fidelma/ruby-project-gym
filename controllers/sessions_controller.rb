require('sinatra')
require('sinatra/reloader')
require('pry')
require_relative('../models/member.rb')
require_relative('../models/session.rb')
require_relative('../models/schedule.rb')
also_reload('./models/*')


get '/gym/sessions' do
  @sessions = Session.all()
  erb(:'sessions/index')
end

get '/gym/sessions/new' do
  erb(:'sessions/new')
end

post '/gym/sessions' do
  @session = Session.new(params)
  @session.save()
  redirect to '/gym/sessions'
end

get '/gym/sessions/:id' do
  @session = Session.find(params[:id])
  erb(:'sessions/show')
end

get '/gym/sessions/:id/edit' do
  @session = Session.find(params[:id])
  erb(:'sessions/edit')
end


post '/gym/sessions/:id' do
  Session.new(params).update
  redirect to '/gym/sessions'
end

post '/gym/sessions/:id/delete' do
  Session.delete(params[:id])
  redirect to '/gym/sessions'
end
