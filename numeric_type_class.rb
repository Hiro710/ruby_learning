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

# Integerクラス
p 2.**(4) #=> 16
p 2**4    #=> 16

# 整数の除算
p 10 / 3  #=> 3
p 10 / 3.0  #=> 3.3333333333333335 どちらかが小数なら小数を返す

# 整数に対応する文字を求める
# アスキーコードに対応する文字を求めるにはchrメソッドを使う。ただし対応する文字が存在しない場合にはRangeErrorになる
p 65.chr  #=> "A"
# p -1.chr  #=> -1 out of char range (RangeError)

# 次の整数、前の整数を求める
# nextメソッド(succメソッド)は次の整数を、predメソッドは自身の数から-1した整数を返す
p 10.next #=> 11
p 10.succ #=> 11
p 10.pred #=> 9

# 整数を使った繰り返し(times, upto, downto)
# timesメソッドはその整数の数だけ、uptoメソッドとdowntoメソッドはある整数からある整数まで与えられたブロックを実行する
p sum = 0 #=> 0
p 10.times {|i| sum += i} #=> 10
puts sum #=> 45
