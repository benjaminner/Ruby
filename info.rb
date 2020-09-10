require 'net/http'
uri = URI('https://www.airnow.gov/?city=San%20Carlos&state=CA&country=USA')
site = Net::HTTP.get_response(uri)
puts site.body