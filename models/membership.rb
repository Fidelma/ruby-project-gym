require_relative('../db/sql_runner.rb')

class Membership

  attr_accessor :type, :price, :access_hours
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @type = options['type']
    @price = options['price'].to_i
    @access_hours = options['access_hours']
  end

  def save()
    sql = "INSERT INTO memberships
    (
      type,
      price,
      access_hours
      )
      VALUES ($1, $2, $3)
      RETURNING id"
      values = [@type, @price, @access_hours]
      @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = "UPDATE memberships SET
    (
      type,
      price,
      access_hours
      ) = ($1, $2, $3)
      WHERE id = $4"
    values = [@type, @price, @access_hours, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete(id)
    sql = "DELETE FROM memberships
    WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM memberships
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    return Membership.new(result)
  end

  def self.all()
    sql = "SELECT * FROM memberships"
    results = SqlRunner.run(sql)
    return results.map { |membership| Membership.new(membership) }
  end

  def self.delete_all()
    sql = "DELETE FROM memberships"
    SqlRunner.run(sql)
  end
end 
