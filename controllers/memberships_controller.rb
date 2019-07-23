require('sinatra')
require('sinatra/reloader')
require('sinatra/namespace')
require('pry')
require_relative('../models/member.rb')
require_relative('../models/session.rb')
require_relative('../models/schedule.rb')
require_relative('../models/membership.rb')
also_reload('./models/*')

namespace '/gym/memberships' do

  get do
    @memberships = Membership.all()
    erb(:'memberships/index')
  end

  get '/new' do
    erb(:'memberships/new')
  end

  post do
    @membership = Membership.new(params)
    @membership.save()
    redirect to '/gym/memberships'
  end

  get '/:id' do
    @membership = Membership.find(params[:id])
    erb(:'memberships/show')
  end

  get '/:id/edit' do
    @membership = Membership.find(params[:id])
    erb(:'memberships/edit')
  end

  post '/:id' do
    Membership.new(params).update
    redirect to '/gym/memberships'
  end

  post '/:id/delete' do
    Membership.delete(params[:id])
    redirect to '/gym/memberships'
  end
end
