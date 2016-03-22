class User < ActiveRecord::Base
 def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user| 
            ap auth
            user.provider = auth.provider
            user.uid = auth.uid
            user.email = auth.info.email
            user.image_url = "http://graph.facebook.com/#{user.uid}/picture?type=large"
            user.name = auth.info.name
            user.oauth_token = auth.credentials.token user.oauth_expires_at = Time.at(auth.credentials.expires_at) 
            user.save!
        end
    end

    def update_push_bullet
        client = Washbullet::Client.new(self.pb_access_token)
        ap client.devices
        client.devices.each do |device|
            d = device.body
            if d['type'] == 'ios'
                ap "YES IT'S N IPHONE"
                self.pb_device_type = d['type']
                self.pb_device_iden = d['iden']
            end
        end
        self.save
    end

    def pb_registered?
        !pb_access_token.nil?
    end

end
