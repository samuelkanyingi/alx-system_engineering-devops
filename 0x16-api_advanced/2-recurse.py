#!/usr/bin/python3
"""Contains recurse function"""
import requests

def recurse(subreddit, hot_list=[], after=None, count=0):
    """Returns a list of titles."""
    url = "https://www.reddit.com/r/{}/hot/.json".format(subreddit)
    headers = {
        "User-Agent": "custom user agent)"
    }
    params = {
        "limit": 100
    }
    if after:
        params["after"] = after
        params["count"] = count
    
    response = requests.get(url, headers=headers, params=params, allow_redirects=False)
    if response.status_code != 200:
        return None

    ress = response.json().get("data")
    after = ress.get("after")
    count += ress.get("dist")
    
    for c in ress.get("children"):
        hot_list.append(c.get("data").get("title"))

    if after:
        return recurse(subreddit, hot_list, after, count)
    else:
        return hot_list

