require './lib/podcast_updater/feed'
require 'date'

describe Feed do
  before :each do
    @file = "./spec/fixtures/podcast.xml"
    @feed = Feed.new(@file)
    @tmp_file = "./spec/fixtures/tmp.xml"
  end
  after :each do
    File.unlink(@tmp_file) if File.exists?(@tmp_file)
  end
  it "sets the title" do
    title = "my great title"
    @feed.title=title
    @feed.write @tmp_file
    Nokogiri::XML(File.read(@tmp_file)).xpath("//item/title").text.should == title
  end
  it "sets the description" do
    description = "my great description"
    @feed.description=description
    @feed.write @tmp_file
    puts Nokogiri::XML(File.read(@tmp_file)).xpath("//item")
    Nokogiri::XML(File.read(@tmp_file)).xpath("//item/description").text.should == description
  end
  it "sets the date" do
    @feed.date=Date.parse(Time.now.to_s)
    @feed.write @tmp_file
    Nokogiri::XML(File.read(@tmp_file)).xpath("//item/pubDate").text.should == date
  end
  it "sets the mp3" do
    url = "http://aws.s3.com/podcasts/mypodcast.mp3"
    mp3 = "./spec/fixtures/podcast.mp3"
    @feed.mp3(mp3,url)
    @feed.write @tmp_file
    Nokogiri::XML(File.read(@tmp_file)).xpath("//item/enclosure").attr("url").value.should == url
    Nokogiri::XML(File.read(@tmp_file)).xpath("//item/enclosure").attr("length").value.should == File.size(mp3).to_s
    Nokogiri::XML(File.read(@tmp_file)).xpath("//item/enclosure").attr("type").value.should == "audio/mpeg"
  end
end
