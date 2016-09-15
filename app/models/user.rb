class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and , :omniauthable
  
  belongs_to :player

  after_create :bind_new_player#, :send_admin_mail

  def send_admin_mail
    UserMailer.welcome_email(self).deliver_now
  end

  def bind_new_player
    avatar = File.open(Rails.root.join('misc','player.jpg'))
    player = Player.create(name: "Player-#{self.email.scan(/^(.*)@/)[0][0]}", avatar: avatar)
    self.update(player_id: player.id)
  end

  def self.from_omniauth(auth)  
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end

