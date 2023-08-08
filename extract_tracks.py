import boto3
import spotipy
import csv
import os

from spotipy.oauth2 import SpotifyClientCredentials
from datetime import datetime

# Auth through SPOTIPY_CLIENT_ID and SPOTIPY_CLIENT_SECRET environment variables
spotify = spotipy.Spotify(client_credentials_manager=SpotifyClientCredentials())
s3_client = boto3.client('s3')
caviar_id = "37i9dQZF1DX0XUsuxWHRQd"

def handle_lambda(event, context):

    # source playlist info
    caviar = spotify.playlist_tracks(caviar_id)

    with open("/tmp/rapcaviar_songs.csv", "w") as f:
        writer = csv.dictWriter(f, fieldnames=["name", "artist", "track_id", "popularity"])
        writer.writeheader()

        for track in caviar['items']:
            t = track['track']
            writer.writerow( {
                'name': t['name'],
                'artist': t['artist']
                'track_id': t['id']
                'popularity': t['populrity']
            } )

    today = datetime.now()
    s3_client.upload_file(
        '/tmp/rapcaviar_songs.csv',
        f'{os.environ['ENVIRONMENT']}_data', # bucket
        f'{date.year}/{date.month}/{date.day}/rapcaviar_songs.csv'
    )
            

