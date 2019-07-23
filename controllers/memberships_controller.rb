require('sinatra')
require('sinatra/reloader')
require('pry')
require_relative('../models/member.rb')
require_relative('../models/session.rb')
require_relative('../models/schedule.rb')
require_relative('../models/membership.rb')
also_reload('./models/*')


get '/gym/memberships' do
  @memberships = Membership.all()
  erb(:'memberships/index')
end

get '/gym/memberships/new' do
  erb(:'memberships/new')
end

post '/gym/memberships' do
  @membership = Membership.new(params)
  @membership.save()
  redirect to '/gym/memberships'
end

get '/gym/memberships/:id' do
  @membership = Membership.find(params[:id])
  erb(:'memberships/show')
end

get '/gym/memberships/:id/edit' do
  @membership = Membership.find(params[:id])
  erb(:'memberships/edit')
end

post '/gym/memberships/:id' do
  Membership.new(params).update
  redirect to '/gym/memberships'
end

post '/gym/memberships/:id/delete' do
  Membership.delete(params[:id])
  redirect to '/gym/memberships'
end 
