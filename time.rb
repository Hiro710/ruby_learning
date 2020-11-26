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
