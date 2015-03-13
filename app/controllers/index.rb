# A user can log in
# user has to see login form
# user has to see a sign up form
# user can log out

#### LOGIN

get '/' do
  @user = User.new
  erb :'users/index'
end

# Sign up
get '/users/new' do
  @user = User.new
  erb :"users/new"
end

# Login
get '/sessions/new' do
  @user = User.new
  erb :"sessions/new"
end

# Login - Redirect to either profile page or to login page
post '/sessions' do
  @user = User.find_by(user_name: params[:user_name])
  if  !@user.nil? && @user.password == params[:password]
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    @error = "Username or password does not match. Please try again!"
    erb :"sessions/new"
  end
end

# Sign up - Redirect to either profile page or to sign up page
post '/users' do
  @user = User.new(user_name: params[:user_name])
  @user.password = params[:password]
  if @user.save
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    @errors = @user.errors.full_messages
    erb :"users/new"
  end
end

####### USER'S MAIN PAGE


get '/users/:id' do
  if session[:user_id] == params[:id].to_i
    @user_id = session[:user_id] 
    @user_tweets = Tweet.where(:user_id => session[:user_id]).pluck(:id, :content).reverse
    erb :"tweets/show"
  else
    redirect '/'
  end
end


####### TWEETS

get '/users/:id/tweets/new' do
  @user_id = session[:user_id] 
  erb :'tweets/new_tweet_form'
end

post '/users/:id' do
  # @user_id = session[:user_id] 
  # tweet = Tweet.create(params[:tweet])
  # redirect "/users/#{@user_id}"
  @user = User.find(session[:user_id])
  @user.tweets.create(params[:tweet])   #review this after twitter demo
  redirect "/users/#{@user.id}"
end



### logging out

get '/logout' do
  session[:user_id] = nil
  erb :"sessions/logout"
end