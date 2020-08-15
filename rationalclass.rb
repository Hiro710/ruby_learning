# Rationalクラスは有理数を扱うNumericクラスのサブクラス
=begin
  有理数は二つの整数a, b(b=0以外)を用いてa / bという分数で表現できる数のこと
  有理数の四則演算
  a / b + c / d = ad + bc / bd
  a / b - c / d = ad - bc / bd
  a / b × c / d = ac / bd
  a / b ÷ c / d = ad / bc
=end

# Rationalクラスによる有理数
# 有理数のインスタンスを作成するには以下の様にする、ここではaが分子、bが分母
# Rational(a, b = 1)

# 有理数の分母を求めるにはdenominatorメソッドを、分子を求めるにはnumeratorメソッドを使う
# Numericクラスでもdenominatorメソッド、numeratorメソッドが使える
# この時の返り値は自身をRationalに変換した場合に対応する値
p a = Rational(1, 2) #=> (1/2)
p a.denominator      #=> 2
p a.numerator        #=> 1
p 0.25.denominator   #=> 4
p 0.25.numerator     #=> 1

# divmodメソッドは引数otherで除算した結果とその剰余を配列で返す
# またabsメソッドは絶対値を返す
p Rational(1, 2).divmod Rational(1, 3) #=> [1, (1/6)]
p Rational(-4, 13).abs #=> (4/13)

=begin
  floor, ceil, truncate, roundメソッドの意味
  floor    小さい方の整数に丸める
  ceil     大きい方の整数に丸める
  truncate 0に近い方の整数に丸める
  round    絶対値を四捨五入する
=end

# Rationalクラスと他のNumericクラスとの四則演算
# 演算の対象がRationalまたはIntegerの場合、演算結果はRationalで、対象がFloatの場合、演算結果はFloatで返す
p Rational(1, 2) + Rational(1, 3) #=> (5/6)
p Rational(1, 2) + 1              #=> (3/2)
p Rational(1, 2) + 0.25           #=> 0.75