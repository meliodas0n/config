#!/bin/bash

echo "Updating the System First"
sudo apt-get update && sudo apt full-upgrade -y

sudo apt-get install python3 python3-pip ruby-full 

cd $HOME/config