require 'nokogiri'

class Feed
  DATE_FORMAT = "%a, %d %b %Y %H:%M:%S %Z"
  def initialize(file)
    @feed = read(file)
    @new_item = Nokogiri::XML::Node.new "item", @feed
  end
  def title=(title)
    title_node = Nokogiri::XML::Node.new "title", @feed 
    title_node.content = title
    @new_item.add_child(title_node)
  end
  def description=(description)
    description_node = Nokogiri::XML::Node.new("description", @feed)
    description_node.content = description
    @new_item.add_child(description_node)
  end
  def mp3(mp3, url)
    enclosure_node = Nokogiri::XML::Node.new("enclosure", @feed)
    enclosure_node['url'] = url.to_s
    enclosure_node['length'] = File.size(mp3).to_s
    enclosure_node['type'] = "audio/mpeg"
    @new_item.add_child(enclosure_node)
    guid = Nokogiri::XML::Node.new("guid", @feed)
    guid.content = url.to_s
    @new_item.add_child(guid)
  end
  def date=(date)
    date_node = Nokogiri::XML::Node.new("pubDate", @feed)
    date_node.content = "#{date.strftime(DATE_FORMAT)} #{Time.now.zone}"
    @new_item.add_child(date_node)
  end
  def read(file)
    @feed = Nokogiri::XML(File.read(file)) do |config|
      config.default_xml.noblanks
    end
  end
  def write(file)
    @feed.at_css("channel").add_child(@new_item)

    @feed.at_css("lastBuildDate").content = Time.now.strftime(DATE_FORMAT)
    File.open(file, "w"){|f| f.write(@feed)}
  end
end
