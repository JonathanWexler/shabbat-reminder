    require 'net/http'
    require 'sun_times'
    require 'solareventcalculator'
    require 'timezone'

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
      @time = sun_times.set(Date.new(2016, 3, 25), 39.9500, -75.1667)

      timezone = Timezone.lookup(39.9500, -75.1667)
      puts "TIMEZONE IS #{timezone}"
      @time = @time.in_time_zone(timezone.name).strftime("%B %d, %Y  %I:%M %p")
      # date = Date.new(2016, 3, 21)
      # @time = SolarEventCalculator.new(date, 39.9500, -75.1667)

end

def show
  @user = User.find(params[:id])
end
end
