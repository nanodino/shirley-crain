#!/bin/bash

REMOTE_USER="nano"
REMOTE_HOST="raspberrypi"

LOCAL_BASE="/Users/nancycantusaldana/server-staging"
REMOTE_BASE="/media/nano/KINGSTON/jelly"

LOCAL_MUSIC_PATH="${LOCAL_BASE}/music/"
LOCAL_TV_PATH="${LOCAL_BASE}/tv/"
LOCAL_MOVIE_PATH="${LOCAL_BASE}/movies/"

REMOTE_MUSIC_PATH="${REMOTE_BASE}/Music"
REMOTE_TV_PATH="${REMOTE_BASE}/Shows"
REMOTE_MOVIE_PATH="${REMOTE_BASE}/Movies"

usage() {
    echo "Usage: $0 [-m | -t | -v]"
    echo "  -m: Sync music files"
    echo "  -t: Sync TV show files"
    echo "  -v: Sync movie files"
    exit 1
}

while getopts "mtv" flag; do
    case "${flag}" in
        m)
            LOCAL_PATH="${LOCAL_MUSIC_PATH%/}/"
            REMOTE_PATH="${REMOTE_MUSIC_PATH%/}/"
            echo "Syncing music files..."
            ;;
        t)
            LOCAL_PATH="${LOCAL_TV_PATH%/}/"
            REMOTE_PATH="${REMOTE_TV_PATH%/}/"
            echo "Syncing TV show files..."
            ;;
        v)
            LOCAL_PATH="${LOCAL_MOVIE_PATH%/}/"
            REMOTE_PATH="${REMOTE_MOVIE_PATH%/}/"
            echo "Syncing movie files..."
            ;;
        *)
            usage
            ;;
    esac
done

if [ $OPTIND -eq 1 ]; then
    usage
fi

scp -r "${LOCAL_PATH}"* "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}"

ssh "${REMOTE_USER}@${REMOTE_HOST}" "sudo chown -R nano:jellyfin \"${REMOTE_PATH}\" && sudo chmod -R 750 \"${REMOTE_PATH}\""
echo "Permissions set for jellyfin to access files"

scp -r "${LOCAL_PATH}"* "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}"
