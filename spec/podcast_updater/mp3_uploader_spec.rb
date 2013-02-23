require './lib/podcast_updater/mp3_uploader'
require 'vcr'
 
VCR.configure do |c|
  c.cassette_library_dir = './spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe Mp3Uploader do
  it "uploads the mp3 to amazon s3" do
    VCR.use_cassette('s3_upload') do
      file = './spec/fixtures/podcast.mp3'
      bucket = "datafruits.fm"
      aws_options = {:access_key_id => 'notimportant',
                     :secret_access_key => 'whatever'}
      Mp3Uploader.upload file, aws_options, bucket
    end
  end
end
