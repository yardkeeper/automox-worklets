#!/bin/bash
function parse_url() {
curl -f -L $1 | grep -Eo "https?://\S+?\"" | grep Sourcetree_ | sort -r | head -1 | tr -d '"'
}
export -f 

lastv=$(parse_url https://www.sourcetreeapp.com)
arch=$(echo $lastv | cut -d "/" -f7 )
echo "Url:" $lastv
echo "Archive:" $arch
curl -O $lastv
osascript -e 'quit app "Sourcetree"'
if [[ -d /Applications/Sourcetree.app ]]
 then 
rm -rf /Applications/Sourcetree.app
else 
sleep 1
fi 
unzip $arch -d /Applications/ >/dev/null
ls -la /Applications
