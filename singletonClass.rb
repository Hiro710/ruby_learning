=begin
  特異クラス定義を使うと、任意のオブジェクトに、そのオブジェクトだけで利用できる
  メソッド(特異メソッド)を追加できる。

  以下の例では、変数str1, str2に"Ruby"という文字列を代入し、str1が参照している
  文字列オブジェクトだけに、helloメソッドを追加している。
  このメソッドはstr1に対して呼び出せるがstr2ではエラーとなる。

  RubyではクラスはClassクラスのオブジェクトになっている為、Classクラスの
  インスタンスメソッドのほか、クラスオブジェクトに追加された特異メソッドが
  クラスメソッドとなる。
  (特異メソッドは英語でシングルトンクラス(singleton class)または
  アイゲンクラス(eigenclass)と言う)
=end

str1 = "Ruby"
str2 = "Ruby"

class << str1
  def hello
    "Hello, #{self} !"
  end
end

p str1.hello # => "Hello, Ruby !"
p str2.hello # => Error(NoMethodError)