import tweepy
from datetime import datetime, date, time, timedelta
from collections import Counter

# De momento lo que hace este script es descargar TODOs los tweets de
# LeBronJames. Bueno eso es lo que intento, de momento solo obtiene el texto de
# un solo tweet. More than nothing I guess.
# https://blog.f-secure.com/how-to-get-tweets-from-a-twitter-account-using-python-and-tweepy/

# Access tokens -> Personal to Dave
consumer_key        = "Md6UeqRZJNUwwtsGQoqH5jkAM"
consumer_secret     = "PVeg4D3re7d8qcw1kDQ4QURRtUFbK8agVOUmxcIAekpuudx8rD"
access_token        = "1189159169183621120-EWMEbYfP2N75uIlwERwkjRH4gchCm0"
access_token_secret = 'tw9q0wR3e9IAdXhzn4Ryp7Pv9o9ArCpov94rsmxNMTmHK'

# Authorize access as the user.
auth    = tweepy.OAuthHandler(consumer_key, consumer_secret) 
auth.set_access_token(access_token, access_token_secret)
api     = tweepy.API(auth)

# Get reference to user.
user = api.get_user("KingJames")

# Get last tweet.
tweet = api.user_timeline(screen_name = user.screen_name, tweet_mode =
"extended")[0].full_text

recent_tweets = [[tweet.full_text, tweet. for tweet in api.user_timeline(
                                                screen_name = user.screen_name,
                                                tweet_mode  = "extended")]
