import os
import requests
import py7zr
import shutil

cDir = os.getcwd()
fileName = 'server.7z'
artUrl = 'https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/./5985-01604ae5ce4cb52f467d4b395bf26c35656e6bb7/server.7z'
fullPath = cDir+'/'+fileName
artPath = 'artifacts'
outPath = '../artifacts/'

def download(url, path, chunk_size=128):
    r = requests.get(url, stream=True)
    with open(path, 'wb') as fd:
        for chunk in r.iter_content(chunk_size=chunk_size):
            fd.write(chunk)
    return True

def unpack(path, dpath):
    archive = py7zr.SevenZipFile(path, mode='r')
    archive.extractall(path=artPath)
    archive.close()

def run():
    try:
        shutil.rmtree(outPath)
    except:
        print('Non existant')

    try:
        os.rmdir(artPath)
    except:
        print('Non existant')

    try:
        os.mkdir(artPath)
    except:
        print('existant')

    done = download(artUrl, fileName)

    if done:
        unpack(fullPath, 'out')
        os.remove(fileName)
        shutil.move(artPath, '../')
        print('Builded successfully!')
    else:
        print('There was an error')

    
run()
