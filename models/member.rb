require_relative('../db/sql_runner.rb')
require_relative('schedule')
require_relative('membership')

class Member

  attr_accessor :first_name, :last_name, :membership_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @membership_id = options['membership_id']
  end

  def save()
    sql = "INSERT INTO members
    (
      first_name,
      last_name,
      membership_id
      )
      VALUES ($1, $2, $3)
      RETURNING id"
    values = [@first_name, @last_name, @membership_id]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = "UPDATE members SET
    (
      first_name,
      last_name,
      membership_id
      ) = ($1, $2, $3)
      WHERE id = $4"
    values = [@first_name, @last_name, @membership_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete(id)
    sql = "DELETE FROM members
    WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM members
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    return Member.new(result)
  end

  def self.all()
    sql = "SELECT * FROM members"
    results = SqlRunner.run(sql)
    return results.map { |member| Member.new(member) }
  end

  def self.delete_all()
    sql = "DELETE FROM members"
    SqlRunner.run(sql)
  end

  def pretty_name()
    name = "#{@first_name} #{last_name}"
    return name
  end

  def add_to_session(id)
    session = Session.find(id)
    if session.number_of_participants < session.capacity
      schedule = Schedule.new({
        "member_id" => @id,
        "session_id" => id
        })
        schedule.save()
    end
  end

  def find_membership()
    sql = "SELECT * FROM memberships
    WHERE id = $1"
    values = [@membership_id]
    result = SqlRunner.run(sql, values).first
    return Membership.new(result)
  end

  def self.find_by_name(first_name, last_name)
    sql = "SELECT * FROM members
    WHERE first_name = $1 and last_name = $2"
    values = [first_name, last_name]
    result = SqlRunner.run(sql, values).first
    unless result == nil then
      member = Member.new(result)
    else
      member = nil
    end
    return member
  end

end
