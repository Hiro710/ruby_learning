=begin
  文字列の先頭や末尾にある空白や改行を削除する
  
  chompは末尾から引数で指定する改行コードを取り除いた文字列を返す
  指定がなければ、"\r"、"\r\n"
  chomp, chomp!
  strip, strip!
  lstrip, lstrip!
  rstrip, rstrip!
  chop, chop!
=end

a = "abcdef\n"
p a.chomp         #=> "abcdef"
p a.strip         #=> "abcdef"
p a.lstrip        #=> "abcdef\n"
p a.rstrip        #=> "abcdef"
p a.chop          #=> "abcdef"
p a.chop.chop     #=> "abcde"
p a.chomp.chomp   #=> "abcdef"

# 文字列を逆順にする
a = "abcdef"
p a.reverse       #=> "fedcba"

=begin
  文字列の長さ
  length, size, count, empty?, bytesize
  length, size 共に文字数を、
  count 指定されたパターンに該当する文字がいくつあるのかを、
  empty? 文字列が空かどうかを返す
  bytesize バイト数が返る
=end

a = "abcdef"
p a.length        #=> 6
p a.count('a-c')  #=> 3
p a.empty?        #=> false
p "".empty?       #=> true

a = "るびー"
p a.length        #=> 3
p a.bytesize      #=> 9

# 文字列の割り付け(center, ljust, rjust)
# メソッドを呼び出す際に、返す文字列の長さと、割り付ける余白に使用する文字を指定できる
a = "abc"
p a.center(20)        #=> "        abc         "
p a.center(20, "*")   #=> "********abc*********"
p a.ljust(20)         #=> "abc                 "
p a.rjust(20, "=")    #=> "=================abc"

# 非表示文字列を変換する
# dumpメソッドは、文字列中にある改行コードやタブ文字などの非表示文字列を、
# バックスラッシュ記法に置き換えた文字列を返す
a = "abc\tdef\tghi\n"
puts a        #=> abc	def	ghi
puts a.dump   #=> "abc\tdef\tghi\n"