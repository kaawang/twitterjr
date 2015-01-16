get '/tweets/new' do
  erb :'tweets/new_tweet_form'
end

post '/tweets/new' do
  tweet = Tweet.create(params[:tweet])
  redirect '/tweets/show'
end

get '/tweets/show' do
  @all_tweets = Tweet.pluck(:content).reverse
  erb :'tweets/show'
end



