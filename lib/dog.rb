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
    
      SQL
    end
end