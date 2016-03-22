require 'sun_times'
require 'solareventcalculator'
require 'timezone'
    
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def get_sunset
      sun_times = SunTimes.new
      @time = sun_times.set(Date.new(2016, 3, 25), 39.9500, -75.1667)

      timezone = Timezone.lookup(39.9500, -75.1667)
      puts "TIMEZONE IS #{timezone}"
      @time = @time.in_time_zone(timezone.name)
  end

  private

  helper_method :current_user
end
