require './lib/podcast_updater/mp3_tags.rb'

describe Mp3Tags do
  it "reads the title tag" do
    tags = Mp3Tags.new("./spec/fixtures/podcast.mp3")
    tags.title.should == "podcast"
  end
  it "reads the cover art" do
    tags = Mp3Tags.new("./spec/fixtures/podcast.mp3")
    cover_art = IO.read("./spec/fixtures/cover_art.jpg")
    tags.pic.length.should == cover_art.length
    tags.pic.should == cover_art
  end
end
