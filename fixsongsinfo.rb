#!/usr/bin/env ruby
# Copyright [2015] [Nilton Vasques <nilton.vasques@gmail.com>]
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Description: This script intend fix songs info as artist, album and title.
# For this script works as expected, songs must be placed on this organization:
# FOLDER = ALBUM NAME
# FILENAME = SONG NAME
# e.g.: ~/Metallica/Black Album/Master of Puppets.mp3
#
# Required: id3tool package
#

require 'mkmf'
require 'fileutils' #I know, no underscore is not ruby-like
include FileUtils

def help
  puts " User Commands                                                                                           FIXSONGS(1)"
  puts ""
  puts " NAME"
  puts " fixsongs - Fix mp3 songs information."
  puts ""
  puts " SYNOPSIS"
  puts " fixsongs [OPTION] [-a ARTIST] [-D DIR_PATTERN]"
  puts ""
  puts " DESCRIPTION'"
  puts ""
  puts " This script intend fix songs info as artist, album and title."
  puts " For this script works as expected, songs must be placed on this organization:"
  puts " FOLDER = ALBUM NAME"
  puts " FILENAME = SONG NAME"
  puts " e.g.: ~/Metallica/Black Album/Master of Puppets.mp3"
  puts ""
  puts "-list           : List all media information."
  puts "-parse          : List informations parsed from file name and folder."
  puts "-a ARTIST       : ARTIST must be the artist name of album."
  puts "-set            : Set all information found in parse. "
  puts "-D DIR_PATTERN  : DIR_PATTERN must be folder name pattern. e.g. -D Metal*/ "
  puts "-help           : Show this help."
end

def parse(opts = {} )
  Dir[opts[:dir_pattern]].each do |folder|
    begin
      album = folder.split('/').join().split('-')[1].strip
      album = opts[:album] unless opts[:album].nil?
      puts album
      Dir[folder+'*.mp3'].each do |music|
        file = music.split('/')[1]
        name = file.split('-')[1].strip.split('.mp3')[0]

        case opts[:cmd]
        when '-list'
          system( "id3tool '#{music}'")
        when '-set'
          system( "id3tool -r '#{opts[:artist]}' -t '#{name}' -a '#{album}' '#{music}'")
        when '-parse'
          puts "Album: #{album}"
          puts "Song: #{name}"
        when '-help'
          help
        else 
          puts "Invalid option. Type help for usage"
        end
      end
    rescue
      puts "ERROR: Invalid pattern in folder #{folder}"
    end
  end
end


EXEID3 = find_executable 'id3tool'
if EXEID3.nil? 
  puts "id3tool package not found!"
  Kernel.exit(false)
else

  opts = {cmd: '-parse', artist: 'Unknown', dir_pattern: '*/' }

  if !ARGV.empty?
    opts[:cmd] = ARGV[0]
    if ARGV.include?("-a")
      index = ARGV.index("-a")
      opts[:artist] = ARGV[index+1] unless ARGV[index+1].nil?
    end
    if ARGV.include?("-D")
      index = ARGV.index("-D")
      opts[:dir_pattern] = ARGV[index+1] unless ARGV[index+1].nil?
    end
    if ARGV.include?("-A")
      index = ARGV.index("-A")
      opts[:album] = ARGV[index+1] unless ARGV[index+1].nil?
    end
  end

  puts opts[:cmd]
  case opts[:cmd] 
  when '-list'
    parse opts
  when '-set'
    parse opts
  when '-parse'
    parse opts
  when '-help'
    help
  else 
    puts "Invalid option. Type help for usage"
  end
end 

