    require 'net/http'

    class UsersController < ApplicationController

        def settings
            
        end

        def parse_pb_auth
            code = params[:code]
            puts "TESTING HERE: #{params[:code]}"

            uri = URI.parse("https://api.pushbullet.com/oauth2/token")
            https = Net::HTTP.new(uri.host,uri.port)
            https.use_ssl = true
            req = Net::HTTP::Post.new(uri.path)

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

          current_user.update_push_bullet

          redirect_to current_user
      end

      def edit


      # date = Date.new(2016, 3, 21)
      # @time = SolarEventCalculator.new(date, 39.9500, -75.1667)

  end

  def show
      get_sunset
      @user = User.find(params[:id])
  end
end
