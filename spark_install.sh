#!/usr/bin/bash
set e

echo "SPARK INSTALL STARTED"
echo "INSTALL JAVA & SCALA"
sudo apt-get install openjdk-22-jdk openjdk-22-jre scala -y
echo "JAVA & SCALA INSTALL COMPLETED"
echo "DOWNLOAD APACHE SPARK"

if [ -d ~/Downloads ]; then
  echo "DOWNLOADS DIRECTORY EXISTS"
  echo "DOWNLOADING APACHE SPARK"
  wget https://dlcdn.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz -O ~/Downloads/spark.tgz
  echo "SPARK DOWNLOAD COMPLETED"
else
  echo "DOWNLOADS DIRECTORY DOES NOT EXSIST"
  echo "CREATING DOWNLOADS DIRECTORY"
  mkdir ~/Downloads
  echo "CREATED DOWNLODS DIRECTORY"
  echo "DOWNLOADING APACHE SPARK"
  wget https://dlcdn.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz -O ~/Downloads/spark.tgz
  echo "SPARK DOWNLOAD COMPLETED"
fi

echo "DOWNLOADED APACHE SPARK TO ~/Downloads"
echo "CHANGING TO DOWNLOADS DIRECTORY"
cd ~/Downloads
echo "UNTAR SPARK FOLDER"
tar -xvzf spark.tgz

if [ -d /opt ]; then
  echo "/opt EXSISTS"
  sudo mv spark-3.5.0-bin-hadoop3 /opt/spark
  echo "MOVED SPARK TO /opt/spark"
else
  echo "/opt DOES NOT EXISTS"
  echo "CREATING /opt | ENTER PASSWORD IF ASKED"
  sudo mkdir -p /opt
  echo "/opt CREATED"
  echo "MOVING SPARK TO /opt"
  sudo mv spark-3.5.0-bin-hadoop3 /opt/spark
  echo "MOVED SPARK TO /opt/spark"
fi

echo "INSTALLED SPARK"
echo "INSTALLING PYTHON SPARK API *pyspark*"
pip3 install pyspark
echo "INSTALLED *pyspark*"
echo "DELETING SPARK FROM ~/Downloads"
sudo rm -rf ~/Downloads/spark*
echo "STARTING SPARK"
pyspark
