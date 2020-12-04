=begin
  Regexpクラスは正規表現オブジェクトを扱うクラス
  Rubyでは正規表現リテラルを使って表現できる
  リテラルの末尾にはオプションが指定でき、例えば、大文字小文字を無視するには「i」を、
  正規表現の「.」で改行にマッチさせるには「m」を、空白や#から始まるコメントを無視するには
  「x」を指定する
  オプションは複数指定する事ができる
=end

# 正規表現オブジェクトを生成する
p a = /abcdefg/i  # 大文字小文字の違いを無視する     #=> /abcdefg/i
p a.class                                       #=> Regexp

p a = Regexp.new("abcdefg", Regexp::MULTILINE | Regexp::IGNORECASE)   #=> /abcdefg/mi

=begin
  正規表現オブジェクトでマッチングする

  正規表現オブジェクトで文字列とマッチングするには、matchメソッドを使う
  マッチした場合にはMatchDataオブジェクトを、マッチしなかった場合にはnilを返す
=end

p a = Regexp.new("abc")       #=> /abc/
p a.match("abcdefg")          #=> #<MatchData "abc">

# =~でもマッチングすることができ、マッチすればマッチした位置のインデックスが、マッチしなかった場合にはnilが返る
# =~はStringクラスのオブジェクトである文字列にもあり、同様の動作をする
p a = Regexp.new("abc")       #=> /abc/
p a =~ "abcdefg"              #=> 0
p "abcdefg" =~ a              #=> 0
p a =~ "xyz"                  #=> nil

# ===でもマッチングする事ができる、マッチすればtrue、しなければfalseが返る
p a = Regexp.new("abc")       #=> /abc/
p a === "abcdefg"             #=> true

# 「~」は特殊変数「$_」とマッチングするメソッド
p $_ = "abcdefg"              #=> "abcdefg"
p a = Regexp.new("abc")       #=> /abc/
p ~a                          #=> 0

# 正規表現では、「.」や[]などでマッチングする場合、これらをエスケープする必要がある
# このエスケープを自動で行うのが、Regexp.escapeやRegexp.quote
# 正規表現の特殊文字をエスケープする
p Regexp.escape("array.push(hash[key])")      #=> "array\\.push\\(hash\\[key\\]\\)"

=begin
  マッチした結果は、Regexp.last_matchで取得できる
  Regexp.last_matchは、現在のスコープ(トップレベルやクラス・モジュール・メソッド定義)の中で
  最後に行ったマッチ結果である、MatchDataオブジェクトを返す
  この結果は特殊変数「$~」でも取得できる
=end

p /abcdefg/ =~ "abcdefghijklmnopqrstuvwxyz"    #=> 0
p Regexp.last_match                            #=> #<MatchData "abcdefg">
p $~                                           #=> #<MatchData "abcdefg">

# 0であれば正規表現にマッチした文字列が、それ以降の整数ではカッコにマッチした部分文字列を得られる
# これらの文字列はそれぞれ特殊変数$&と$1、$2などでも取得できる
p /(abc)d(efg)/ =~ "abcdefghijklmnopqrstuvwxyz"   #=> 0
p Regexp.last_match(0)                            #=> "abcdefg"
p $&                                              #=> "abcdefg"
p Regexp.last_match(1)                            #=> "abc"
p Regexp.last_match(2)                            #=> "efg"
p $1                                              #=> "abc"
p $2                                              #=> "efg"
p $4                                              #=> nil

# 正規表現の論理和を求める
# 複数の正規表現を結合し、そのどれかにマッチするような新しい正規表現を求めるには、Regexp.unionを使う
p a = Regexp.new("abc")                           #=> /abc/
p b = Regexp.new("ABC")                           #=> /ABC/
p c = Regexp.union(a, b)                          #=> /(?-mix:abc)|(?-mix:ABC)/
p c =~ "abc"                                      #=> 0
p Regexp.last_match                               #=> #<MatchData "abc">

