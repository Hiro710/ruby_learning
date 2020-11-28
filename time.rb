# Timeクラス

=begin
  Timeオブジェクトの生成

  Time.new
  Time.now
  Time.at
  Time.mktime
  Time.local
  Time.gm
=end

# Time.newとTime.nowは現在時刻のTimeオブジェクトを生成して返す
# タイムゾーンはローカルタイムとなる、日本であれば+0900と表記される
p Time.now      #=> (現在の年月日、時分秒まで出力される)

# Time.atは引数で指定した起算時からの秒数に対応するTimeオブジェクトを生成して返す
# さらに精度が必要な場合は、2番目の引数にマイクロ秒を指定する
p Time.at(1234567890)                   #=> 2009-02-14 08:31:30 +0900
p Time.at(1234567890, 1234567890)       #=> 2009-02-14 08:52:04.56789 +0900

=begin
  Time.mktimeとTime.localは、与えられた引数に対応するTimeオブジェクトを生成して返す
  また、引数の数に応じて引数の意味が変わるメソッドでもあるため、その順序と数には要注意
  引数が7個までの場合には、引数の先頭から、年月日時分秒マイクロ秒を指定できる
  年のみ省略できず、他の引数を省略した場合はそれぞれ1, 1, 0, 0, 0, 0が指定したと見なされる
  月に関しては"Jan"や"Feb"などの英語の月名の省略形も指定できる
=end

p Time.mktime(2017)                     #=> 2017-01-01 00:00:00 +0900
p Time.local(2017, 7, 7)                #=> 2017-07-07 00:00:00 +0900

=begin
  引数が10個の場合は、引数の先頭から、秒、分、時、日、月、年、曜日に対応する数値、年日、夏時間かどうかの真理値、
  タイムゾーンを指定できる
  ただし曜日に対応する数値、年日、夏時間かどうかの真理値、タイムゾーンに関しては無視される
  この順はTimeオブジェクトのto_aの結果と同じ順序になっている
=end

p Time.mktime(0, 0, 0, 7, 7, 2017, 4, 188, false, "JST")      #=> 2017-07-07 00:00:00 +0900

# Time.gmとTime.utcは引数の数やその順序はTime.mktimeメソッドと同じだが、
# 生成されるTimeオブジェクトのタイムゾーンがUTCになるという違いがある
p Time.gm(2017)             #=> 2017-01-01 00:00:00 UTC
p Time.gm(2017, 7, 7)       #=> 2017-07-07 00:00:00 UTC
p Time.utc(2017)            #=> 2017-01-01 00:00:00 UTC
p Time.utc(2017, 7, 7)      #=> 2017-07-07 00:00:00 UTC

=begin
  Timeオブジェクトの属性を取得する

  year
  mon / month
  day / mday
  hour
  min
  sec
  usec  / tv_usec
  wday
  yday
  zone
  isdst / dst?
  gmt? / utc?
  gmt_offset / gmtoff
=end

p t = Time.mktime(2017, 1, 2, 3, 4, 5, 6)     #=> 2017-01-02 03:04:05.000006 +0900
p t.year                                      #=> 2017
p t.mday                                      #=> 2
p t.sec                                       #=> 5
p t.usec                                      #=> 6

# wdayは曜日に対応する数値を返す
# 日曜から土曜に対して、0 ~ 6が対応している
# ydayは1月1日からの日数を返す
t = Time.mktime(2017, 1, 2, 3, 4, 5, 6)
p t.wday                                      #=> 1
p t.yday                                      #=> 2

# isdstとdst?は夏時間かどうか、gmt?とutc?はタイムゾーンがUTCかどうかを返すメソッド
t = Time.mktime(2017, 1, 2, 3, 4, 5, 6)
p t.dst?                                      #=> false
p t.gmt?                                      #=> false

# gmtoffとgmt_offsetはUTC時刻との差を秒単位の数値として返す
p t = Time.mktime(2017, 1, 2, 3, 4, 5, 6)
p t.gmtoff                                    #=> 32400
p t.gmtoff / 3600                             #=> 9
p t.gmt_offset                                #=> 32400
p t.gmt_offset / 3600                         #=> 9

=begin
  タイムゾーンを変更する

  localtime
  gmtime / utc
  getlocal
  getgm / getutc
=end

# localtimeはタイムゾーンをローカルタイムに、gmtimeとutcはUTCに変更する
p t = Time.mktime(2017, 1, 2, 3, 4, 5, 6)     #=> 2017-01-02 03:04:05.000006 +0900
p t.localtime                                 #=> 2017-01-02 03:04:05.000006 +0900
p t.gmtime                                    #=> 2017-01-01 18:04:05.000006 UTC

# getlocalはタイムゾーンをローカルタイムに変更した新しいTimeオブジェクトを、getgmとgetutcはUTC
# に変更した新しいTimeオブジェクトを返す
p t = Time.mktime(2017, 1, 2, 3, 4, 5, 6)     #=> 2017-01-02 03:04:05.000006 +0900
p t.object_id                                 #=> 60
p t1 = t.getlocal                             #=> 2017-01-02 03:04:05.000006 +0900
p t1.object_id                                #=> 80
p t.eql?(t1)                                  #=> true  (内容が一致)
p t.equal?(t1)                                #=> false (object_idが違う為)

=begin
  Timeオブジェクトの演算

  Timeオブジェクトは「+」メソッドで指定した秒数後のTimeオブジェクトを、
  「-」メソッドで指定した秒数前のTimeオブジェクトを返す
=end
t = Time.mktime(2017, 1, 2, 3, 4, 5, 6)
p t + 60 * 60 * 3                             #=> 2017-01-02 06:04:05.000006 +0900
p t - 60 * 60 * 3                             #=> 2017-01-02 00:04:05.000006 +0900

# Timeオブジェクト同士の差を求める事ができ、結果はFloatオブジェクトで返る
t1 = Time.mktime(2017, 1, 2, 3, 4, 5, 6)
t2 = Time.mktime(2017, 2, 3, 4, 5, 6, 7)
p t2 - t1                                     #=> 2768461.000001
