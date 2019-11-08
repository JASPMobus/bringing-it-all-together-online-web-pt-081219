class Dog
  attr_accessor :name, :breed
  attr_reader :id
  
  def initialize(attrs)
    @id = attrs[:id]
    @name = attrs[:name]
    @breed = attrs[:breed]
  end
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
      );
      SQL
    
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL
      DROP TABLE IF EXISTS dogs
      SQL
     
     DB[:conn].execute(sql) 
  end
  
  def save
    if @id
      self.update
    else
      sql = <<-SQL
        INSERT INTO dogs (name, breed) VALUES (?, ?);
        SQL
end