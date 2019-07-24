require('sinatra')
require('sinatra/reloader')
require('sinatra/namespace')
require('pry')
require_relative('../models/member.rb')
require_relative('../models/session.rb')
require_relative('../models/schedule.rb')
also_reload('./models/*')

namespace '/gym/members' do

  get do
    @members = Member.all()
    erb(:'members/index')
  end

  get '/new' do
    @memberships = Membership.all()
    erb(:'members/new')
  end

  post do
    @member = Member.new(params)
    @member.save()
    redirect to '/gym/members'
  end

  get '/:id' do
    @member = Member.find(params[:id])
    @membership = @member.find_membership()
    erb(:'members/show')
  end

  get '/:id/edit' do
    @member = Member.find(params[:id])
    @memberships = Membership.all()
    erb(:'members/edit')
  end


  post '/:id' do
    Member.new(params).update
    redirect to '/gym/members'
  end

  post '/:id/delete' do
    Member.delete(params[:id])
    redirect to '/gym/members'
  end

  get '/:id/add' do
    @sessions = Session.all()
    @member = Member.find(params[:id])
    erb(:'members/add')
  end

  post '/:id/add' do
    @member = Member.find(params[:id])
    @sessions = []
    @full_sessions = []
    @ineligible_sessions = []
    params.each_key do |key|
      unless key == 'id' then
        session = Session.find(key.to_i)
          result = @member.add_to_session(session.id)
        if result == 'full'
          @full_sessions << session
        elsif result == 'ineligible'
          @ineligible_sessions << session
        else
          @sessions << session
        end
      end
    end
    erb(:'members/create')
  end

end
