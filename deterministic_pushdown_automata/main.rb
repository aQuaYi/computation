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

puts '--观察 stack push 和 pop 的顺序--------'

stack = Stack.new(['$']).push('x').push('y').push('z')
puts stack
puts stack.top

stack = stack.pop
puts stack.top

stack = stack.pop
puts stack.top

puts '--DPDARule book---------------------'

rulebook = DPDARulebook.new([
                              PDARule.new(1, '(', 2, '$', ['b', '$']),
                              PDARule.new(2, '(', 2, 'b', %w[b b]),
                              PDARule.new(2, ')', 2, 'b', []),
                              PDARule.new(2, nil, 1, '$', ['$'])
                            ])
puts rulebook

configuration = rulebook.next_configuration(configuration, '(')
puts configuration

configuration = rulebook.next_configuration(configuration, '(')
puts configuration

configuration = rulebook.next_configuration(configuration, ')')
puts configuration

puts '--DPDA------------------------------'

dpda = DPDA.new(PDAConfiguration.new(1, Stack.new(['$'])), [1], rulebook)
puts dpda

puts dpda.accepting?

dpda.read_string('(()')
puts dpda.accepting?

puts dpda.current_configuration

puts '--follow free move------------------'

configuration = PDAConfiguration.new(2, Stack.new(['$']))
puts configuration

puts rulebook.follow_free_moves(configuration)

puts '--DPDA test-------------------------'

dpda = DPDA.new(PDAConfiguration.new(1, Stack.new(['$'])), [1], rulebook)
puts dpda

dpda.read_string('(()(')
puts dpda.accepting?
puts dpda.current_configuration

dpda.read_string('))()')
puts dpda.accepting?
puts dpda.current_configuration

puts '--DPDA Design--------------------------'

dpda_design = DPDADesign.new(1, '$', [1], rulebook)

puts dpda_design.accepts?('(((((((((())))))))))')

puts dpda_design.accepts?('()(())((()))(()(()))')

puts dpda_design.accepts?('(()(()(()()(()()))()')

puts '--NO SUCK------------------------------'

dpda = DPDA.new(PDAConfiguration.new(1, Stack.new(['$'])), [1], rulebook)

dpda.read_string('())')
puts dpda.current_configuration

puts dpda.accepting?

puts dpda.stuck?

puts dpda_design.accepts?('())')
