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
p a.chomp