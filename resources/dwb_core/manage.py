import os
import sys
import json
import pprint


def scanTop():
    topResources = {}
    for folder, subfolders, files in os.walk("./"):
        for file in files:
            if ".lua" in file and "config" not in file:
                with open(folder + "/" + file, "r", encoding="UTF-8") as f:
                    lines = f.readlines()
                    topResources[folder + "/" + file] = len(lines)

    topResources = sorted(topResources.items(), key=lambda x: x[1], reverse=False)
    pprint.pp(topResources)


def main():
    action = sys.argv[1]
    if action == "--top":
        scanTop()


if __name__ == "__main__":
    main()
