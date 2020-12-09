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

