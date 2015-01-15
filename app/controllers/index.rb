# A user can log in
# user has to see login form
# user has to see a sign up form
# user can log out


get '/' do
  erb :index
end


post '/login' do

  @user = User.find(user_name: params[:user_name])

  redirect "/users/#{@user.id}"

end

post '/signup' do


  redirect "/users/#{@user.id}"

end


get '/users/:id' do
  "Hello World!"
end
