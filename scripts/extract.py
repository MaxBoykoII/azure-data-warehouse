import argparse

parser = argparse.ArgumentParser()
parser.add_argument("url", help="Specifies the url for the project files")

args = parser.parse_args()

print(args.url)