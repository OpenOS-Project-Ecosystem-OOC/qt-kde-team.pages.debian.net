#!/bin/bash

FILE=pages/index

NEWS_START=`grep -n "RSS_START" ${FILE}  | sed 's/:.*//'`

let "NEWS_START += 1"

NEWS_END=`tail -n +${NEWS_START} ${FILE} | grep -n "RSS_END" | sed 's/:.*//'`

let "NEWS_END -= 1"

cat <<__EOHEAD__ 
<?xml version="1.0" encoding="iso-8859-1"?>
<rss version="2.0">
<channel>
<title>Debian KDE maintainers</title>
<description>Debian KDE news feed</description>
<link>http://pkg-kde.alioth.debian.org/</link>
<lastBuildDate>`date -R`</lastBuildDate>
<generator>bash hacking</generator>
<image>
  <url>http://pkg-kde.alioth.debian.org/images/kdedebianlogo2_64.png</url>
  <title>Debian KDE maintainers</title>
  <link>http://pkg-kde.alioth.debian.org/</link>
  <description>Debian KDE news feed</description>
</image>
__EOHEAD__

tail -n +${NEWS_START} ${FILE} | head -n +${NEWS_END} | sed  's/<a[^>]*>//g' | sed 's/<\/a[^>]*>//g' | sed 's,<p>,<item>,g;s,</p>,</description></item>,g;s,<strong>,<title>,g;s,</strong>,</title>,g;s,<br />,<link>http://pkg-kde.alioth.debian.org/</link><description>,g'

cat << __EOFOOT__
        </channel>
</rss>

__EOFOOT__

