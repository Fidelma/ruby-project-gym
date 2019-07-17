require_relative('../db/sql_runner.rb')

class Session

  attr_accessor :type, :start_time, :duration
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @type = options['type']
    @start_time = options['start_time']
    @duration = options['duration']
  end

  def save()
    sql = "INSERT INTO sessions
    (
      type,
      start_time,
      duration
      )
      VALUES ($1, $2, $3)
      RETURNING id"
      values = [@type, @start_time, @duration]
      @id = SqlRunner.run(sql, values).first['id'].to_i
  end

end
