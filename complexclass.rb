# Complexクラスは複素数を扱うNumericクラスのサブクラス
=begin
  複素数は、実部aと虚部bから成り、a + bi(a, bは実数、iは虚数単位で-1の平方根のうち任意の一方)で表すことができる数の事
  虚数は、複素数のうちb=0以外となる任意の値なので、実数として表現できない
  そのため複素数の四則演算では以下の様に実部と虚部を別々に計算する
  (a + bi) + (c + di) = (a + c) + (b + d)i
  (a + bi) - (c + di) = (a - c) + (b - d)i
  (a + bi) × (c + di) = (ac - bd) + (bc + ad)i
  a + bi / c + di = (ac + bd / c**2 + d**2) + (bc - ad / c**2 + d**2)i
=end

# Complexクラスによる複素数(aが実部でbが虚部)
# Complex(a, b)
# 複素数リテラルでは虚部の数値の後にiをつけて表すことができる
p a = (1 + 2i) #=> (1+2i)

# 複素数の実部と虚部は、realメソッドとimaginaryメソッドで取得可能
# Numericクラスでもrealメソッドとimaginaryメソッドが使える。この時、realメソッドはselfを、imaginaryメソッドは0を返す
p a = (1 + 2i) #=> (1+2i)
p a.real       #=> 1
p a.imaginary  #=> 2
p 3.real       #=> 3
p 3.imaginary  #=> 0

# 絶対値を返すのがabsメソッド、偏角を返すのがargメソッド、絶対値と偏角を配列で返すのがpolarメソッド
# 複素数から極座標への変換
p Complex(1, 3).abs #=> 3.1622776601683795
p Complex(1, 3).arg #=> 1.2490457723982544
p Complex(1, 3).polar #=> [3.1622776601683795, 1.2490457723982544]

# Complexクラスと他のNumericクラスとの四則演算
# NumericクラスのサブクラスもComplexインスタンスと同じ様にrealメソッド、imaginaryメソッドが使えるため、
# ComplexインスタンスとBignum, Fixnum, Floatなどのインスタンス間で四則演算可能
# 四則演算の結果はComplexクラスのインスタンスで返す
# 以下はComplexクラスのインスタンスとFloatクラスのインスタンスの四則演算
p Complex(1, 1) + 0.5 #=> (1.5+1i)