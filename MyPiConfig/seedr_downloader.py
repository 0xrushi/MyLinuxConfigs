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
    response = account.addTorrent(magnetLink=ch)
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
