# frozen_string_literal: true

require_relative 'all'

class Machine < Struct.new(:statement, :environment)
  def run
    while statement.reducible?
      puts "#{statement}, #{environment}"
      self.statement, self.environment = statement.reduce(environment)
    end
    puts "#{statement}, #{environment}"
  end
end
