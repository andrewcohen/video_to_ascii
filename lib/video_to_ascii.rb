require "video_to_ascii/version"
require 'asciiart'
require 'streamio-ffmpeg'
require 'highline/import'

class VideoToAscii
  attr_accessor :ascii_images

  def initialize
    @ascii_images = []

    create_required_directories()
    capture_video()

    video = FFMPEG::Movie.new('videos/video.avi')

    screenshots_from_video(video)
    convert_all_images()

    puts "Press ENTER to watch."
    ready = gets.chomp!

    if ready
      system("clear")
      play_movie()
    end

    cleanup()
  end

  def create_required_directories
    `mkdir videos images`
  end

  def capture_video
    @video_length = ask("How long would you like the video to be?", Integer)
    path = File.expand_path('../bin/wacaw', File.dirname(__FILE__))

    puts "Recording Video for #{@video_length} seconds ..."

    `#{path} --video --duration #{@video_length} videos/video`
  end

  def screenshots_from_video(video)
    step_arr = []

    (0.0...video.duration).step(0.1).each { |x| step_arr << x.round(2) }

    #make sure steps are uniq or ffmpeg will crash and burn
    step_arr.uniq!

    step_arr.each_with_index do |step, i|
      video.screenshot("images/#{i}.jpg", seek_time: step)
    end
  end

  def convert_all_images
    images = []
    Dir.glob('images/*.jpg') { |i| images << i }

    puts "asciiing the world"
    images.each do |image|
      convert_to_ascii(image)
      print "."
    end
  end

  def play_movie
    @ascii_images.each do |image|
      puts image
      sleep 0.1
      system("clear")
    end
  end

  def convert_to_ascii(image)
      image = AsciiArt.new("#{image}")
      @ascii_images << image.to_ascii_art(color: true)
  end

  def cleanup
    `rm -rf images videos`
  end

end
