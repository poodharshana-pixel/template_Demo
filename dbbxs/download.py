import dropbox
ACCESS_TOKEN = "YOUR_ACCESS_TOKEN_HERE"
dbx = dropbox.Dropbox(ACCESS_TOKEN)
local_file = "sample.txt"
dropbox_path = "/sample.txt"
with open(local_file, "rb") as file:
    dbx.files_upload(
        file.read(),
        dropbox_path,
        mode=dropbox.files.WriteMode.overwrite
    )
print("File uploaded successfully!")
