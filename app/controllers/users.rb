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
    flash[:notice] = "Please check your email"
    redirect '/'
  end

  get '/users/reset_password/:token' do
    @token = params[:token]
    user = User.first(password_token: @token)
    erb :"users/reset_password"
  end

end