=begin
# httpの場合

require "net/http"
require "uri"

url = URI.parse("http://29g.net/")
http = Net::HTTP.start(url.host, url.port)
doc  = http.get(url.path)
puts doc.ruby

=end

# httpsの場合

require 'net/https'

https = Net::HTTP.new('www.example.com', 443)
url = URI.parse('www.example.com')

https.use_ssl = true
#https.ca_file = '/usr/share/ssl/cert.pem'
https.verify_mode = OpenSSL::SSL::VERIFY_PEER
https.verify_depth = 5
https.start {
  response = https.get('/')
  puts response.body
}

p url.scheme # スキーム：URLの種類
p url.host # ホスト名
p url.port # ポート番号
p url.path # パス
p url.to_s # 'www.example.com'
