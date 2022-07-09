import argparse
import requests
import os
import shutil
from zipfile import ZipFile

parser = argparse.ArgumentParser()
parser.add_argument("url", help="Specifies the url for the project files")

args = parser.parse_args()

# Get the zip file
response = requests.get(args.url)

# Print the status code
print(response.status_code)

# Save the file locally
directory = os.path.join(os.getcwd(), "tmp/")
print(directory)
os.mkdir(directory)

local_path = os.path.join(directory, "data.zip")
print(local_path)

with open(local_path, "wb") as f:
    f.write(response.content)


extract_directory = os.path.join(os.getcwd(), "data/")
os.mkdir(extract_directory)


with ZipFile(local_path, mode="r") as f:
    # Get the list of files and print it
    file_names = f.namelist()

    for name in file_names:
        if ".csv" in name:
            print(name)
            extract_path = f.extract(name, path=extract_directory)
            print(extract_path)

source_directory = os.path.join(os.getcwd(), "data/Out")

files = os.listdir(source_directory)

for file in files:
    file_name = os.path.join(source_directory, file)
    shutil.move(file_name, extract_directory)

os.rmdir(source_directory)
