class ModelBase
  def initialize
  end

  def self.find_by_id(id)
    object = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table}
      WHERE
        id = ?
    SQL

    return nil if object.empty?
    self.new(object.first)
  end

  def self.all
    objects = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table}
    SQL

    return nil if objects.empty?

    objects.map { |object| self.new(object) }
  end

  def self.where(options)
    conditions = []

    options.each do |k, v|
      conditions << "#{k.to_s} = '#{v}'"
    end

    condition = conditions.join(" AND ")

    objects = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table}
      WHERE
        #{condition}
    SQL

    return nil if objects.empty?

    objects.map { |object| self.new(object) }
  end

  def save
    i_vars = self.instance_variables.map(&:to_s)

    # if @id.nil?
    #   QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
    #     INSERT INTO
    #       #{self.table} (fname, lname)
    #     VALUES
    #       (?, ?)
    #   SQL
    #   @id = QuestionsDatabase.instance.last_insert_row_id
    # else
    #   QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
    #     UPDATE
    #       users
    #     SET
    #       fname = ?, lname = ?
    #     WHERE
    #       id = ?
    #   SQL
    # end
  end
end
