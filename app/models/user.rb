class User < ActiveRecord::Base

	has_secure_password # 可以把在form表单中传递的明文密码加密，保存在数据库的password_digest 栏位中。自动验证密码  
	has_many :comments 
  has_many :issues

	before_create {generate_token(:auth_token)} #每次创建user的时候都运行 generate_token 方法

	validates :name, :email, presence: true
	validates :name, :email, uniqueness: {case_sensitive: false}
	validates :password, length: {minimum: 6}


	def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def avatar
    gravatar_id = Digest::MD5.hexdigest(self.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=512&d=retro"
  end


end
