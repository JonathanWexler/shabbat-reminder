    require 'net/http'
    require 'sun_times'

    class UsersController < ApplicationController
      def edit
        code = params[:code]
        puts "TESTING HERE: #{params[:code]}"

        uri = URI.parse("https://api.pushbullet.com/oauth2/token")
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.path)

        # I'm unsure if symbols will work
        stuff = {
          "grant_type" => 'authorization_code',
          "client_id" => ENV["PUSH_BULLET_CLIENT_ID"],
          "client_secret" => ENV["PUSH_BULLET_CLIENT_SECRET"],
          "code"  => code
      }
      req.set_form_data(stuff)
      res = https.request(req)

      ap d = res.body
      ap c = JSON.parse(d)
      ap c['access_token']
      current_user.pb_access_token = c['access_token']
      current_user.save
      sun_times = SunTimes.new
      @time = sun_times.set(Date.new(2016, 3, 21), 39.9500, 75.1667)

# url = URI.parse("https://api.pushbullet.com/oauth2/token")
# req = Net::HTTP::Get.new(url.path)
# req.add_field("grant_type", "authorization_code")
# req.add_field("client_id", ENV["PUSH_BULLET_CLIENT_ID"])
# req.add_field("client_secret", ENV["PUSH_BULLET_CLIENT_SECRET"])
# req.add_field("code", code)
# Net::HTTP.start(uri.host, uri.port) do |http|
#     request = Net::HTTP::Get.new uri

#             response = http.request request # Net::HTTPResponse object
#         end

end

def show
  @user = User.find(params[:id])
end
end
