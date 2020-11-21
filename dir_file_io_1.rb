=begin
  Dirクラスはディレクトリの移動や作成、ディレクトリ内のファイル一覧取得など、
  ディレクトリを扱うクラス
  Fileクラスはファイルの読み取りや書き込み、新規作成や削除など、ファイルを扱うクラス
  IOクラスはFileクラスのスーパークラスで、ファイルやプロセスなどとの入出力を扱うクラス
=end

# Dirクラス
# Dirクラスでディレクトリを開くには、Dir.openを使う
# このメソッドの返り値はDirクラスのオブジェクトで、例えばeachでファイル一覧を取得できる
# 開いたディレクトリを閉じるには、closeを使う

p dir = Dir.open("/Users/user")     #=> #<Dir:/Users/user>
=begin
  以下の出力：
  .
  ..
  .vscode-cpptools
  .eclipse
  .irb_history
  .config
  .......(省略)
=end
p dir.each {|file| puts file}
p dir.close                         #=> nil

# Dir.openはブロックを取ることができ、この場合にはブロックを出るときに自動で閉じられる
# 開いているディレクトリのパスはpathで取得できる
p dir = Dir.open("/Users/user"){|dir| puts dir.path}    #=> /Users/user    nil

=begin
  カレントディレクトリの取得やディレクトリの移動、新規作成、削除には以下を使う
  Dir.pwd / Dir.getwd
  Dir.chdir
  Dir.mkdir
  Dir.rmdir / Dir.unlink / Dir.delete
=end

# Dir.pwdとDir.getwdは、カレントディレクトリを取得
p Dir.pwd           #=> "/Users/user/Desktop/ruby_learning"
p Dir.getwd         #=> "/Users/user/Desktop/ruby_learning"

=begin
  Dir.chdirはカレントディレクトリを指定されたディレクトリに変更する
  指定がない場合、環境変数HOMEやLOGDIRが設定されていれば、そのディレクトリに移動する
  ブロックが与えられた場合には、そのブロック内でのみディレクトリを移動し、
  ブロックを出るときに元に戻る
  ディレクトリの移動に成功すれば0を返す
=end

p Dir.chdir("/Users/user")      #=> 0
p Dir.pwd                       #=> "/Users/user"
p Dir.chdir("/Users/user/node_modules"){|dir| puts Dir.pwd}   #=> /Users/user/node_modules
p Dir.pwd                       #=> "/Users/user"

=begin
  Dir.mkdirは指定したパスのディレクトリを作成する
  2つ目の引数にパーミッション(mode)を指定することもできる
  通常、パーミッションは3桁の8進数で指す
  実際のパーミッションは、指定された値とumaskをかけた値(mode & ~umask)となる
=end

# p Dir.mkdir("/Users/user/Desktop/foo")          #=> 0
# p Dir.mkdir("/Users/user/Desktop/bar", 0755)    #=> 0

# ディレクトリ削除には、Dir.rmdirを使う
p Dir.mkdir("/Users/user/Desktop/foo")            #=> 0  ディレクトリ作成
p Dir.rmdir("/Users/user/Desktop/foo")            #=> 0  ディレクトリ削除

# Fileクラス
=begin
  ファイルを開くには、File.openまたはFile.newを使う
  引数としてファイル名だけを与えると、読み取りモードで開く
  ファイルが存在しない場合はエラーが発生する
  ファイルを開くとファイルオブジェクトが返る
  このファイルオブジェクトのreadで、ファイルの内容を取得できる
  closeを実行すると、ファイルを閉じることができる
=end

p file = File.open('/Users/user/Desktop/ruby_learning/README.txt')    #=> #<File:/Users/user/Desktop/ruby_learning/README.txt>
p file.read               #=> "Hi, I am Ruby !!"
p file.close              #=> nil

# ファイルの入出力時にはエンコーディングが有効になる
p Encoding.default_external = 'UTF-8'   #=> デフォルトエンコーディングをUTF-8に設定
p file = File.open('/Users/user/Desktop/ruby_learning/README.txt')    #=> #<File:/Users/user/Desktop/ruby_learning/README.txt>
p file.read               #=> "Hi, I am Ruby !!"
p file.read.encoding      #=> #<Encoding:UTF-8>

# File.openにブロックを与えると、ブロック終了時に自動的にファイルを閉じることができる
# ファイルの閉じ忘れを防ぐ為にも、通常はこちらを使用するよう推奨されている
# 以下の出力："Hi, I am Ruby !!"
p file = File.open('/Users/user/Desktop/ruby_learning/README.txt'){|file| file.read}

# ファイルの内容を読み込むには、他にもgetsやreadlinesなどがある

=begin
  ファイルのモード

  File.openの2番目の引数にファイルを開くモードを指定できる
  ファイルに書き込む場合や追記する場合には、以下のモードを指定して開く

  "r"    読み込みモード
  "w"    書き込みモード。既存ファイルの場合はファイルの内容を空にする
  "a"    追記モード。常にファイルの末尾に追加される
  "r+"   読み書きモード。ファイルの読み書き位置が先頭になる
  "w+"   読み書きモード。"r+"と同じだが、既存ファイルの場合はファイルの内容が空になる
  "a+"   読み書きモード。ファイルの読み込み位置は先頭に、書き込み位置は常に末尾になる

  また、モードの後ろにファイルのエンコーディング(外部エンコーディング)と
  読み込んだ時のエンコーディング(内部エンコーディング)を指定できる
  例えばShift_JISのファイルを読み込む時、以下のように指定すると内部エンコーディングをUTF-8に
  することができる
=end

# p f = File.open('shift_jis.txt', 'r:shift_jis:utf-8')   #=> #<File:shift_jis.txt>
# p f.read      #=> "ルビー"  UTF-8に変換されている

=begin
  書き込む時も同様に指定できる
  例えばファイルのエンコーディングをShift_JISに、書き込む内容のエンコーディング(内部エンコーディング)を
  EUC-JPにする場合は以下のようになる
=end

# f = File.open('shift_jis.txt', 'w+:shift_jis:euc-jp')   #=> #<File:shift_jis.txt>
# p f.write 'ルビー'.encode('euc-jp')     #=> 6    EUC-JPにエンコーディング変換
# p f.rewind                             #=> 0
# p f.read(4)                            #=> "\x83\x8B\x83r"     Shift_JISに変換されている


# ファイルに書き込む
# ファイルに文字列を書き込むにはwriteを使う
# p file.open('new-file', "w"){|file| file.write "This is new file."}   #=> 17

=begin
  ファイルの属性を取得する

  File.basename 指定されたパスからファイル名を取得
  File.dirname  指定されたパスからディレクトリ名を取得
  File.extname  指定されたパスから拡張子を取得
  File.split    指定されたパスからディレクトリ名とファイル名の配列を取得
  File.stat / File.lstat  ファイルの属性を示すFile::Statクラスのオブジェクトを返す
  File.atime / File.ctime / File.mtime  それぞれファイルの最終アクセス時刻、状態が変更された時刻、
                                        最終更新時刻を取得する

  ファイルの属性はファイルオブジェクトのメソッドでも取得できる

  path                                  ファイルを開く時に使用したパスを返す
  File.lstat                            ファイルの属性を示すFile::Statクラスのオブジェクトを返す
  File.atime / File.ctime / File.mtime  それぞれファイルの最終アクセス時刻、状態が変更された時刻、
                                        最終更新時刻を取得する
=end

# ファイルの最終更新時刻を取得する
p File.mtime('/Users/user/Desktop/ruby_learning/README.txt')                    #=> 2020-11-18 09:20:18 +0900
p File.open('/Users/user/Desktop/ruby_learning/README.txt'){|file| file.mtime}  #=> 2020-11-18 09:20:18 +0900

=begin
  ファイルをテストする(FileTestモジュール)

  File.exist?                                         指定されたパスが存在しているか調べる
  File.file? / File.directory? / File.symlink?        それぞれ指定されたパスがファイルか、ディレクトリか、
                                                      シンボリックリンクかを調べる
  File.executable? / File.readable? / File.writable?  それぞれ指定されたファイルが実行可能か、
                                                      読み取り可能か、書き込み可能かを調べる
  File.size                                           指定されたファイルのサイズを調べる
=end

# パスがディレクトリか調べる
p File.directory?('/Users/user/Desktop/ruby_learning')              #=> true
p File.directory?('/Users/user/Desktop/ruby_learning/README.txt')   #=> false

=begin
  ファイルの属性を設定する

  ファイルの属性を変更するにはFile.chmodを、ファイルの所有者を変更するにはFile.chownを使う
  これらはUnixコマンドに対応している
  また、ファイルオブジェクトのchmodやchownでも変更できる
=end

# p File.chmod(0644, '/Users/user/Desktop/ruby_learning/README.txt')        #=> 1
# p File.chown(501, 20, '/Users/user/Desktop/ruby_learning/README.txt')     #=> 1

# ファイルの最終アクセス時刻や更新時刻は、File.utimeで設定する
# p File.utime(Time.now, Time.now, '/Users/user/Desktop/ruby_learning/README.txt')    #=> 1

# ファイルのパスを絶対パスに展開する
# 指定されたパスを絶対パスに展開するにはFile.expand_pathを使う
# p File.expand_path('/Users/user/Desktop/ruby_learning/README.txt')

=begin
  ファイルを削除、リネームする

  delete / unlink
  truncate
  rename
=end

# deleteは指定したファイルを削除する
# 削除に失敗するとエラーが発生する
# p File.delete('/Users/user/Desktop/ruby_learning/README.txt')   #=> 1

# truncateはファイルを指定したバイト数に切り詰める
# ファイルオブジェクトにも同様のtruncateメソッドがある
# p File.truncate('/Users/user/Desktop/ruby_learning/README.txt', 0)                          #=> 0
# p File.open('/Users/user/Desktop/ruby_learning/README.txt', "w") {|file| file.truncate(0)}  #=> 0

# renameは、1つ目の引数で指定したファイル名を、2つ目の引数で指定したファイル名に変更する
# リネーム先のファイルが存在する場合はファイルを上書きする
# p File.rename('/Users/user/Desktop/ruby_learning/README.txt', '/Users/user/Desktop/ruby_learning/README_1.txt')  #=> 0

# ファイルをロックする
# ファイルをロックするにはflockを使う
# 引数にはロック方法を指定。ただし、システムに依存するので場合によってはエラーが発生する
# p File.open('/Users/user/Desktop/ruby_learning/README.txt', "w") {|file| file.flock(File::LOCK_EX)}   #=> 0
