#!/bin/bash    

OUTPUT=output
rm -rf pages/*~
FILES=`ls pages/ | grep -v "style.css\|top\|bottom"`

cp pages/style.css $OUTPUT/style.css
cp -a images $OUTPUT/

for i in $FILES
do
	cat pages/top > $OUTPUT/$i.html
	cat pages/$i >> $OUTPUT/$i.html
	cat pages/bottom >> $OUTPUT/$i.html
done
