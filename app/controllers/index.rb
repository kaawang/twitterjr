# A user can log in
# user has to see login form
# user has to see a sign up form
# user can log out

get '/' do
  @user = User.new
  erb :'users/index'
end

get '/users/new' do
  @user = User.new
  erb :"users/new"
end

get '/sessions/new' do
  @user = User.new
  erb :"sessions/new"
end

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


get '/users/:id' do
  if session[:user_id] == params[:id].to_i
    @all_tweets = Tweet.pluck(:id, :content).reverse
    erb :"tweets/show"
  else
    redirect '/'
  end
end


####### TWEETS

get '/tweets/new' do
  erb :'tweets/new_tweet_form'
end

post '/tweets/new' do
  tweet = Tweet.create(params[:tweet])
  redirect '/tweets/show'
end




