#!/usr/bin/python3
''' Write a function to find How many subs '''
import requests


def number_of_subscribers(subreddit):
    ''' number of subs'''
    url = f"https://www.reddit.com/r/{subreddit}/about.json"
    headers = {'User-Agent': 'Custom User Agent'}

    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()  # Raise an error for bad response status

        data = response.json()
        subscribers = data['data']['subscribers']
        return subscribers

    except requests.HTTPError as e:
        if e.response.status_code == 404:
            print("Subreddit not found.")
        else:
            print("An error occurred:", e)

    except Exception as e:
        print("An error occurred:", e)

    return 0
