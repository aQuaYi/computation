# treetop 语法解析

```shell
# 安装 treetop
gem install treetop

# 从本目录进入 irb
$ irb -I

# 以下二行，二选一
$ require_relative '..\big-step\all.rb'
$ require_relative '..\denotational\all.rb'

$ require 'treetop'
true

$ Treetop.load('simple')
SimpleParser

$ parse_tree = SimpleParser.new.parse('if (x + 1 < 5) { x = x * 2 } else { x = x + 1 }')
...

$ statement = parse_tree.to_ast
«if (x + 1 < 5) { x = x * 2 } else { x = x + 1 }»

$ statement.evaluate({x:Number.new(1)})
...
```

