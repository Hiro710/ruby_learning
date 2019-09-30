# 二項演算子
# 二項演算子の定義には演算子をメソッド名としてメソッドを定義する。
# 演算子の左側の項がレシーバとなり、右側の項がメソッドの引数として渡される。
# 以下例は、二次元座標を表すPointクラスを作って、演算子+と-を定義している。
class Point
  attr_accessor :x, :y # 読み書き可能

  def initialize(x = 0, y = 0)
    @x , @y = x, y
  end

  def inspect # pメソッドで「(x, y)」と表示する
    "（#{x}, #{y}）"
  end

  def +(other) # x, yそれぞれ足す
    self.class.new(x + other.x, y + other.y)
  end

  def -(other) # x, yそれぞれ引く
    self.class.new(x - other.x, y - other.y)
  end
end

point0 = Point.new(3, 6)
point1 = Point.new(1, 8)
point2 = Point.new(10, 50)

p point0 #=> (3, 6)
p point1 #=> (1, 8)
p point2 #=> (10, 50)
p point0 + point1 #=> (4, 14)
p point0 - point1 #=> (2, -2)
p point0 + point1 + point2 #=> (14, 64)
p point0 - point1 - point2 #=> (-8, -52)

=begin
  二項演算子を定義する時は引数名として「other」がよく用いられる。
  なお、演算子+と-の中で、新しいPointオブジェクトを作る際に「self.class.new」
  としているが、以下の様にPoint.newメソッドを使うこともできる。

  def +(other)
    Point.new(x + other.x, y + other.y)
  end

  この場合は戻り値として必ずPointオブジェクトが返される。
  逆に、Pointクラスを継承したサブクラスのオブジェクトで演算子+や-を使った
  時にはサブクラスのオブジェクトを返す方が適切なケースがあるが、
  この書き方はPointオブジェクトしか返すことができない。
  メソッド内で同じクラスのオブジェクトを作るときは、クラスを名前で記述するのではなく
  「self.class」で、その時の実際のクラスを参照してnewメソッドを呼ぶ方が、継承やMix-in
  に柔軟に対応できる。
=end
