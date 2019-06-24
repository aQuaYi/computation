# frozen_string_literal: true

def to_integer(proc)
  proc[->(n) { n + 1 }][0]
end

def to_boolean(proc)
  IF[proc][true][false]
end

def to_array(proc)
  array = []

  until to_boolean(IS_EMPTY[proc])
    array.push(FIRST[proc])
    proc = REST[proc]
  end

  array
end

def to_char(char)
  '0123456789BFiuz'.slice(to_integer(char))
end

def to_string(str)
  to_array(str).map { |c| to_char(c) }.join
end
