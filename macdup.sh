# macdup
#
# VBaddict Dossier Uploader for OSX
# see https://github.com/wolframteetz/worldoftanks/blob/master/README.md
#

VB_TOKEN=c44PS3QCemfcJFgYpWWB
VB_USER=lotusthemotus
VB_SERVER=eu

clear
echo "Dossier Uploader for vBAddict"
echo "https://github.com/wolframteetz/worldoftanks/blob/master/README.md"
echo 

while true
do 
    cd ~/Library/Application\ Support/World\ of\ Tanks/Bottles/worldoftanks/drive_c/users/crossover/Application\ Data/Wargaming.net/WorldOfTanks/dossier_cache
    if [ -n "$(find . -name "*.dat" -mmin -1)" ]; then 
    echo "Number of new dossier files"
    find . -name "*.dat" -mmin -1 | wc -l
    find . -name "*.dat" -mmin -1 -exec sh -c "curl -s --upload-file {} http://carius.vbaddict.net:82/upload_file/dossier/$VB_SERVER/$VB_USER/$VB_TOKEN/json | jq \".message\" " \; 
    fi
    cd ~/Library/Application\ Support/World\ of\ Tanks/Bottles/worldoftanks/drive_c/users/crossover/Application\ Data/Wargaming.net/WorldOfTanks/battle_results
    if [ -n "$(find . -name "*.dat" -mmin -1)" ]; then
    echo "Number of new battle result files"
    find . -name "*.dat" -mmin -1 | wc -l
    find . -name "*.dat" -mmin -1 -exec sh -c "curl -s --upload-file {} http://carius.vbaddict.net:82/upload_file/battleresult/$VB_SERVER/$VB_USER/$VB_TOKEN/json | jq \".message\" " \; 
    fi
    cd ~/Documents/World_of_Tanks/replays
    if [ -n "$(find . -name "replay*.wotreplay" -mmin -1)" ]; then
    echo "Uploading replays"
    find . -name "replay*.wotreplay" -mmin -1 | wc -l
    find . -name "replay*.wotreplay" -mmin -1 -exec sh -c "curl -s --upload-file {} http://carius.vbaddict.net:82/upload_file/replay/$VB_SERVER/$VB_USER/$VB_TOKEN/json | jq \".message\" " \;
    fi
    echo -n "Next check for new dossier files at "
    date -v +1M
    sleep 60
done
