import boto3
import spotipy
import csv
import os

from spotipy.oauth2 import SpotifyClientCredentials
from datetime import datetime

# Auth through SPOTIPY_CLIENT_ID and SPOTIPY_CLIENT_SECRET environment variables
spotify = spotipy.Spotify(client_credentials_manager=SpotifyClientCredentials())
s3_client = boto3.client('s3')
caviar_id = '37i9dQZF1DX0XUsuxWHRQd'

def handle_lambda(event, context):

    # source playlist info
    caviar = spotify.playlist_tracks(caviar_id)

    with open('/tmp/rapcaviar_songs.csv', 'w') as f:
        writer = csv.DictWriter(f, fieldnames=[
            'name',
            'artist',
            'track_id',
            'popularity',
            'release_date'
        ])
        writer.writeheader()

        for track in caviar['items']:
            t = track['track']
            
            writer.writerow({
                'name': t['name'],
                'artist': t['artists'][0]['name'],
                'track_id': t['id'],
                'popularity': t['popularity'],
                'release_date': t['album']['release_date']
            })

    today = datetime.now()
    s3_client.upload_file(
        '/tmp/rapcaviar_songs.csv',
        f"{os.environ['ENVIRONMENT']}-data52", # bucket
        f"{today.year}/{today.month}/{today.day}/rapcaviar_songs.csv"
    )

if __name__ == '__main__':
    pass
            

