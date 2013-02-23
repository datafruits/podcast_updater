require 'taglib'

class Mp3Tags
  attr_reader :title,:pic
  def initialize(file)
    @file = file
  end
  def title
    TagLib::MPEG::File.open(@file) do |f|
      t = f.id3v2_tag
      t.title
    end
  end
  def pic
    TagLib::MPEG::File.open(@file) do |f|
      t = f.id3v2_tag
      cover = t.frame_list('APIC').first
      cover.picture
    end
  end
end
