# remote-transfer
a simple bash script to transfer file or directory from/to server and your host
# How to use

## In general
	./transfer.b -[send/get] [file/directory path] [file/directory path]
## For sending file or directory
	./transfer.b -send <file/directory path to send from your machine> <directory path to send to server>
## For retrieving a file or directory
	./transfer.b -get <directory/file path to retrieve from server> <directory path to your machine>
  
It will ask for configuration for the first time only about server user name and ip
