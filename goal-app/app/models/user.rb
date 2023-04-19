class User < ApplicationRecord
    validates :username, :session_token, uniqueness: true, presence: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6}
    
    before_validation :ensure_session_token

    attr_reader :password

    has_many :goals,
        foreign_key: :user_id,
        class_name: :Goal

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def is_password?(password)
        pass = BCrypt::Password.new(password_digest)
        pass.is_password?(password)
    end

    def generate_unique_session_token
        loop do
            session_token = SecureRandom::urlsafe_base64
            if User.find_by(session_token: session_token).nil?
                return session_token
            end
        end
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end

    def reset_session_token!
        self.session_token = generate_unique_session_token
        self.save!
        self.session_token
    end

    def self.find_by_credentials(username,password)
        user = User.find_by(username: username)

        if user && user.is_password?(password)
            user
        else
            nil 
        end
    end

end
