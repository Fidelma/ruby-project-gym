require_relative('../db/sql_runner.rb')
require_relative('schedule')

class Member

  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save()
    sql = "INSERT INTO members
    (
      first_name,
      last_name
      )
      VALUES ($1, $2)
      RETURNING id"
    values = [@first_name, @last_name]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = "UPDATE members SET
    (
      first_name,
      last_name
      ) = ($1, $2)
      WHERE id = $3"
    values = [@first_name, @last_name, @id]
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
    schedule = Schedule.new({
      "member_id" => @id,
      "session_id" => id
      })
      schedule.save()
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
