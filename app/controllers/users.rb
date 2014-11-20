class BookmarkManager

  get '/users/new' do
    @user = User.new
    erb :"users/new"
  end

  post '/users' do
    @user = User.create(:email => params[:email],
                        :password => params[:password],
                        :password_confirmation => params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :"users/new"
    end
  end

  get '/users/forgot_password' do
    erb :"users/forgot_password"
  end

  post '/users/forgot_password' do
    user = User.first(email: params[:email])
    user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
    user.save
    flash[:notice] = "Please check your email"
    redirect '/'
  end

  get '/users/reset_password/:token' do
    @token = params[:token]
    user = User.first(password_token: @token)
    erb :"users/reset_password"
  end

  post '/users/reset_password' do
    @token = params[:password_token]
    user = User.first(password_token: @token)
    user.update(password: params[:password], password_token: nil)

    flash[:notice] = "Password successfully reset"
    redirect '/'
  end

end