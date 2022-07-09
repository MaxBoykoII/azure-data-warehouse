import argparse
import requests

parser = argparse.ArgumentParser()
parser.add_argument("url", help="Specifies the url for the project files")

args = parser.parse_args()

# Get the zip file
response = requests.get(args.url)

# Print the status code
print(response.status_code)

# Save the file locally (more about open() in the next lesson)
local_path = f"tmp/data.zip"
with open(local_path, "wb") as f:
    f.write(response.content)
