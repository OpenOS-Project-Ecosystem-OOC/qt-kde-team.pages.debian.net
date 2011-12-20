#!/bin/bash -e

OUTPUT=output
mkdir -p $OUTPUT
rm -rf pages/*~ $OUTPUT/*
FILES=`ls pages/ | grep -v "style.css\|top\|bottom"`

cp pages/style.css $OUTPUT/style.css
cp -a images $OUTPUT/
cp -a files $OUTPUT/
cp images/KDEbian2.ico $OUTPUT/favicon.ico


for i in $FILES
do
	cat pages/top > $OUTPUT/$i.html
	cat pages/$i >> $OUTPUT/$i.html
	cat pages/bottom >> $OUTPUT/$i.html
done

bash genrss.sh > $OUTPUT/rss.xml

# find $OUTPUT/ -name ".svn" -exec rm -rf {} \; || true
chmod -R g+w $OUTPUT/*
