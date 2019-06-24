# frozen_string_literal: true

require_relative 'helpers'

# Nonnegative integers

ZERO    = ->(_p) { ->(x) { x } }
ONE     = ->(p) { ->(x) {     p[x] } }
TWO     = ->(p) { ->(x) {   p[p[x]]  } }
THREE   = ->(p) { ->(x) { p[p[p[x]]] } }
FIVE    = ->(p) { ->(x) { p[p[p[p[p[x]]]]] } }
FIFTEEN = ->(p) { ->(x) { p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[x]]]]]]]]]]]]]]] } }
HUNDRED = ->(p) { ->(x) { p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[x]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]] } }

# Booleans

True  = ->(x) { ->(_y) { x } }
False = ->(_x) { ->(y) { y } }
IF    = ->(b) { b }

# verb
IS_ZERO = ->(n) { n[->(_x) { False }][True] }

# Pairs

PAIR  = ->(x) { ->(y) { ->(f) { f[x][y] } } }
LEFT  = ->(p) { p[->(x) { ->(_y) { x } }] }
RIGHT = ->(p) { p[->(_x) { ->(y) { y } }] }

# Arithmetic

INCREMENT = ->(n) { ->(p) { ->(x) { p[n[p][x]] } } }
SLIDE     = ->(p) { PAIR[RIGHT[p]][INCREMENT[RIGHT[p]]] }
DECREMENT = ->(n) { LEFT[n[SLIDE][PAIR[ZERO][ZERO]]] }

ADD       = ->(m) { ->(n) { n[INCREMENT][m] } }
SUBTRACT  = ->(m) { ->(n) { n[DECREMENT][m] } }
MULTIPLY  = ->(m) { ->(n) { n[ADD[m]][ZERO] } }
POWER     = ->(m) { ->(n) { n[MULTIPLY[m]][ONE] } }

IS_LESS_OR_EQUAL = ->(m) { ->(n) { IS_ZERO[SUBTRACT[m][n]] } }

# Combinators

YC = ->(f) { ->(x) { f[x[x]] }[->(x) { f[x[x]] }] }
ZC = ->(f) { ->(x) { f[->(y) { x[x][y] }] }[->(x) { f[->(y) { x[x][y] }] }] }

MOD =
  ZC[lambda { |f|
       lambda { |m|
         lambda { |n|
           IF[IS_LESS_OR_EQUAL[n][m]][
        lambda { |x|
          f[SUBTRACT[m][n]][n][x]
        }
           ][
        m
           ]
         }
       }
     } ]

DIV =
  ZC[lambda { |f|
       lambda { |m|
         lambda { |n|
           IF[IS_LESS_OR_EQUAL[n][m]][
        lambda { |x|
          INCREMENT[f[SUBTRACT[m][n]][n]][x]
        }
           ][
        ZERO
           ]
         }
       }
     } ]

# Lists

EMPTY     = PAIR[True][True]
UNSHIFT   = ->(l) { ->(x) { PAIR[False][PAIR[x][l]] } }
IS_EMPTY  = LEFT
FIRST     = ->(l) { LEFT[RIGHT[l]] }
REST      = ->(l) { RIGHT[RIGHT[l]] }

RANGE =
  ZC[lambda { |f|
    lambda { |m|
      lambda { |n|
        IF[IS_LESS_OR_EQUAL[m][n]][
          lambda { |x|
            UNSHIFT[f[INCREMENT[m]][n]][m][x]
          }
        ][
          EMPTY
        ]
      }
    }
  }]

FOLD =
  ZC[lambda { |f|
    lambda { |l|
      lambda { |x|
        lambda { |g|
          IF[IS_EMPTY[l]][
            x
          ][
            lambda { |y|
              g[f[REST[l]][x][g]][FIRST[l]][y]
            }
          ]
        }
      }
    }
  }]

MAP =
  lambda { |k|
    lambda { |f|
      FOLD[k][EMPTY][
        ->(l) { ->(x) { UNSHIFT[l][f[x]] } }
      ]
    }
  }

PUSH =
  lambda { |l|
    lambda { |x|
      FOLD[l][UNSHIFT[EMPTY][x]][UNSHIFT]
    }
  }

# Strings

TEN = MULTIPLY[TWO][FIVE]
B   = TEN
F   = INCREMENT[B]
I   = INCREMENT[F]
U   = INCREMENT[I]
Z   = INCREMENT[U]

WORD = ->(a) { ->(b) { ->(c) { ->(d) { ->(e) { UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[e][d]][c]][b]][a] } } } } }
FIZZ_ = WORD[F][I][Z][Z]
FIZZ = FIZZ_[EMPTY]
BUZZ = WORD[B][U][Z][Z][EMPTY]
FIZZBUZZ = FIZZ_[BUZZ]

TO_DIGITS =
  ZC[lambda { |f|
       lambda { |n|
         PUSH[
     IF[IS_LESS_OR_EQUAL[n][DECREMENT[TEN]]][
  EMPTY
     ][
  lambda { |x|
    f[DIV[n][TEN]][x]
  }
     ]
  ][MOD[n][TEN]]
       }
     } ]

# The FizzBuzz solution

FIVETY = MULTIPLY[FIVE][TEN]
HF = ADD[FIVETY][HUNDRED]

SOLUTION =
  MAP[RANGE[ONE][HF]][lambda { |n|
    IF[IS_ZERO[MOD[n][FIFTEEN]]][
      FIZZBUZZ
    ][IF[IS_ZERO[MOD[n][THREE]]][
      FIZZ
    ][IF[IS_ZERO[MOD[n][FIVE]]][
      BUZZ
    ][
      TO_DIGITS[n]
    ]]]
  }]
