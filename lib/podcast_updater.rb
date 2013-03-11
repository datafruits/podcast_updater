require 'podcast_updater/feed'
require 'podcast_updater/mp3_uploader'
require 'podcast_updater/mp3_tags'
require 'podcast_updater/version'
require 'trollop'
require 'date'

class PodcastUpdater
  def self.run(args)
    opts = Trollop::options do
      opt :pic, "Picture for podcast", :type => String
      opt :title, "Podcast title", :type => String
      opt :description, "Description of podcast", :type => String
      opt :date, "Date of podcast", :type => String
      opt :dont_update_podcast, "Don't update podcast, just upload/replace the mp3", :default => false
      opt :bucket, :type => String, :default => ENV['S3_BUCKET']
    end

    aws = {:access_key_id => ENV['S3_KEY'],
           :secret_access_key => ENV['S3_SECRET']}

    @mp3 = ARGV[0]
    @podcast = ARGV[1]

    feed = Feed.new(@podcast)
    mp3tags = Mp3Tags.new(@mp3)

    url = Mp3Uploader.upload(@mp3, aws, ENV['S3_BUCKET'])
    feed.title = opts[:title] || mp3tags.title
    feed.description = opts[:description] || mp3tags.title
    feed.mp3(@mp3,url)
    feed.date = Date.parse(opts[:date] || Time.now.to_s)
    feed.write @podcast
  end
end
