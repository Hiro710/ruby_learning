# 数値型クラス(Numeric, Integer, Fixnum, Bignum, Float, Complex, Rational)
# Rationalクラスは有理数を扱うクラス、Complexクラスは複素数を扱うクラス

# 数値の切り捨て、切り上げ
=begin
  小数点以下の切り捨て、切り上げには以下のメソッドを使う
  ceil
  floor
  round
  truncate

  ceilメソッドはそれ自身と同じかそれ自身より大きな整数のうち、最小のものを返す
  floorメソッドは逆にそれ自身より小さな整数のうち最大のものを返す
  roundメソッドは最も近い整数返す(最も近い整数が2つある場合は0から遠い方を返す)
  truncateメソッドはそれ自身と0の間にある整数で最も近いものを返す
=end
p 1.9.ceil        #=> 2
p 1.9.floor       #=> 1
p 1.9.round       #=> 2
p 1.9.truncate    #=> 1
p -1.1.ceil       #=> -1
p -1.1.floor      #=> -2
p -1.1.round      #=> -1
p -1.1.truncate   #=> -1

# 数値の絶対値を求めるにはabsメソッドを使う
p -3.abs #=> 3

# 数値を使った繰り返し(stepメソッド、downtoメソッド)
# 以下は1〜100までの奇数を表示する
1.step(100, 2){|n| puts n}
