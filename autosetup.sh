#!/bin/env bash
set -e

CONFIG_FOLDER=$HOM/config

echo "Updating the System First"
sudo apt-get update && sudo apt full-upgrade && sudo apt dist-upgrade -y
echo "System upgrade completed"