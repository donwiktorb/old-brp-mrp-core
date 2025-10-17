import os
import shutil
path = os.path.abspath("../")
artifacts = path+"/artifacts"
data = path+"/data"
cache = path+"/cache"
try:
    shutil.rmtree(cache)
except:
    print("Cache non existant")
cmd = "cd ../ && {0}/FXServer.exe +exec {1}/dwb.cfg".format(artifacts,data)
os.system(cmd)