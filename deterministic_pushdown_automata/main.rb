# frozen_string_literal: true

require_relative 'all'

puts '--stack----------------------------'

stack = Stack.new(%w[a b c d e])

puts stack.top

puts stack.pop.pop.top

puts stack.push('x').push('y').top

puts stack.push('x').push('y').pop.top

puts '--PDARule----------------------------'

rule = PDARule.new(1, '(', 2, '$', ['b', '$'])
puts rule

configuration = PDAConfiguration.new(1, Stack.new(['$']))
puts configuration

puts rule.applies_to?(configuration, '(')