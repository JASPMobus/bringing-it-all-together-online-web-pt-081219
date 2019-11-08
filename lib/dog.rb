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
        
      DB[:conn].execute(sql, @name, @breed)
      
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    end
    
    self 
  end
  
  def update
    sql = <<-SQL
      UPDATE dogs SET name = ?, breed = ? WHERE id = ?
      SQL
    
    DB[:conn].execute(sql, @name, @breed, self.id)
  end
  
  def self.create(attrs)
    new_dog = Dog.new(attrs)
    
    new_dog.save
    
    new_dog
  end
  
  def self.new_from_db(row)
    row_hash = {
      id: row[0],
      name: row[1],
      breed: row[2]
    }
    
    new_dog = Dog.new(row)
  end
end