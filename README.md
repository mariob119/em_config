# What is the em_config for?

The em_config is for automatically installing
all necassary applikations and dependencies
for the energymanager. This also includes
docker, portainer and the docker image for
energymanager. Moreover it also maps all
needed ports and set up everything so that
it will automatically restart and get everything
running automatically.

What is needed:
* A linux image where you are logged in as root user

## How to install
* Set up a linux image
* Enter username and password
* Establish an internet connection (wifi or lan)
* Use `sudo passwd root` for setting the root password
* Log in as root
* Run the command `wget -O - https://raw.githubusercontent.com/mariob119/em_config/main/em_config.sh | bash`

And now you are done! :)
