# frozen_string_literal: true

require_relative 'all'

rulebook = DFARulebook.new([
                             FARule.new(1, 'a', 2), FARule.new(1, 'b', 1),
                             FARule.new(2, 'a', 2), FARule.new(2, 'b', 3),
                             FARule.new(3, 'a', 3), FARule.new(3, 'b', 3)
                           ])

puts rulebook.next_state(1, 'a')
puts rulebook.next_state(1, 'b')
puts rulebook.next_state(2, 'b')

puts '-----------------------------------------'

dfa = DFA.new(1, [3], rulebook)
puts dfa.accepting?

dfa.read_character('b')
puts dfa.accepting?

3.times { dfa.read_character('a') }
puts dfa.accepting?

dfa.read_character('b')
puts dfa.accepting?

puts '-----------------------------------------'

dfa = DFA.new(1, [3], rulebook)
puts dfa.accepting?

dfa.read_string('baaab')
puts dfa.accepting?

puts '-----------------------------------------'

puts dfa_design = DFADesign.new(1, [3], rulebook)
puts dfa_design.accepts?('a')
puts dfa_design.accepts?('baa')
puts dfa_design.accepts?('baba')
