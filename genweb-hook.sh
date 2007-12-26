#!/bin/bash -e

DIR=/var/lib/gforge/chroot/home/groups/pkg-kde/web-autoupdate/www/v2
OUTPUT=/var/lib/gforge/chroot/home/groups/pkg-kde/web-autoupdate/www/v2/output
rm -rf $DIR/pages/*~ $OUTPUT
FILES=`ls $DIR/pages/ | grep -v "style.css\|top\|bottom"`

cp $DIR/pages/style.css $OUTPUT/style.css
cp -a $DIR/images $OUTPUT/
cp $DIR/images/KDEbian2.ico $OUTPUT/favicon.ico


for i in $FILES
do
	cat $DIR/pages/top > $OUTPUT/$i.html
	cat $DIR/pages/$i >> $OUTPUT/$i.html
	cat $DIR/pages/bottom >> $OUTPUT/$i.html
done

sh $DIR/genrss.sh > $OUTPUT/rss.xml

# find $OUTPUT/ -name ".svn" -exec rm -rf {} \; || true
chmod -R g+w $OUTPUT/*
cp -a $OUTPUT* /var/lib/gforge/chroot/home/groups/pkg-kde/htdocs
