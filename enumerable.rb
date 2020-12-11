# mapとcollectは、与えられたブロックを評価した結果の配列を返す
p [1, 2, 3, 4, 5].map{|i| i ** 2}                 #=> [1, 4, 9, 16, 25]
p [1, 2, 3, 4, 5].collect{|i| i ** 2}             #=> [1, 4, 9, 16, 25]

# each_with_indexは、要素とそのインデックスをブロックに渡して繰り返す
=begin
  以下の結果：
  a => 0
  b => 1
  c => 2
  d => 3
  e => 4
  [:a, :b, :c, :d, :e]
=end
p [:a, :b, :c, :d, :e].each_with_index {|v, i| puts "#{v} => #{i}"}

=begin
  injectとreduceは自身のたたみ込み演算を行う
  引数としてたたみ込みを行う際の初期値をとる
  たたみ込み演算とは、初期値と自身の要素を順に組み合わせて結果を返す演算
=end

# 1から5までの数値の2乗の和を求める
p [1, 2, 3, 4, 5].inject(0) {|result, v| result + v ** 2}     #=> 55
p [1, 2, 3, 4, 5].reduce(0) {|result, v| result + v ** 2}     #=> 55

=begin
  each_sliceは要素を指定された数で区切ってブロックに渡す為、要素数が指定された数で割り切れない時には
  最後だけ渡される数が少なくなる
  each_consは先頭から要素を1つずつ選び、さらに余分に指定された数に合うように要素を選び、それらをブロックに
  渡していく
=end

=begin
  以下の出力：
  [1, 2, 3]
  [4, 5, 6]
  [7, 8, 9]
  [10]
  => nil
=end
(1..10).each_slice(3) {|items| p items}

=begin
  以下の出力：
  [1, 2, 3]
  [2, 3, 4]
  [3, 4, 5]
  [4, 5, 6]
  [5, 6, 7]
  [6, 7, 8]
  [7, 8, 9]
  [8, 9, 10]
  => nil
=end
(1..10).each_cons(3) {|items| p items}

# reverse_eachはeachとは逆順にブロックに要素を渡して繰り返す
=begin
  以下の出力：
  5
  4
  3
  2
  1
=end
[1, 2, 3, 4, 5].reverse_each {|i| puts i}

=begin
  all?は全ての要素が真であればtrueを、any?は真である要素が1つでもあればtrueを、
  none?は全ての要素が偽であればtrueを、one?は1つの要素だけが真であればtrueを返す
  member?とinclude?は、指定された値と==がtrueとなる要素があるときにtrueを返す
=end

p [1, nil, 3].all?                          #=> false
p [1, nil, 3].any?                          #=> true
p [1, nil, 3].none?                         #=> false
p [nil, nil, nil].none?                     #=> true
p [1, nil, 3].one?                          #=> false
p [1, nil, nil].one?                        #=> true
p [].all?                                   #=> true
p [].any?                                   #=> false
p [1, 2, 3, 4, 5].include?(3)               #=> true
p [1, 2, 3, 4, 5].member?(3)                #=> true

=begin
  findやdetectは、ブロックを評価して最初に真となる要素を返す
  find_indexは要素の代わりにインデックスを返す
  find_allやselectは、ブロックの評価結果が真となる全ての要素を返す
  逆にrejectは偽になった全ての要素を返す
  grepは指定したパターンとマッチする(==がtrueになる)要素を全て含んだ配列を返す
=end

p [1, 2, 3, 4, 5].find {|i| i % 2 == 0}           #=> 2
p [1, 2, 3, 4, 5].detect {|i| i % 2 == 0}         #=> 2
p [1, 2, 3, 4, 5].find_index {|i| i % 2 == 0}     #=> 1
p [1, 2, 3, 4, 5].find_all {|i| i % 2 == 0}       #=> [2, 4]
p [1, 2, 3, 4, 5].select {|i| i % 2 == 0}         #=> [2, 4]
p [1, 2, 3, 4, 5].reject {|i| i % 2 == 0}         #=> [1, 3, 5]
p [1, 2, 3, 4, 5].grep(2)                         #=> [2]

=begin
  sortは、要素を<=>で比較して昇順にソートした配列を新たに生成して返す
  ブロックを取る場合は、ブロックの評価結果を元にソートする
  sort_byはブロックの評価結果を<=>で比較して昇順にソートした配列を使って、
  元の配列をソートした新しい配列を生成して返す
=end

p ["aaa", "b", "cc"].sort {|a, b| a.length <=> b.length}        #=> ["b", "cc", "aaa"]
p ["aaa", "b", "cc"].sort_by {|a| a.length}                     #=> ["b", "cc", "aaa"]

=begin
  maxとminはそれぞれ要素の最大と最小を返す
  ただし<=>で比較するため、全ての要素がそれに対応している必要がある
  ブロックを渡すと、ブロックの評価結果を元に大小判定を行う
  max_byとmin_byはブロックの評価結果が最大であった要素を返す
=end

p (1..10).map {|v| v % 5 + v}                                   #=> [2, 4, 6, 8, 5, 7, 9, 11, 13, 10]
p (1..10).max {|a, b| (a % 5 + a) <=> (b % 5 + b)}              #=> 9
p (1..10).max_by {|v| v % 5 + v}                                #=> 9
p (1..10).min {|a, b| (a % 5 + a) <=> (b % 5 + b)}              #=> 1
p (1..10).min_by {|v| v % 5 + v}                                #=> 1

# countは要素数を返す
p [1, 2, 3, 4, 5].count                                         #=> 5

# cycleは要素を先頭から順に取り出し、末尾まで到達したら再度先頭に戻り、それを繰り返す
=begin
  :a
  :b
  :c
  :a
  :b
  :c
  ...(省略)
=end
# [:a, :b, :c].cycle {|v| p v}

# group_byはブロックの評価結果をキーとし、同じキーを持つ要素を配列としたハッシュを返す
p (1..10).group_by {|v| v % 2}                      #=> {1=>[1, 3, 5, 7, 9], 0=>[2, 4, 6, 8, 10]}

# zipは、自身と引数に指定した配列から、1つずつ要素を取り出して配列を作り、それを要素とする配列を返す
# 要素が足りない場合はnilが入る
p [:a, :b, :c].zip([1, 2, 3], ["a", "b", "c"])      #=> [[:a, 1, "a"], [:b, 2, "b"], [:c, 3, "c"]]
p [:a, :b, :c].zip([1, 2], ["a", "b"])              #=> [[:a, 1, "a"], [:b, 2, "b"], [:c, nil, nil]]

# firstとtakeは先頭から指定した数の要素を配列として返す
# firstのみ数を指定しない場合に先頭の要素のみを返す
p [:a, :b, :c].take(2)                              #=> [:a, :b]
p [:a, :b, :c].first(2)                             #=> [:a, :b]
p [:a, :b, :c].first                                #=> :a

# take_whileは先頭からブロックを評価し、最初に偽になった要素の直前までを返す
p [:a, :b, :c, :d, :e].take_while {|e| e != :d}     #=> [:a, :b, :c]

# dropはtakeとは逆に、先頭から指定した数の要素を取り除いた残りの要素を配列として返す
p [:a, :b, :c, :d, :e].drop(3)                      #=> [:d, :e]
p [:a, :b, :c, :d, :e].drop(2)                      #=> [:c, :d, :e]

# drop_whileは先頭からブロックを評価し、最初に偽になった要素の手前までを切り捨て、残りの要素を配列として返す
p [:a, :b, :c, :d, :e].drop_while {|e| e != :c}     #=> [:c, :d, :e]

# selectは各要素に対し、ブロックの評価結果が真であった要素を含む配列を返す
# 逆にrejectはブロックの評価結果が偽であった要素を含む配列を返す
p [1, 2, 3, 4, 5].select {|e| e % 2 == 0}           #=> [2, 4]
p [1, 2, 3, 4, 5].reject {|e| e % 2 == 0}           #=> [1, 3, 5]

# lazyはmapやselectなどのメソッドが、遅延評価を行うように再定義される
# 遅延評価になるとそれぞれのメソッドが配列ではなくEnumerator::Lazyを返すようになり、
# メソッドを評価するタイミングを遅らせることができる

p a = [1, 2, 3, 4, 5].lazy.select {|e| e % 2 == 0}  #=> #<Enumerator::Lazy: #<Enumerator::Lazy: [1, 2, 3, 4, 5]>:select>
p b = a.map {|e| e * 2}                             #=> #<Enumerator::Lazy: #<Enumerator::Lazy: #<Enumerator::Lazy: [1, 2, 3, 4, 5]>:select>:map>
p c = a.take(3)                                     #=> #<Enumerator::Lazy: #<Enumerator::Lazy: #<Enumerator::Lazy: [1, 2, 3, 4, 5]>:select>:take(3)>
p c.to_a      # ここで評価される                       #=> [2, 4]

