#!/bin/bash -e

OUTPUT=output
mkdir -p $OUTPUT
rm -rf pages/*~ $OUTPUT/*
FILES=`ls pages/ | grep -v "style.css\|top\|bottom"`

cp pages/style.css $OUTPUT/style.css
cp -a images $OUTPUT/
cp -a files $OUTPUT/
cp -a redir $OUTPUT/
cp images/KDEbian2.ico $OUTPUT/favicon.ico


for i in $FILES
do
	cat pages/top > $OUTPUT/$i.html
	cat pages/$i >> $OUTPUT/$i.html
	cat pages/bottom >> $OUTPUT/$i.html
done

bash genrss.sh > $OUTPUT/rss.xml

# Generate Qt5 build dependencies graph. Needs dot.
dot -T png -o $OUTPUT/images/qt5_build_deps.png files/qt5-build-deps.dot

# Generate Pim5 build dependencies graph. Needs dot.
for i in files/pim-build-deps*dot
do
	dot -T png -o $OUTPUT/images/`basename $i .dot`.png $i
done

# find $OUTPUT/ -name ".svn" -exec rm -rf {} \; || true
chmod -R g+w $OUTPUT/*
