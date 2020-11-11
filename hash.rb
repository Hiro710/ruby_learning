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


