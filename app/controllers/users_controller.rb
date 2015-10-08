class UsersController < ApplicationController

	# 其实这样也可以使用new action,只是名字的不同而己，其他的都类似。
  def signup
  	@user = User.new
  end

  def create
  	@user = User.create(user_params) # 为了保证能把错误信息能够传递给html模版，这里必须使用实例变量。
  	if @user.save
      cookies[:auth_token] = @user.auth_token # 如果用户注册成功，直接去设置cookie，让她登陆成功
  	redirect_to :root
  	else
  	render 'signup'  # 不能为redirect_to
  	end		
  end	

  #def create_login_session
  	#@user = User.find_by_name(params[:name])
  	#if @user && @user.authenticate(params[:password])
  		#session[:user_id] = @user.id  #服务器上保存用户的id,但是当浏览器关闭的时候，就消失了
  		#redirect_to :root
  	#else
  		#render 'login'
  	#end
  #end

  def create_login_session
    @user = User.find_by_name(params[:name])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me] # 如果我勾选了rememeber_me 的选项，下面就保存cookie啦
        cookies.permanent[:auth_token] = @user.auth_token
      else
        cookies[:auth_token] = @user.auth_token # 如果我没有勾选remember_me 这个选项，浏览器也会保存cookie，不要这个cookie就是session，也就是临时的cookie。
      end
      flash.notice = "登陆成功"
      redirect_to :root
    else
      flash.notice = "用户名、密码错啦"
      redirect_to :login
    end
  end

  def logout
  	#session[:user_id] = nil  暂时的记住用户
    cookies.delete(:auth_token)
  	redirect_to :root
  end



  private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)	
    # params.require(:user).permit! 这样也可以，就是允许 user 的所有字段。
  end
  #Parameters: {"utf8"=>"✓", "authenticity_token"=>"0CO40ESRVmU7YFAHpSy8Z7VdGjHNZqgB516AlxYbJBN4hNK2wFcVA3UrW+/1He4I5vRz2MWws/MY/K4q/QGP2w==", 
  #              "user"=>{"name"=>"韩文波", "email"=>"hwbnju@gmail.com", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}, "commit"=>"注册"}
end
