#!/usr/bin/env bash
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian bionic contrib"
# // debian buster and ubuntu boinc shares the repository, thus the name "bionic"
