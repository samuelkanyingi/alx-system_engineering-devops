#!/usr/bin/python3
""" recursive function that queries the Reddit API and returns a list """
import requests
import sys


def count_words(subreddit, word_list, after=None, count={}):
    if word_list is None or subreddit is None:
        return

    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = {'User-Agent': 'Custom User Agent'}

    params = {'limit': 100}
    if after:
        params['after'] = after
    response = requests.get(url, headers=headers, params=params,
                            allow_redirects=False)

    if response.status_code != 200:
        return
    main_data = response.json()

    data = main_data.get('data')
    children = data.get('children')

    for post in children:
        title = post.get('data', {}).get('title').lower()

        for word in word_list:
            if word.lower() in title:
                count[word] = count.get(word, 0) + title.count(word.lower())
        after = main_data.get('data', {}).get('after')
    if after:
        count_words(subreddit, word_list, after, count)
    else:
        sorted_counts = sorted(count.items(), key=lambda x: (-x[1],
                               x[0].lower()))
        for word, count in sorted_counts:
            print(f"{word.lower()}: {count}")
