# -* coding: utf-8 -*-

#Variable
genre_id = 1
ENTRIES = 5

#Load
require 'uri'
require 'open-uri'
require 'rss'
require 'mysql'
#getfeed
uri = URI.parse('http://b.hatena.ne.jp/entrylist?mode=rss&sort=hot&threshold=3')
rss = RSS::Parser.parse(uri.read)
rss.output_encoding = 'utf-8' 
#DB Connect
my = Mysql.connect('localhost','root','','ecolo')
my.charset = 'utf8'

bookmarks = []
#get/Edit
rss.items.each do |i|
  bookmarks.push([i.title, i.link, i.description])
end

#Insert
ins = my.prepare('insert into Thread (Thread_name,Genre_id) values (?,?)')
bookmarks[0,ENTRIES].map { |i|
  ins.execute i[0],genre_id
}
