require_relative('../db/sql_runner.rb')

class Schedule

  attr_accessor :member_id, :session_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @member_id = options['member_id'].to_i
    @session_id = options['session_id'].to_i
  end

  def save()
    sql = "INSERT INTO schedule
    (
      member_id,
      session_id
      )
      VALUES ($1, $2)
      RETURNING id"
      values = [@member_id, @session_id]
      @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = "UPDATE schedule SET
    (
      member_id,
      session_id
      ) = ($1, $2)"
    values = [@member_id, @session_id]
    SqlRunner.run(sql, values)
  end

  def self.delete(id)
    sql = "DELETE FROM schedule
    WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM schedule
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    return Schedule.new(result)
  end

  def self.all()
    sql = "SELECT * FROM schedule"
    results = SqlRunner.run(sql)
    return results.map { |schedule| Schedule.new(schedule) }
  end

  def self.delete_all()
    sql = "DELETE FROM schedule"
    SqlRunner.run(sql)
  end



end
