#!/bin/bash

# ######################################################################################################## #
# Author: hms5232
# Source code and manual on https://github.com/hms5232/ubuntu-eat-huninn
# Contact, report bugs or ask questions: https://github.com/hms5232/ubuntu-eat-huninn/issues
# ######################################################################################################## #


# if ~/.fonts dir not exist, then create it.
if [ ! -d "$HOME/.fonts" ] ; then
    mkdir $HOME/.fonts
    echo -e "create ~/.fonts/ \n"
fi

url=$(curl -s https://api.github.com/repos/justfont/open-huninn-font/releases/latest | grep "browser_download_url" | awk '{ print $2 }' | sed 's/"//g')
zipname=$(basename $url .zip)

echo "Now download $zipname from $url"

# Let's download font
# download 粉圓
wget -O huninn.zip $url

# unzip
unzip huninn.zip

# check zip file download and upzip succefully
if [ ! -d "$zipname" ] ; then
	echo -e "\n\n"
	echo -e "\a========= The font file went wrong! Please try again later. =========\n"
	exit 1
fi

# copy fonts to ~/.fonts
echo -e "\n\n"
cp -i $zipname/*.ttf $HOME/.fonts

# refresh fonts cache
echo -e "\n"
sudo fc-cache -fv

# remove zip and unzip dir
rm huninn.zip
rm -r $zipname

# finally
echo -e "\n\n"
echo -e "============== This is the end of script. ============== \n"
