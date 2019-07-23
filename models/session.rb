require_relative('../db/sql_runner.rb')
require('time')

class Session

  attr_accessor :type, :start_time, :duration, :capacity, :peak
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @type = options['type']
    @start_time = options['start_time']
    @peak = options['peak']
    @duration = options['duration']
    @capacity = options['capacity'].to_i
  end

  def save()
    sql = "INSERT INTO sessions
    (
      type,
      start_time,
      peak,
      duration,
      capacity
      )
      VALUES ($1, $2, $3, $4, $5)
      RETURNING id"
      values = [@type, @start_time, @peak, @duration, @capacity]
      @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = "UPDATE sessions SET
    (
      type,
      start_time,
      peak,
      duration,
      capacity
      ) = ($1, $2, $3, $4, $5)
      WHERE id = $6"
    values = [@type, @start_time, @peak, @duration, @capacity, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete(id)
    sql = "DELETE FROM sessions
    WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM sessions
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    return Session.new(result)
  end

  def self.all()
    sql = "SELECT * FROM sessions"
    results = SqlRunner.run(sql)
    return results.map { |session| Session.new(session) }
  end

  def self.delete_all()
    sql = "DELETE FROM sessions"
    SqlRunner.run(sql)
  end

  def attendance()
    sql = "SELECT members.* FROM members
    INNER JOIN schedule
    ON schedule.member_id = members.id
    WHERE schedule.session_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |member| Member.new(member) }
  end

  def number_of_participants()
    sql = "SELECT * FROM Schedule
    WHERE session_id = $1"
    values = [@id]
    sql_result = SqlRunner.run(sql, values)
    result = sql_result.map { |participant| Schedule.new(participant)}
    return result.length
  end

  def self.find_by_type(type)
    sql = "SELECT * FROM sessions
    WHERE name = $1"
    values = [type]
    result = SqlRunner.run(sql, values).first
    return Session.new(result)
  end

  def peak_off_peak()
    sql = "SELECT * FROM sessions
    WHERE id = $1"
    values = [@id]
    session = SqlRunner.run(sql, values).first
    result = Session.new(session)
    if result.peak
      peak = 'peak'
    else
      peak = 'off-peak'
    end
    return peak
  end




end
