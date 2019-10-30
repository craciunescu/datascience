import tweepy
from datetime import datetime, date, time, timedelta
from collections import Counter
import keys

# De momento lo que hace este script es descargar TODOs los tweets de
# LeBronJames. Bueno eso es lo que intento, de momento solo obtiene el texto de
# un solo tweet. More than nothing I guess.
# https://blog.f-secure.com/how-to-get-tweets-from-a-twitter-account-using-python-and-tweepy/

# Authorize access as the user.
auth    = tweepy.OAuthHandler(keys.consumer_key, keys.consumer_secret) 
auth.set_access_token(keys.access_token, keys.access_token_secret)
api     = tweepy.API(auth)

# Get reference to user.
user = api.get_user("KingJames")

# Get last tweet.
recent_tweets = [[tweet.created_at, tweet.full_text] 
                    for tweet in api.user_timeline(
                            screen_name = user.screen_name,
                            tweet_mode  = "extended",
                            count       = 200)]
