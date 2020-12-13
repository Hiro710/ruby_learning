=begin
  Comparableモジュールをインクルードすると、インクルードしたクラスで<=>をもとにオブジェクト同士の比較ができるようになる
  インクルードしたクラスで使えるインスタンスメソッドは以下のとおり

  <
  <=
  ==
  >
  >=
  between?
=end

=begin
  メソッドがtrueを返す場合の<=>演算子の返り値

  <     負の整数
  <=    負の整数か0
  ==    0
  >     正の整数
  >=    正の整数か0
=end

# 例として以下の様なSampleクラスを考える
# このSampleクラスは通常の大小関係とは逆の挙動をする様に実装されていることに注意
# Sampleクラスの定義

p class Sample
    def initialize(value)
      @value = value
    end

    def value
      @value
    end

    def <=>(other)
      other.value <=> self.value
    end
  end     #=> :<=>

# 上記のクラスにComparableモジュールをインクルードした場合、それぞれのメソッドの返り値は以下になる
# このSampleクラスは通常の大小関係とは逆の挙動をする様に実装されていることに注意
# Sampleクラスでの比較の例

class Sample

  include Comparable

  def initialize(value)
    @value = value
  end

  def value
    @value
  end

  def <=>(other)
    other.value <=> self.value
  end
end

p a = Sample.new(10)      #=> #<Sample:0x00007feb5b0c0820 @value=10>
p b = Sample.new(5)       #=> #<Sample:0x00007feb5b0c0550 @value=5>
p a < b                   #=> true
p a <= b                  #=> true
p a == b                  #=> false
p a > b                   #=> false
p a >= b                  #=> false
