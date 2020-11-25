=begin
  IOクラス

  Fileクラスのスーパークラスでもあり、基本的な入出力機能を備えたクラス
  多くのメソッドはFileクラスでも利用できる
  標準出力(STDOUT)や標準入力(STDIN)、標準エラー出力(STDERR)もこのIOクラスのオブジェクト
=end

=begin
  IOを開く

  ファイルを開くにはKernelモジュールのopenを使う
  ファイル名とファイルを開く時のモードを指定してopenを実行するとFileオブジェクトが返る
  IO.openでも同様にファイルを開くことができる
=end

# ファイルを開く
# p io = open('README.txt')                             #=> #<File:README.txt>

# エンコーディングを指定してファイルを開く
# 例として外部エンコーディングとしてShift_JISを内部エンコーディングとしてEUC-JPを指定した場合は以下になる
# p io = open('README.txt', 'w+:shift_jis:euc-jp')      #=> #<File:README.txt>

# openでファイルの代わりに「|」に続いてコマンドを指定すると、コマンドの出力結果を得ることができる
# この場合は先程とは異なり、IOオブジェクトが返る
p io = open('| ls -la')                               #=> #<IO:fd 9>

# 開いたファイルの内容を読み込むにはreadを使う
# この時エンコーディングが指定されていないと、
# 入力エンコーディングはEncoding.default_externalで指定されているものになる
p io = open('| ls -la /Users/user/Desktop/ruby_learning')   #=> #<IO:fd 10>
=begin
  以下コードの出力

  total 232
  drwxr-xr-x  26 user  staff    832 Nov 21 10:26 .
  drwx------+ 67 user  staff   2144 Nov 21 10:13 ..
  --(省略)--
  => nil
=end
puts io.read
p io.read.encoding        #=> #<Encoding:US-ASCII>

# 開いたファイルに書き込むには、writeを使う
# 標準出力に書き込む
p STDOUT.write('There is new technology.')    #=> There is new technology.24

# ファイルを閉じるにはcloseを使う
# ファイルを開くopenでブロックに渡している場合は、ブロック終了時に自動的にファイルが閉じられる
p open('README.txt') {|io| puts io.read}      #=> nil

# IO.popenを使うと、コマンドをサブプロセスとして実行し、そのプロセスと入出力のパイプを開くことができる
# close_writeはIOオブジェクトの書き込み用のIOを閉じるメソッド
# 読み込み用のIOを閉じるには、close_readを使う
p IO.popen('grep -i ruby', 'r+') do |io|
    io.write('This is Ruby program')
    io.close_write
    puts io.read
  end                                       #=> This is Ruby program   => nil

=begin
  IOからの入力

  以下のメソッドのうち、readで長さを指定した場合のみバイナリ読み込みとなるため、エンコーディングがASCII-8BITとなる
  それ以外は原則として、IOオブジェクトに内部エンコーディングが指定されている場合は
  外部エンコーディングから内部エンコーディングへ変換が行われ、
  内部エンコーディングの指定がない場合は外部エンコーディングで指定されたエンコーディングとなる

  IO.read / read
  IO.foreach / each / each_lines
  readlines
  readline / gets
  each_byte
  getbyte / readbyte
  each_char
  getc / readchar
=end

# IO.readとIOオブジェクトのreadは、ともにIOから内容を読み込む
# 長さが指定されていれば、その長さだけ読み込む
p IO.read('README.txt')                   #=> "Hi, I am Ruby program.\nCould you friend me?"
p IO.read('README.txt').encoding          #=> #<Encoding:US-ASCII>
p IO.read('README.txt', 5)                #=> "Hi, I"
p IO.read('README.txt', 5).encoding       #=> #<Encoding:ASCII-8BIT>

# IO.foreachは指定されたファイルを開き、各行をブロックに渡して実行していく
# IOクラスのインスタンスであるIOオブジェクトでは、each, each_linesで同様に
# 各行をブロックに渡して実行できる
# IO.foreach("INSTALL") {|line| puts line}    #=> This is INSTALL file ...(省略)

# readlinesはファイルを全て読み込んで、その各行の配列を返す
# p open("INSTALL").readlines                 #=> ["This is INSTALL file\n", "INSTALLATION PROCESS:\n",...(省略)]

# IOオブジェクトから1行読み込むには、getsやreadlineを使う
# p io = open("INSTALL")          #=> #<File:INSTALL>
# p io.gets                       #=> "This is INSTALL file\n"
# p io.gets                       #=> "INSTALLATION PROCESS:\n"

# each_byteは与えられたブロックにIOオブジェクトから1バイトずつ整数として読み込んで渡していく
# p io = open("INSTALL")          #=> #<File:INSTALL>
# p io.each_byte{|i| puts i}      #=> 84 104 105...(省略)

# IOオブジェクトから1バイト読み込んで整数として返すには、getbyte, readbyteを使う
# p io = open("INSTALL")          #=> #<File:README.txt>
# p io.getbyte                    #=> 84  # "H"
# p io.getbyte                    #=> 104  # "i"

# each_charは与えられたブロックにIOオブジェクトから1文字ずつ読み込んで渡していく
p io = open("README.txt")         #=> #<File:README.txt>
p io.each_char{|c| puts c}        #=> H i ,...(省略)

# IOオブジェクトから1文字読み込むには、getc, readcharを使う
# これらはその文字に対応する文字列を返す
p io = open("README.txt")         #=> #<File:README.txt>
p io.getc                         #=> "H"
p io.getc                         #=> "i"

=begin
  IOへの出力

  write
  puts
  print
  printf
  putc
  <<
  flush
=end

# writeはIOに対して引数の文字列を出力する
# 引数が文字列以外の場合は、to_sで文字列化して出力する
# 出力が成功すると、出力した文字列のバイト数を返す
p STDOUT.write('There is new technology.')    #=> There is new technology.24

# putsはIOに対して複数のオブジェクトを出力する
# 引数が文字列や配列でない場合、to_aryにより配列化し、次に各要素をto_sで文字列化して出力する
=begin
  以下の出力：
  Abcdefg
  Hijklmn
  nil
=end
p STDOUT.puts('Abcdefg', 'Hijklmn')

=begin
  printはputs同様IOに対して複数のオブジェクトを出力する
  putsとは異なり、複数のオブジェクトが指定されると各オブジェクト間に「$,」の値を出力する
  「$\」に値が設定されていれば最後に出力する
  また引数が文字列でない場合、to_sで文字列化して出力する

  printfはC言語のprintf同様に、指定されたフォーマットに従って引数の値を出力する
=end

=begin
  以下の出力：
  This is first line.
  This is second line.  nil
=end
# $, = "\n"
# p STDOUT.print('This is first line.', 'This is second line.')

# p STDOUT.printf('%010d', 123456)    #=> 0000123456 nil

=begin
  putcはIOに引数の文字を出力する
  引数が整数の場合はその最下位バイトを文字コードとする文字を、
  文字列の場合には先頭の1文字を出力する
  どちらでもない場合はto_intで整数化して出力する
=end

p STDOUT.putc('a')          #=> a => "a"
p STDOUT.putc(0x3042)       #=> B => 12354

# <<はIOオブジェクトに指定されたオブジェクトを出力する
# 返り値がIOオブジェクト自身となるため、メソッドチェーンが使える
p STDOUT << "This" << " " << "is" << " " << "Ruby" << "."   #=> This is Ruby. #<IO:<STDOUT>>

=begin
  IOの内部バッファをフラッシュして出力するにはflushを使う
  RubyではIOへの出力は一旦内部バッファに蓄積される為、writeやputsを実行しても
  すぐにはファイルに書き込まれない
=end

# 内部バッファをフラッシュする
# p io = open('README.txt', 'w+')         #=> #<File:README.txt>
# p io.write('This is new README')        #=> 18
# p 'cat README.txt'                      #=> ""
# p io.flush                              #=> #<File:README.txt>
# p 'cat README.txt'                      #=> "This is new README"

=begin
  IOオブジェクトの状態を調べる

  stat
  closed?
  eof / eof?
  lineno
  sync

  statはIOオブジェクトの状態を表すFile::Statオブジェクトを返す
=end

p io.stat   #=> #<File::Stat dev=0x1000004, ino=19447301, mode=0100644, nlink=1, uid=502, gid=20, rdev=0x0, size=18, blksize=4096, blocks=8, atime=2020-11-25 09:54:54.922511186 +0900, mtime=2020-11-25 09:48:04.907513985 +0900, ctime=2020-11-25 09:48:04.907513985 +0900, birthtime=2020-11-18 09:19:52.838492507 +0900>

# IOオブジェクトが閉じられたかどうかを調べるには、closed?を使う
# ファイルの終端に到達したかどうかを調べるにはeof?を使う
p io = open('README.txt', 'r+')       #=> #<File:README.txt>
p io.read                             #=> "This is new README"
p io.eof?                             #=> true
p io.close                            #=> nil
p io.closed?                          #=> true

# 現在の行番号(Rubyではgetsが呼び出された回数)を調べるには、linenoを使う
# この行番号はlineno=で設定することもできる
p io = open('README.txt')       #=> #<File:README.txt>
p io.read                       #=> "Hi, I am Ruby.\nWhat's the question?"
p io.rewind                     #=> 0
p io.gets                       #=> "Hi, I am Ruby.\n"
p io.lineno                     #=> 1
p io.lineno = 10                #=> 10
p io.gets                       #=> "What's the question?"
p io.lineno                     #=> 11

# 出力する際のバッファモードを調べるにはsyncを使う
# 返り値がtrueの場合には、出力の実行毎にバッファがフラッシュされる
p io = open('README.txt')       #=> #<File:README.txt>
p io.sync                       #=> false
