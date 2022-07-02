from seedrcc import Login
from seedrcc import Seedr
import os
from time import sleep

# no need to create manually
CACHEFILE = 'seedrtoken.txt'

DOWNLOADLOCATION = {
    "1" : "/mnt/location1/",
    "2" : "/mnt/location2/" 
}

if not os.path.exists(CACHEFILE):
    seedr = Login('USERNAME', 'PASSWORD')
    response = seedr.authorize()
    with open(CACHEFILE, 'w') as f:
        f.write(seedr.token)

# Read the token from token.txt
token = open(CACHEFILE, 'r').read().strip()

# Defining the callback function
def afterRefresh(token):
    with open(CACHEFILE, 'w') as f:
        f.write(token)

account = Seedr(token, callbackFunc=afterRefresh)

ch = input("enter magnet: ")
if ch is not None:
    response = account.addTorrent(magnetLink='magnet:?xt=urn:btih:DDA07317C1CDB90CFA1B87C55AB7259667F2A878&dn=Stranger.Things.S04E08.720p.WEB.x265-MiNX%5BTGx%5D&tr=udp%3A%2F%2Fopen.stealth.si%3A80%2Fannounce&tr=udp%3A%2F%2Ftracker.tiny-vps.com%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=udp%3A%2F%2Ftracker.torrent.eu.org%3A451%2Fannounce&tr=udp%3A%2F%2Fexplodie.org%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.cyberia.is%3A6969%2Fannounce&tr=udp%3A%2F%2Fipv4.tracker.harry.lu%3A80%2Fannounce&tr=udp%3A%2F%2Fp4p.arenabg.com%3A1337%2Fannounce&tr=udp%3A%2F%2Ftracker.birkenwald.de%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.moeking.me%3A6969%2Fannounce&tr=udp%3A%2F%2Fopentor.org%3A2710%2Fannounce&tr=udp%3A%2F%2Ftracker.dler.org%3A6969%2Fannounce&tr=udp%3A%2F%2F9.rarbg.me%3A2970%2Fannounce&tr=https%3A%2F%2Ftracker.foreverpirates.co%3A443%2Fannounce&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=http%3A%2F%2Ftracker.openbittorrent.com%3A80%2Fannounce&tr=udp%3A%2F%2Fopentracker.i2p.rocks%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.internetwarriors.net%3A1337%2Fannounce&tr=udp%3A%2F%2Ftracker.leechers-paradise.org%3A6969%2Fannounce&tr=udp%3A%2F%2Fcoppersurfer.tk%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.zer0day.to%3A1337%2Fannounce')
    print(response)
    table=account.listContents()
    while(table["torrents"]!=[]):
        for folder in table["torrents"]:
            print(folder["id"],folder["progress"],folder["name"])
        sleep(5)
        table=account.listContents()

    if 'result' in response:
        #! If torrent added successfully
        if 'user_torrent_id' in response:
            #bot.edit_message_text(chat_id=message.chat.id, message_id=sent.id, text=language['torrentAddedSuccessfully'][userLanguage])
            print("torrent added successfully")

        #! If no enough space
        elif response['result'] in ['not_enough_space_added_to_wishlist', 'not_enough_space_wishlist_full']:
            print('not enough space')
        #! Invalid magnet link
        elif response['result'] == 'parsing_error':
            print('invalid magent')

        #! If parallel downloads exceeds
        elif response['result'] == 'queue_full_added_to_wishlist':
            print('parallel download exceeds')

        #! If the torrent is already downloading
        elif response == {'result': True}:
            print('torrent is already downloading')

        #! If no torrent is passed
        elif 'error' in response and response['error'] == 'no_torrent_passed':
            print('no torrent passed')                
        else:
            print('Error')

    ch = input(
        """
        Welcome..
        1.) /mnt/Movies
        2.) /mnt/ps2
        """
    )

    if ch == "1" or ch == "2":
        for folder in table['folders']:  
            files=account.listContents(folder["id"])['files']

        for file in files:
            if file['play_video']==True:
                dl=account.fetchFile(file['folder_file_id'])
                print(dl)
                os.system("wget -c '" + dl['url'] + "' -O '" + DOWNLOADLOCATION[ch] + dl['name'] + "' --no-check-certificate")
            account.deleteFolder(folder["id"])
