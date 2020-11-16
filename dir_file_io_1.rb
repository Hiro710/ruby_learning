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



