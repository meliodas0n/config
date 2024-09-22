#!/usr/bin/bash
set -e

if [ $@ ]; then distro=$1; else distro=ubuntu; fi
echo "Distro : $distro"

install_java_scala() {
  echo "java & scala installation started"
  if [ $distro = "ubuntu" ]
  then
    sudo apt-get install openjdk-8-jdk openjdk-8-jre scala -y
  elif [ $distro = "arch" ]
  then
    sudo pacman -Sy jre-openjdk jdk-openjdk
    yay -Sy scala
  else
    echo "No distro mentioned!, Quitting!!"
    exit 1
  fi
  echo "java & scala installation completed"
}

install_spark_pyspark() {
  echo "spark & pyspark installation started"
  if [ -d ~/Downloads ]; then
    wget https://dlcdn.apache.org/spark/spark-3.5.2/spark-3.5.2-bin-hadoop3.tgz -O ~/Downloads/spark.tgz
  else
    mkdir ~/Downloads
    wget https://dlcdn.apache.org/spark/spark-3.5.2/spark-3.5.2-bin-hadoop3.tgz -O ~/Downloads/spark.tgz
  fi
  cd ~/Downloads
  tar -xvzf spark.tgz
  if [ -d /opt ]; then
    sudo mv spark-3.5.2-bin-hadoop3 /opt/spark
  else
    sudo mkdir -p /opt
    sudo mv spark-3.5.2-bin-hadoop3 /opt/spark
  fi
  pip3 install pyspark
  sudo rm -rf ~/Downloads/spark*
  echo "spark & pyspark installation completed"
}

install_java_scala
install_spark_pyspark
