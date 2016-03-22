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
  def update
    ap params.inspect
    current_user.update_attributes(user_params)
    redirect_to user_settings_path(current_user)
  end

  def show
    @user = User.find(params[:id])
      @time = get_sunset
      @user.reminder.upcoming_date = @time
      @user.reminder.save
      @time = @time.strftime("%B %d, %Y  %I:%M %p")
      
  end

  def reminders
      puts "PRAMS ARE: #{params}"
  end  
  def set_reminders
      puts "PRAMS ARE: #{params}"
      @r = params[:id]
      @make_true = true
      case @r
          when '10'
             puts @make_true = current_user.reminder.first = !current_user.reminder.first
             current_user.reminder.save
            print "10 command: #{@r}"
          when '20'
             @make_true = current_user.reminder.second = !current_user.reminder.second
             current_user.reminder.save
            print "20 command: #{@r}"
          when '30'
             @make_true = current_user.reminder.third = !current_user.reminder.third
             current_user.reminder.save
            print "30 command: #{@r}"
        else
            print "Illegal command: #{@r}"
        end
        current_user.send_message(@r)
  end

  private

  def user_params
      params.require(:user).permit(:name, :email, :phone_number)
  end
end
