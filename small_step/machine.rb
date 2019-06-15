# frozen_string_literal: true

require_relative 'all'

class Machine
  def self.new(syntax, *args)
    machine_class =
      case syntax
      when Add, Boolean, LessThan, Multiply, Number, Variable
        ExpressionMachine
      when Assign, DoNothing, If, Sequence, While
        StatementMachine
      else
        raise "Unrecognized syntax: #{syntax.inspect}"
      end

    machine_class.new(syntax, *args)
  end
end

# 虚拟机分为了 expression 和 statement 两种是因为
# 执行 statement 语句以后，需要返回新的 environment
# 这和 expression 执行时，不需要

class ExpressionMachine < Struct.new(:expression, :environment)
  def step
    self.expression = expression.reduce(environment)
  end

  def run
    while expression.reducible?
      puts expression
      step
    end

    puts expression
  end
end

class StatementMachine < Struct.new(:statement, :environment)
  def step
    self.statement, self.environment = statement.reduce(environment)
  end

  def run
    while statement.reducible?
      puts "#{statement}, #{environment}"
      step
    end

    puts "#{statement}, #{environment}"
  end
end
