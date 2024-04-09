#!/usr/bin/python3
''' this module contains the function top_ten '''
import requests


def top_ten(subreddit):
    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=10"
    headers = {'User-Agent': 'Custom User Agent'}

    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()  # Raise an error for bad response status

        data = response.json()
        posts = data['data']['children']

        print(f"Top 10 hot posts on r/{subreddit}:")
        for post in posts:
            print(post['data']['title'])

    except requests.HTTPError as e:
        if e.response.status_code == 404:
            print("Subreddit not found.")
        else:
            print("An error occurred:", e)
