module ApplicationHelper
    def make_it_clear(date_time)
        time = date_time.strftime("%I:%M %p")
        date = date_time.strftime("%B %d, %Y ")
        "You will be reminded at #{time} on #{date}"
    end
end
