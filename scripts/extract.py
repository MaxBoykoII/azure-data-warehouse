import argparse
import requests
import os

parser = argparse.ArgumentParser()
parser.add_argument("url", help="Specifies the url for the project files")

args = parser.parse_args()

# Get the zip file
response = requests.get(args.url)

# Print the status code
print(response.status_code)

# Save the file locally (more about open() in the next lesson)
directory = os.path.join(os.getcwd(), "tmp/")
print(directory)
os.mkdir(directory)

local_path = os.path.join(directory, "data.zip")
print(local_path)

with open(local_path, "wb") as f:
    f.write(response.content)
