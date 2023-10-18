import os

def main():
    for root, dirs, files in os.walk("/Users/darrelldefreitas/code/bids-data", topdown=True):

        print(root)
        print(files)

print("START")
main()