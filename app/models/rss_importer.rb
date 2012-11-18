class RssImporter
  def foo
    Net::HTTP.get_response(URI.parse('http://forums.gibberlings3.net/index.php?app=core&module=global&section=rss&type=forums&id=1')).body
  end
end
