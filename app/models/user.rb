class User < ApplicationRecord
    before_destroy :admin_not_delete
    before_update :admin_not_update
    has_many :daily_reports, dependent: :destroy

    #日報閲覧許可
    has_many :report_deliveries
    has_many :delivered_reports, through: :report_deliveries, source: :daily_report
    
    #バリデーション
    validates :name,  presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    before_validation { email.downcase! }  
    has_secure_password     
    validates :password, length: { minimum: 6 }  

    def guest?
        name == 'Guest User' && email == 'guest@example.com'
    end
    
    def admin_guest?
        guest? && admin
    end

    private

    def admin_not_delete
        throw(:abort) if User.where(admin: true).count == 1 && self.admin == true
    end
    
    def admin_not_update
        throw(:abort) if User.where(admin: true).count == 1 && will_save_change_to_attribute?(:admin, to: false)
    end

    def self.admin_guest
        find_or_create_by!(email: 'admin_guest@example.com') do |user|
          user.password = SecureRandom.urlsafe_base64
          user.name = 'Admin Guest'
          user.admin = true
        end
    end

end
