#!/bin/bash

# ######################################################################################################## #
# Author: hms5232
# Source code and manual on https://github.com/hms5232/ubuntu-eat-huninn
# Contact, report bugs or ask questions: https://github.com/hms5232/ubuntu-eat-huninn/issues
# ######################################################################################################## #


# if ~/huninn dir not exist, then create it.
if [ ! -d "$HOME/huninn" ] ; then
    mkdir $HOME/huninn
    echo -e "create ~/huninn/ \n"
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
cp -i $zipname/*.ttf $HOME/huninn
# move folder to system fonts folder
sudo mv -i $HOME/huninn /usr/local/share/fonts/
# change permission
sudo chown -R root:staff /usr/local/share/fonts/huninn
sudo chmod 644 /usr/local/share/fonts/huninn/*
sudo chmod 755 /usr/local/share/fonts/huninn

# refresh fonts cache
echo -e "\n\n"
sudo fc-cache -fv

# remove zip and unzip dir
rm huninn.zip
rm -r $zipname

# finally
echo -e "\n\n"
echo -e "============== This is the end of script. ============== \n"
