=begin
  クラスを継承する。
  継承を行うには以下のようにする。
  class クラス名 < スーパークラス名
      クラスの定義
  end
    
  以下の例はArrayクラスを継承したクラスRingArrayを作成。
  RingArrayクラスで必要な変更は、配列に使われる演算子[]を
  再定義するするだけ。
  superは、スーパークラスの同名のメソッド(この場合はArray#[])
  を呼び出す。
=end
class RingArray < Array
  def [](i)
      idx = i %size
      super(idx)
  end
end

wday = RingArray["日", "月", "火", "水", "木", "金", "土"]
p wday[6]
p wday[11]
p wday[15]
p wday[-1]
p wday[-2]