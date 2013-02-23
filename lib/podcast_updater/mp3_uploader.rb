require 'aws-sdk'

class Mp3Uploader
  def self.upload(file,aws_options,bucket_name)
    AWS.config(aws_options)
    s3 = AWS::S3.new
    bucket = s3.buckets.create(bucket_name)

    basename = File.basename(file)
    puts basename
    o = bucket.objects[basename]
    o.write(:file => file, :acl => :public_read, :metadata => {"Content-Type" => "audio/mpeg"})
    o.public_url
  end
end
