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

