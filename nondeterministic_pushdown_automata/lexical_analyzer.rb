# frozen_string_literal: true

LexicalAnalyzer = Struct.new(:string) do
  GRAMMAR = [
    { token: 'i', pattern: /if/         }, # if keyword
    { token: 'e', pattern: /else/       }, # else keyword
    { token: 'w', pattern: /while/      }, # while keyword
    { token: 'd', pattern: /do-nothing/ }, # do-nothing keyword
    { token: '(', pattern: /\(/         }, # opening bracket
    { token: ')', pattern: /\)/         }, # closing bracket
    { token: '{', pattern: /\{/         }, # opening curly bracket
    { token: '}', pattern: /\}/         }, # closing curly bracket
    { token: ';', pattern: /;/          }, # semicolon
    { token: '=', pattern: /=/          }, # equals sign
    { token: '+', pattern: /\+/         }, # addition sign
    { token: '*', pattern: /\*/         }, # multiplication sign
    { token: '<', pattern: /</          }, # less-than sign
    { token: 'n', pattern: /[0-9]+/     }, # number
    { token: 'b', pattern: /true|false/ }, # boolean
    { token: 'v', pattern: /[a-z]+/     }  # variable name
  ].freeze

  def analyze
    [].tap do |tokens|
      tokens.push(next_token) while more_tokens?
    end
  end

  def more_tokens?
    !string.empty?
  end

  def next_token
    rule, match = rule_matching(string)
    self.string = string_after(match)
    rule[:token]
  end

  def rule_matching(string)
    matches = GRAMMAR.map { |rule| match_at_beginning(rule[:pattern], string) }
    rules_with_matches = GRAMMAR.zip(matches).reject { |_rule, match| match.nil? }
    rule_with_longest_match(rules_with_matches)
  end

  def match_at_beginning(pattern, string)
    /\A#{pattern}/.match(string)
  end

  def rule_with_longest_match(rules_with_matches)
    rules_with_matches.max_by { |_rule, match| match.to_s.length }
  end

  def string_after(match)
    match.post_match.lstrip
  end
end
