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


