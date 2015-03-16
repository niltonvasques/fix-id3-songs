# fix-id3-songs

A Ruby script that intend fix id3 songs info as artist, album and title.

## SYNOPSIS
    fixsongs [OPTION] [-a ARTIST] [-D DIR_PATTERN]"

## DESCRIPTION
This script intend fix songs info as artist, album and title."
For this script works as expected, songs must be placed on this organization:"
  FOLDER = ALBUM NAME"
  FILENAME = SONG NAME"
  e.g.: ~/Metallica/Black Album/Master of Puppets.mp3"

* -list           : List all media information."
* -parse          : List informations parsed from file name and folder."
* -a ARTIST       : ARTIST must be the artist name of album."
* -set            : Set all information found in parse. "
* -D DIR_PATTERN  : DIR_PATTERN must be folder name pattern. e.g. -D Metal*/ "
* -help           : Show this help."
