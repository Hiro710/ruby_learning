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

