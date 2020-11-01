=begin
  文字列に対する繰り返し

  each_line
  lines
  each_byte
  bytes
  each_char
  chars
  upto

  each_line, linesは文字列の各行に対して繰り返す
  オプションとして行の区切りを指定できる
  each_byte, bytesは文字列をバイト単位で繰り返す
  each_char, charsは文字単位で繰り返す
  uptoは自分自身から指定された文字列まで、succメソッドで生成される次の文字列を使って繰り返す
=end

p "abc\ndef\nghi".each_line { |c| puts c }
=begin
  #=> abc
      def
      ghi
      "abc\ndef\nghi"
=end
p "abc".each_byte { |c| puts c }
=begin
  #=> 97
      98
      99
      "abc"
=end
puts "ルビー".each_char { |c| puts c }
=begin
  #=> ル
      ビ
      ー
      "ルビー"
=end
p "a".upto("c") { |c| puts c }
=begin
  #=> a
      b
      c
      "a"
=end

=begin
  他のクラスへの変換

  hex
  oct
  to_f
  to_i
  to_s
  to_str
  to_sym
  intern
=end

# hexは文字列が16進数であるとして数値に変換
# 接頭辞0x,0Xとアンダースコアは無視され、16進数以外の文字がある場合にはそれ以降も無視される
p "abc".hex     #=> 2748
p "azc".hex     #=> 10
p "0xazc".hex   #=> 10

# octは文字列を8進数であるとして数値に変換
# hexとは異なり、接頭辞に応じて8進数以外の変換も行う
p "010".oct     #=> 8
p "0b010".oct   #=> 2
p "0x010".oct   #=> 16

# to_iは文字列を10進数の整数であるとして数値に変換
# 整数と見なせない文字があれば、そこまでを変換して以降を無視する
# 空文字であれば0を返す
p "123".to_i    #=> 123
p "0123".to_i   #=> 123
p "0x123".to_i  #=> 0
p "".to_i       #=> 0

# to_fは文字列を10進数の小数であるとしてFloatオブジェクトに変換
# 小数と見なせない文字があれば、そこまでを変換して以降を無視する
# 空文字であれば0.0を返す
p "1.23".to_f   #=> 1.23
p "01.23".to_f  #=> 1.23
p "0x1.23".to_f #=> 0.0
p "".to_f       #=> 0.0

# to_s, to_strは自分自身を返す

# to_sym, internは文字列に対応するシンボル値を返す
p a = "abc".to_sym    #=> :abc
p a.object_id         #=> 1020188
p b = :abc            #=> :abc
p b.object_id         #=> 1020188