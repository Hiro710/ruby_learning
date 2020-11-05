# 配列の生成_1
p a = [1, 2, 3]                  #=> [1, 2, 3]
p a.class                        #=> Array

# 配列の生成_2
p Array[1, 2, 3]                 #=> [1, 2, 3]

# 配列の生成_3
# Array.new(配列の長さ, 初期値)
p Array.new(3, "str")            #=> ["str", "str", "str"]

# 配列の生成_4
# 引数に配列を指定すると、その配列を複製する
p Array.new([1, 2, 3])           #=> [1, 2, 3]

# 配列の生成_5
# 引数に配列の長さとブロックを渡す
# ブロックには配列のインデックスが渡され、ブロックの評価結果を各要素の値として設定する
p Array.new(3) { |i| i * 3 }     #=> [0, 3, 6]

=begin
  配列に要素を追加する

  <<
  push
  concat
  insert
  +
  unshift

  <<とpushは、指定された引数にあるオブジェクトを自身の末尾に追加する
  concatは指定された配列を、自身の末尾に連結する
  insertは1番目の引数で指定された場所に、それ以降で指定されたオブジェクトを挿入する
  unshiftは指定されたオブジェクトを配列の先頭に追加する
  以上は破壊的メソッドで元のオブジェクトの内容を書き換える

  +は自身と引数で与えられた配列を連結した配列を新たに生成して返す
=end

a = [1, 2, 3]
p a << 4                  #=> [1, 2, 3, 4]
p a.concat [5, 6]         #=> [1, 2, 3, 4, 5, 6]
p a.insert(3, 7)          #=> [1, 2, 3, 7, 4, 5, 6]
p a.object_id             #=> 60
p b = a + [10]            #=> [1, 2, 3, 7, 4, 5, 6, 10]
p b.object_id             #=> 80
a = [1, 2, 3]
p a.unshift(10)           #=> [10, 1, 2, 3]

=begin
  配列の要素を変更する

  []は指定したインデックスにある要素を書き換える
  インデックスは、整数やRangeオブジェクト、始点と終点を指定できる
  配列の要素数よりも大きな数が指定された場合には、自動的に配列の長さが伸長され、
  伸長された部分はnilで初期化される
=end

a = [1, 2, 3]
p a[1] = 10              #=> 10
p a                      #=> [1, 10, 3]
p a[1..2] = [50, 100]    #=> [50, 100]
p a                      #=> [1, 50, 100]
p a[8] = 8               #=> 8
p a                      #=> [1, 50, 100, nil, nil, nil, nil, nil, 8]

=begin
  fillは、配列のすべての要素を指定したオブジェクトに変更する
  引き数を2つ以上とる場合には、配列の始点と終点や、
  Rangeオブジェクトを取ることもでき、その場合は該当する部分のみ変更する
  ブロックを取ることもでき、その場合はブロックの評価結果で要素を変更する
=end

a = [1, 2, 3]
p a.fill("s")                       #=> ["s", "s", "s"]
p a.fill("A", 1..2)                 #=> ["s", "A", "A"]    
p a                                 #=> ["s", "A", "A"]
p a.fill(1..3) { |index| index }    #=> ["s", 1, 2, 3]

# replaceは引数で指定された配列で自分自身の内容を置き換える
# ＝での再代入とは異なり、replaceを使った場合にはオブジェクトIDが変化しない

a = [1, 2, 3]
p a.object_id           #=> 100
a = [1, 2, 3]
p a.object_id           #=> 120
p a.replace([4, 5, 6])  #=> [4, 5, 6]
p a.object_id           #=> 120

=begin
  配列の要素を参照する

  []
  slice
  values_at
  at
  fetch
  first
  last
  assoc
  rassoc

  []は変更の場合と同様に、整数やRangeオブジェクト、始点と終点で指定したインデックスに対応する要素を返す
  sliceも同様の動作をする、また、インデックスが整数の場合には、atも利用でき、
  インデックスが要素数よりも大きな場合にはnilを返す
  values_atも[]と同様の動作をするが、結果を配列で返すという違いがある
=end

a = [1, 2, 3]
p a[1]            #=> 2
p a.at(1)         #=> 2
p a[1..2]         #=> [2, 3]
p a.values_at(1)  #=> [2]

=begin
  fetchメソッドは基本的にはatと同じだが、インデックスが要素数よりも大きな場合の振る舞いが異なる
  引数がインデックスのみの場合にはIndexErrorが発生する
  2番目の引数がある場合にはその値を、ブロックを取っている場合にはその評価結果を返す
=end

a = [1, 2, 3]
# p a.fetch(4)                        #=> `fetch': index 4 outside of array bounds: -3...3 (IndexError)
# p a.fetch 4 , "ERROR"               #=> "ERROR"
# p a.fetch(4) { |n|  "ERROR #{n}" }  #=> "ERROR 4"

# firstは配列要素の先頭を、lastは末尾の要素を返す
# 引数が指定された場合は、それぞれ先頭と末尾から指定した数だけ要素を返す
a = [1, 2, 3, 4, 5]
p a.first       #=> 1
p a.last        #=> 5
p a.first(3)    #=> [1, 2, 3]
p a.last(3)     #=> [3, 4, 5]

# assocは配列の配列を検索し、その配列の最初の要素が指定された値と==で等しければその配列を返す
# 該当する要素がなければnilを返す
a = [[1, 2], [300, 4], [50, 6], [70, 8]]
p a.assoc(300)    #=> [300, 4]

# rassocは配列の配列を検索し、その配列のインデックス1の要素が指定された値と==で等しければその配列を返す
a = [[1, 2], [300, 4], [50, 6], [70, 8]]
p a.rassoc(6)    #=> [50, 6]

# 配列の要素を調べる
# include?, index, rindex
# include?は指定された値が要素の中に存在する場合に真を返す
a = [1, 2, 3, 4, 5]
p a.include?(3)     #=> true
p a.include?(10)    #=> false

# indexとrindexはそれぞれ配列の先頭と末尾から指定された値と==で等しい要素の位置を返す
# 見つからない場合にはnilを返す
a = [1, 2, 3, 4, 5]
p a.index(4)        #=> 3
p a.rindex(4)       #=> 3

# 配列の要素を削除する
# delete_at, delete_if, reject!, delete, clear, slice!, shift, pop, -
# delete_atは指定されたインデックスに対応する要素を取り除き、その要素を返す
a = [1, 2, 3, 4, 5]
p a.delete_at(2)    #=> 3
p a                 #=> [1, 2, 4, 5]

# delete_ifはブロックに要素を渡し、その評価結果が真になった要素を全て取り除いた自分自身を返す
# reject!も同様
a = [1, 2, 3, 4, 5]
p a.delete_if{ |n| n % 2 == 0 }   #=> [1, 3, 5]

# deleteは指定された値と==メソッドで等しい要素があれば取り除いてその値を、無ければnilを返す
a = [1, 2, 3, 4, 5]
p a.delete(3)     #=> 3
p a               #=> [1, 2, 4, 5]
p a.delete(10)    #=> nil
p a               #=> [1, 2, 4, 5]

# clearは要素を全て削除する
a = [1, 2, 3, 4, 5]
p a.clear         #=> []

# slice!は指定したインデックスに対応する要素を取り除き、その取り除いた要素を返す
# インデックスには整数やRangeオブジェクト、視点と長さを指定できる
a = [1, 2, 3, 4, 5]
p a.slice!(2, 2)  #=> [3, 4]
p a               #=> [1, 2, 5]

# shiftは先頭から指定された数だけ要素を取り除いて返す
# 指定がなければ、1が指定されたとして先頭の要素を返す
a = [1, 2, 3, 4, 5]
p a.shift(2)      #=> [1, 2]
p a               #=> [3, 4, 5]
p a.shift         #=> 3
p a               #=> [4, 5]

# popはshiftとは逆に、末尾から指定された数だけ要素を取り除いて返す
# 指定がなければ、1が指定されたとして末尾の要素を返す
a = [1, 2, 3, 4, 5]
p a.pop(2)        #=> [4, 5]
p a               #=> [1, 2, 3]
p a.pop           #=> 3
p a               #=> [1, 2]

# 「-」は指定された配列にある要素を、自分自身から取り除いた配列を返す
a = [1, 2, 3, 4, 5]
p a - [1, 2]        #=> [3, 4, 5]
p a - [1, 3, 5, 7]  #=> [2, 4]
p a                 #=> [1, 2, 3, 4, 5] 「-」は破壊的メソッドではない点に注意！