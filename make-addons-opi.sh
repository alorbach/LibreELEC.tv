#!/bin/bash

# Build Addons
export PROJECT=H3 ARCH=arm ADDON_VERSION=7.0

ADDONPATHES="./packages/addons ./packages/mediacenter/kodi-binary-addons"

echo "Addon path?"
select ADDONPATH in $ADDONPATHES 
do
        echo "Making Addons '$ADDONPATH' for '$PROJECT/$ARCH'"
        break;
done

#scripts/create_addon hyperion
#scripts/create_addon oscam

for package in $(find $ADDONPATH -iname package.mk) ; do
(
	. $package
	if [ "$PKG_IS_ADDON" = "yes" ] ; then
		ADDON=$PKG_NAME
		PROJECT=$PROJECT ARCH=$ARCH ./scripts/create_addon $ADDON
	fi
)
done


# Touch XML Files if not there 
if [ ! -d target/addons/$ADDON_VERSION/$PROJECT/$ARCH ]; then
	break
fi
if [ ! -f target/addons/$ADDON_VERSION/$PROJECT/$ARCH/addons.xml ]; then
	touch target/addons/$ADDON_VERSION/$PROJECT/$ARCH/addons.xml
fi



# Generate XML Files 
echo "[*] cleanup addons ..."
olddir=""
find target/addons/$ADDON_VERSION -iname 'changelog*.txt' | sort -rV | while read line ; do
dir=$(dirname $line)
if [ "$olddir" = "$dir" ] ; then
rm -f $line
fi
olddir=$dir
done

olddir=""
find target/addons/$ADDON_VERSION -iname '*.zip' | sort -rV | while read line ; do
dir=$(dirname $line)
if [ "$olddir" = "$dir" ] ; then
rm -f $line
fi
olddir=$dir
done


echo "[*] updating addons.xml* ..."
rm -rf .addons
pwd=`pwd`
find target/addons/$ADDON_VERSION -iname addons.xml | while read line ; do
localdir=`echo $line | sed s/addons.xml//g`
echo " [*] updating $line..."
echo '<?xml version="1.0" encoding="UTF-8"?>
<addons>
' > $line.tmp
for zip in $localdir/*/*.zip ; do
mkdir -p ".addons/$localdir"
unzip $zip "*/addon.xml" -d ".addons/$localdir" &>/dev/null
done
find .addons/$localdir -iname addon.xml | grep -v resources/ | while read xml ; do
cat $xml | grep -v "<?" >> $line.tmp
done
echo '
</addons>' >> $line.tmp
mv $line.tmp $line
cd $localdir

# Update addons.xml.gz!
rm addons.xml.gz
gzip addons.xml
md5sum addons.xml.gz > addons.xml.gz.md5
cd $pwd
done
rm -rf .addons
