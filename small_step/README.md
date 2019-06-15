# 小步语义

在命令行的当前目录下运行

```shell
ruby main.rb
```

或者在当前命令行输入

```shell
irb -I
require_relative 'all'
```

然后开始编写自己的 simple 代码。

## 统一的虚拟机

按照书上的写法，由于 statement 会更新 environment， 而 expression 不会。所以，作者提供了两个虚拟机 `ExpressionMachine` 和 `StatementMachine`。生成虚拟机的代码在[这里](https://github.com/tomstuart/computationbook/blob/master/the_meaning_of_programs/small_step/machine.rb)。

但是，也可以换一种思路，让 `expression` 也更新 environment，只是这个更新的动作是什么也不做。

以 `Add` 为例，把他的 `reduce` 方法由

```ruby
  def reduce(environment)
    if left.reducible?
      Add.new(left.reduce(environment), right)
    elsif right.reducible?
      Add.new(left, right.reduce(environment))
    else
      Number.new(left.value + right.value)
    end
  end
```

变更成

```ruby
def reduce(environment)
    if left.reducible?
      left_reduce,  environment = left.reduce(environment)
      [Add.new(left_reduce, right), environment]
    elsif right.reducible?
      right_reduce, environment = right.reduce(environment)
      [Add.new(left, right_reduce), environment]
    else
      [Number.new(left.value + right.value), environment]
    end
  end
```

就可以了。
