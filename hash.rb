# ハッシュの生成
# ハッシュはハッシュ式と呼ばれる記法や、Hashクラスのクラスメソッドである[]やnewメソッドを使って生成される
p a = {"apple" => "fruit", "coffee" => "drink"}   #=> {"apple"=>"fruit", "coffee"=>"drink"}
p a.class                                         #=> Hash

# []はキーと値を順番にカンマで列挙する
p Hash["apple", "fruit", "coffee", "drink"]       #=> {"apple"=>"fruit", "coffee"=>"drink"}

# newメソッドでも生成でき、この場合はキーが存在しない場合の初期値を設定できる
p a = Hash.new                                    #=> {}
p a["apple"]                                      #=> nil
p a = Hash.new("NONE")                            #=> {}
p a["apple"]                                      #=> "NONE"

# 初期値はキーによって変更できる
# newはブロックを取ることができ、ブロックには自身とキーが渡される
p a = Hash.new{|hash, key| hash[key] = nil}       #=> {}
p a["apple"]                                      #=> nil
p a = Hash.new{|hash, key| hash[key] = "NONE"}    #=> {}
p a["apple"]                                      #=> "NONE"

# この初期値やブロックは、defaultメソッド、default_procメソッドで参照できる
# 初期値はあとでdefault=メソッドで指定することもできる

p a = Hash.new("NONE")                            #=> {}
p a.default                                       #=> "NONE"
p a["apple"]                                      #=> "NONE"
p a.default = "Not exists"                        #=> "Not exists"
p a["apple"]                                      #=> "Not exists"

=begin
  ハッシュのキーや値を取得する

  []
  keys
  values
  values_at
  fetch
  select
  find_all
=end

p a = {"apple" => "fruit", "coffee" => "drink"}     #=> {"apple"=>"fruit", "coffee"=>"drink"}
p a["apple"]                                        #=> "fruit"
a = {"apple" => "fruit", "coffee" => "drink"}
p a.keys                                            #=> ["apple", "coffee"]
p a.values                                          #=> ["fruit", "drink"]

# values_atは指定されたキーに対応する値を配列で返す
p a = {1 => "a", 2 => "b", 3 => "c", 4 => "d"}      #=> {1=>"a", 2=>"b", 3=>"c", 4=>"d"}
p a.values_at(1, 3)                                       #=> ["a", "c"]

# fetch与えられたキーに対する値を返す
# キーが存在しない場合には、2番目の引数が与えられていればその値を、
# ブロックが与えられていればそのブロックを評価した結果を返す
p a = {1 => "a", 2 => "b", 3 => "c", 4 => "d"}      #=> {1=>"a", 2=>"b", 3=>"c", 4=>"d"}
p a.fetch(5, "NONE")                                #=> "NONE"
p a.fetch(5) {|key| key % 2 == 0}                   #=> false

=begin
  selectはキーと値の組み合わせについてブロックを評価して、
  結果が真となる組み合わせのみを含むハッシュを返す
  find_allはselectと同じようにキーと値の組み合わせについてブロックを評価するが、
  返り値はハッシュではなくキーと値の配列になる

  * selectはハッシュで返す
  * find_allは配列で返す
=end

p a = {1 => "a", 2 => "b", 3 => "c", 4 => "d"}      #=> {1=>"a", 2=>"b", 3=>"c", 4=>"d"}
p a.select{|key, value| key % 2 == 0}               #=> {2=>"b", 4=>"d"}
p a.find_all{|key, value| key % 2 == 0}             #=> [[2, "b"], [4, "d"]]

=begin
  ハッシュを変更する

  []=
  delete
  reject
  reject!
  delete_if
  replace
  shift
  merge
  update
  invert
  clear
=end

# []=は指定されたキーに対応する値を変更する
# キーが存在しない場合は、そのキーと値を登録する
p a = {"apple" => "fruit", "coffee" => "drink"}
p a["apple"] = "red"                                #=> "red"
p a                                                 #=> {"apple"=>"red", "coffee"=>"drink"}
p a["orange"] = "orange"                            #=> "orange"
p a                                                 #=> {"apple"=>"red", "coffee"=>"drink", "orange"=>"orange"}

# deleteは指定されたキーに対応する値を取り除く
# キーが存在していれば対応する値を、そうでなければnilを返す
# ブロックが与えられた場合には、キーが存在しない場合にブロックの評価結果を返す
a = {"apple" => "fruit", "coffee" => "drink"}
p a.delete("apple")                                 #=> "fruit"
p a                                                 #=> {"coffee"=>"drink"}

# rejectはブロックを評価した結果が真になる値を取り除いたハッシュを生成して返す
# 元のオブジェクトは変更されない
a = {"apple" => "fruit", "coffee" => "drink"}
p a.reject {|key, value| value == "drink"}          #=> {"apple"=>"fruit"}
p a                                                 #=> {"apple"=>"fruit", "coffee"=>"drink"}

# delete_ifとreject!はブロックを評価した結果が真になる値を取り除く
# 元のオブジェクトも変更される(破壊的メソッド)
a = {"apple" => "fruit", "coffee" => "drink"}
p a.reject! {|key, value| value == "drink"}         #=> {"apple"=>"fruit"}
p a                                                 #=> {"apple"=>"fruit"}

a = {"apple" => "fruit", "coffee" => "drink"}
p a.delete_if {|key, value| value == "drink"}       #=> {"apple"=>"fruit"}
p a                                                 #=> {"apple"=>"fruit"}

# replaceは引数で与えられたハッシュで自身を置き換える(object_idが同じだということに注意)
p a = {"apple" => "fruit", "coffee" => "drink"}
p a.object_id                                       #=> 60
p a.replace({"orange" => "fruit", "tea" => "drink"})    #=>{"orange"=>"fruit", "tea"=>"drink"}
p a.object_id                                       #=> 60

# shiftはハッシュから先頭のキーと値の組み合わせを1つ取り除き、その組み合わせを配列として返す
p a = {"apple" => "fruit", "coffee" => "drink"}
p a.shift                                           #=> ["apple", "fruit"]
p a                                                 #=> {"coffee"=>"drink"}

=begin
  mergeは自身を引数で指定されたハッシュを統合した、新しいハッシュオブジェクトを返す
  デフォルト値は自身の設定が引き継がれる
  ブロックが与えられた場合には、キーと自身の値、指定されたハッシュの値が渡され、
  ブロックの評価結果が新しいハッシュの値となる
=end

p a = {"apple" => "foods", "coffee" => "drink"}
# 以下の出力：{"apple"=>"fruit", "coffee"=>"drink", "orange"=>"fruit", "tea"=>"drink"}
p a.merge({"orange" => "fruit", "tea" => "drink", "apple" => "fruit"})
p a       #=> {"apple"=>"foods", "coffee"=>"drink"}
# 以下の出力：{"apple"=>"foods", "coffee"=>"drink", "orange"=>"fruit", "tea"=>"drink"}
p a.merge({"orange" => "fruit", "tea" => "drink"}){|key, self_val, other_val| self_val}

# merge!とupdateは自身と引数で指定されたハッシュを統合する
# mergeとは異なり、元のオブジェクトが変更される(破壊的メソッド)
p a = {"apple" => "foods", "coffee" => "drink"}
# 以下の出力：{"apple"=>"fruit", "coffee"=>"drink", "orange"=>"fruit", "tea"=>"drink"}
p a.merge!({"orange" => "fruit", "tea" => "drink", "apple" => "fruit"})
p a       #=> {"apple"=>"fruit", "coffee"=>"drink", "orange"=>"fruit", "tea"=>"drink"}

# invertはキーと値を逆にしたハッシュを返す
# ただし、値が重複している場合は結果は不定となる
p a = {"apple" => "foods", "coffee" => "drink"}
p a.invert      #=> {"foods"=>"apple", "drink"=>"coffee"}
# 以下の出力：{"fruit"=>"apple", "drink"=>"tea"}
p a = {"orange" => "fruit", "coffee" => "drink", "apple" => "fruit", "tea" => "drink"}.invert

# clearはハッシュを空にする(破壊的メソッド)
p a = {"apple" => "foods", "coffee" => "drink"}
p a.clear     #=> {}

=begin
  ハッシュを調べる

  length
  size
  empty?
  has_key?
  include?
  key?
  member?
  has_value?
  value?
=end

# lengthとsizeはハッシュの組み合わせの数を返す
# ハッシュが空であるかどうかを調べるにはempty?を使う
p a = {"apple" => "foods", "coffee" => "drink"}
p a.size       #=> 2
p a.empty?     #=> false

# has_key?, include?, key?, member?はハッシュにキーが存在する場合に真を返す
a = {"apple" => "fruit", "coffee" => "drink"}
p a.key?("apple")       #=> true
p a.key?("orange")      #=> false

# has_value?, value?はハッシュに値が存在する場合に真を返す
a = {"apple" => "fruit", "coffee" => "drink"}
p a.value?("fruit")     #=> true
p a.key?("foods")       #=> false

=begin
  ハッシュを使った繰り返し

  each
  each_pair
  each_key
  each_value
=end

# each, each_pairは与えられたブロックにキーと値を渡して評価する
a = {"apple" => "fruit", "coffee" => "drink"}
=begin
  以下の出力

  apple => fruit
  coffee => drink
  {"apple"=>"fruit", "coffee"=>"drink"}
=end
p a.each{|key, value| puts "#{key} => #{value}"}

