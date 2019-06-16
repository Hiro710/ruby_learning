module HeyModule
  Version = "5.0" # 定数の定義

  # メソッドの定義
  def hey(name)
    puts "Hey, #{name}."
  end
  # heyをモジュール関数として公開する(必須)
  module_function :hey # メソッド名を表すシンボル
end

puts HeyModule::Version # => 5.0 (モジュール内部で定義した定数はモジュール名を経由して参照可能)
HeyModule.hey("Ruby King") # => Hey, Ruby King

include HeyModule # => インクルードしてみる
puts Version # => 5.0
hey("C Master") # => Hey, C Master


# モジュール名.メソッド名の呼び出しの際、メソッド中でself(レシーバ)を参照するとそのモジュールが得られる

# 同じメソッドであっても呼び出す文脈によって意味が違ってくるため、
# モジュール関数として定義したメソッドではselfを使わないのが普通
module FooModule
  def foo
    p self
  end

  module_function :foo
end

FooModule.foo # => FooModule


# Mix-in (クラスにモジュールを取り込む：)
module A
  def men
    "man"
  end
end

class Boo
  # BooクラスにモジュールAをインクルードする
  # モジュールAのメソッドをクラスBooのインスタンスメソッドとして使える
  include A
end

boo = Boo.new
p boo.men # => man
# インクルードされているか調べる
p Boo.include?(A) # => true

# ancestorsメソッドで継承関係にあるクラス一覧を取得できる
p Boo.ancestors # => [Boo, A, Object, HeyModule, Kernel, BasicObject]
# superclassメソッドの戻り値は、直接のスーパークラス
p Boo.superclass # => Object

# extendメソッド
module Edition
  def edition(n)
    "#{self} 第#{n}回"
  end
end

str = "たのしいるびぃ"
str.extend(Edition) # モジュールをオブジェクトにMix-inする
p str.edition(100) # => たのしいるびぃ 第100回


=begin
  クラスオブジェクトに対してextendメソッドを使うことでもクラスメソッドを追加できる。
  extendメソッドによってクラスにクラスメソッドを追加し、includeメソッドによって
  インスタンスメソッドを追加する例を以下に示す。
=end

module ClassMethods
  def cmethod
    "class method"
  end
end

module InstanceMethods
  def imethod
    "instance method"
  end
end

class MyClass
  # extendするとクラスメソッドを追加できる
  extend ClassMethods
  # includeするとインスタンスメソッドを追加できる
  include InstanceMethods
end

p MyClass.cmethod # => class method
p MyClass.new.imethod # => instance method

# まとめ
# includeを使うと継承の階層を越えてクラスにモジュールの機能を追加できる。
# extendメソッドはクラスを越えて、オブジェクト単位にモジュールの機能を利用できるようになる。