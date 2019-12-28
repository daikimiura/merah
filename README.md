# Merah

Merah is a JVM implementation by Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'merah'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install merah

## Usage

```
$ (bundle exec) merah <prath/to/your/classfile>
```

## Reference
[RubyでJVMを実装してみる (平成Ruby会議01発表スライド)](https://speakerdeck.com/daikimiura/implement-jvm-with-ruby)

## TODO
- [ ] ニーモニックの実装
   - [ ] aaload
    - [ ] aastore
    - [ ] aconst_null
    - [ ] aload
    - [ ] aload_0
    - [ ] aload_1
    - [ ] aload_2
    - [ ] aload_3
    - [ ] anewarray
    - [ ] areturn
    - [ ] arraylength
    - [ ] astore
    - [ ] astore_0
    - [ ] astore_1
    - [ ] astore_2
    - [ ] astore_3
    - [ ] athrow
    - [ ] baload
    - [ ] bastore
    - [ ] bipush
    - [ ] breakpoint
    - [ ] caload
    - [ ] castore
    - [ ] checkcast
    - [ ] d2f
    - [ ] d2i
    - [ ] d2l
    - [ ] dadd
    - [ ] daload
    - [ ] dastore
    - [ ] dcmpg
    - [ ] dcmpl
    - [ ] dconst_0
    - [ ] dconst_1
    - [ ] ddiv
    - [ ] dload
    - [ ] dload_0
    - [ ] dload_1
    - [ ] dload_2
    - [ ] dload_3
    - [ ] dmul
    - [ ] dneg
    - [ ] drem
    - [ ] dreturn
    - [ ] dstore
    - [ ] dstore_0
    - [ ] dstore_1
    - [ ] dstore_2
    - [ ] dstore_3
    - [ ] dsub
    - [ ] dup
    - [ ] dup_x1
    - [ ] dup_x2
    - [ ] dup2
    - [ ] dup2_x1
    - [ ] dup2_x2
    - [ ] f2d
    - [ ] f2i
    - [ ] f2l
    - [ ] fadd
    - [ ] faload
    - [ ] fastore
    - [ ] fcmpg
    - [ ] fcmpl
    - [ ] fconst_0
    - [ ] fconst_1
    - [ ] fconst_2
    - [ ] fdiv
    - [ ] fload
    - [ ] fload_0
    - [ ] fload_1
    - [ ] fload_2
    - [ ] fload_3
    - [ ] fmul
    - [ ] fneg
    - [ ] frem
    - [ ] freturn
    - [ ] fstore
    - [ ] fstore_0
    - [ ] fstore_1
    - [ ] fstore_2
    - [ ] fstore_3
    - [ ] fsub
    - [ ] getfield
    - [x] getstatic
    - [ ] goto
    - [ ] goto_w
    - [ ] i2b
    - [ ] i2c
    - [ ] i2d
    - [ ] i2f
    - [ ] i2l
    - [ ] i2s
    - [ ] iadd
    - [ ] iaload
    - [ ] iand
    - [ ] iastore
    - [ ] iconst_m1
    - [x] iconst_0
    - [x] iconst_1
    - [x] iconst_2
    - [x] iconst_3
    - [x] iconst_4
    - [x] iconst_5
    - [ ] idiv
    - [ ] if_acmpeq
    - [ ] if_acmpne
    - [ ] if_icmpeq
    - [ ] if_icmpge
    - [ ] if_icmpgt
    - [ ] if_icmple
    - [ ] if_icmplt
    - [ ] if_icmpne
    - [ ] ifeq
    - [ ] ifge
    - [ ] ifgt
    - [ ] ifle
    - [ ] iflt
    - [ ] ifne
    - [ ] ifnonnull
    - [ ] ifnull
    - [ ] iinc
    - [ ] iload
    - [x] iload_0
    - [x] iload_1
    - [x] iload_2
    - [x] iload_3
    - [ ] impdep1
    - [ ] impdep2
    - [ ] imul
    - [ ] ineg
    - [ ] instanceof
    - [ ] invokedynamic
    - [ ] invokeinterface
    - [ ] invokespecial
    - [ ] invokestatic
    - [x] invokevirtual
    - [ ] ior
    - [ ] irem
    - [ ] ireturn
    - [ ] ishl
    - [ ] ishr
    - [ ] istore
    - [x] istore_0
    - [x] istore_1
    - [x] istore_2
    - [x] istore_3
    - [ ] isub
    - [ ] iushr
    - [ ] ixor
    - [ ] jsr
    - [ ] jsr_w
    - [ ] l2d
    - [ ] l2f
    - [ ] l2i
    - [ ] ladd
    - [ ] laload
    - [ ] land
    - [ ] lastore
    - [ ] lcmp
    - [ ] lconst_0
    - [ ] lconst_1
    - [x] ldc
    - [ ] ldc_w
    - [ ] ldc2_w
    - [ ] ldiv
    - [ ] lload
    - [ ] lload_0
    - [ ] lload_1
    - [ ] lload_2
    - [ ] lload_3
    - [ ] lmul
    - [ ] lneg
    - [ ] lookupswitch
    - [ ] lor
    - [ ] lrem
    - [ ] lreturn
    - [ ] lshl
    - [ ] lshr
    - [ ] lstore
    - [ ] lstore_0
    - [ ] lstore_1
    - [ ] lstore_2
    - [ ] lstore_3
    - [ ] lsub
    - [ ] lushr
    - [ ] lxor
    - [ ] monitorenter
    - [ ] monitorexit
    - [ ] multianewarray
    - [ ] new
    - [ ] newarray
    - [ ] nop
    - [ ] pop
    - [ ] pop2
    - [ ] putfield
    - [ ] putstatic
    - [ ] ret
    - [x] return
    - [ ] saload
    - [ ] sastore
    - [ ] sipush
    - [ ] swap
    - [ ] tableswitch
    - [ ] wide
- [ ] 別クラスの呼び出し
- [ ] .jarの実行
- [ ] インスタンスの初期化
- [ ] メソッド呼び出し時/インスタンス初期化時の型チェック


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/merah. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Merah project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/merah/blob/master/CODE_OF_CONDUCT.md).
