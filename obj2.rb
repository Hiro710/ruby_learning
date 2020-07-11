# オブジェクトのメソッド一覧
=begin
  オブジェクトに定義されているメソッドを取得
  一覧を配列で返す
  配列の要素はメソッド名のシンボル
  methods
  private_methods
  protected_methods
  public_methods
  singleton_methods
=end
a = "foo"
p a.methods # 配列で呼び出し可能なメソッドがシンボルで返される

# オブジェクトの複製
=begin
  オブジェクトの複製には以下のメソッドが使われる
  clone
  dup
  dupメソッドが汚染状態(taint),インスタンス変数,ファイナライザを複製するが、
  cloneメソッドはそれに加えて凍結状態(freeze),特異メソッドも複製する
  自分自身の複製しかできないため、例えば配列の要素の参照先は、cloneメソッドや
  dupメソッドでは複製できない
=end
p a = "hoge"
p a.object_id
p b = a.dup #=> hoge
p b.object_id # aとは異なるオブジェクトID

# オブジェクトの凍結
# オブジェクトの内容の変更を禁止するにはfreezeメソッドを使う
# 凍結されたオブジェクトを変更しようとするとRuntimeErrorが発生する
p a = "abc"
p a.freeze
# p a[0] = 'z' #=> RuntimeError: can't modify frozen String: "abc"

# オブジェクトの汚染
=begin
  オブジェクトの「汚染マーク」がセットされている場合、tainted?メソッドが
  trueを返す
  また、「汚染マーク」を付けるにはtaintメソッドを、外すにはuntaintメソッドを使う
=end
a = "string"
p a.tainted? #=> false
a.taint      # 「汚染マーク」を付ける
p a.tainted? #=> true
a.untaint    # 「汚染マーク」を外す
p a.tainted? #=> false

# オブジェクトのインスタンス変数にアクセスする
=begin
  インスタンス変数の取得: instance_variable_get
  インスタンス変数の設定: instance_variable_set
  インスタンス変数の一覧: instance_variables
=end
p class Foo
  def initialize
    @hoge = 1
  end
end #=> :initialize

# インスタンス変数は:@hogeのようにシンボルか"@hoge"のような文字列で指定する事に注意
f = Foo.new
p f.instance_variables #=> [:@hoge]
p f.instance_variable_get(:@hoge) #=> 1
p f.instance_variable_set(:@hoge, 2) #=> 2
p f.instance_variable_get(:@hoge) #=> 2