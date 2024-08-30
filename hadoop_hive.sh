#!/usr/bin/bash

# hadoop
sudo apt-get update && sudo apt full-upgrade -y && sudo apt install openjdk-8-jdk -y
java -version
sudo apt-get install ssh

sudo adduser hadoop && su - hadoop
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys   
chmod 640 ~/.ssh/authorized_keys
ssh localhost

su - hadoop
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.4.0/hadoop-3.4.0.tar.gz
tar -xvzf hadoop-3.4.0.tar.gz && rm hadoop-3.4.0.tar.gz && mv hadoop-3.4.0 /opt/hadoop

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export HADOOP_HOME=/home/hadoop/hadoop
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 >> /opt/hadoop/etc/hadoop/hadoop-env.sh

sudo apt-get update && sudo apt full-upgrade && sudo apt install openssh-client openssh-server
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && chmod 700 ~/.ssh

# core-site.xml
<configuration>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://localhost:9000</value>
  </property>
  <property>
    <name>dfs.replication</name>
    <value>1</value>
  </property>
  <property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
  </property>
  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property>
  <property>
    <name>yarn.nodemanager.aux-services.mapreduce_shuffle.class</name>
    <value>org.apache.hadoop.mapred.ShuffleHandler</value>
  </property>
</configuration>

# yarn-site.xml
<configuration>
  <property>
    <name>yarn.resourcemanager.hostname</name>
    <value>localhost</value>
  </property>
  <property>
    <name>yarn.resourcemanager.address</name>
    <value>localhost:8032</value>
  </property>
  <property>
    <name>yarn.resourcemanager.scheduler.address</name>
    <value>localhost:8030</value>
  </property>
  <property>
    <name>yarn.resourcemanager.resource-tracker.address</name>
    <value>localhost:8025</value>
  </property>
  <property>
    <name>yarn.resourcemanager.admin.address</name>
    <value>localhost:8141</value>
  </property>
  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property>
  <property>
    <name>yarn.nodemanager.aux-services.mapreduce_shuffle.class</name>
    <value>org.apache.hadoop.mapred.ShuffleHandler</value>
  </property>
</configuration>

# start namenode and yarn resource manager
start-dfs.sh && start-yarn.sh
# check if namenode and resource manager are on or off
jps
# hadoop -> http://localhost:9870
# yarn -> http://localhost:8088

# hive
wget https://dlcdn.apache.org/hive/hive-4.0.0/apache-hive-4.0.0-bin.tar.gz
tar -xvf apache-hive-4.0.0-bin.tar.gz && rm apache-hive-4.0.0-bin.tar.gz && mv apache-hive-4.0.0-bin /opt/hive

export HIVE_HOME=/opt/hive
export PATH=$HIVE_HOME/bin:$PATH

# $HIVE_HOME/hive-site.xml
<configuration>
  <property>
    <name>javax.jdo.option.ConnectionURL</name>
    <value>jdbc:derby:memory:hive_db;create=true</value>
  </property>
  <property>
    <name>javax.jdo.option.ConnectionDriverName</name>
    <value>org.apache.derby.jdbc.EmbeddedDriver</value>
  </property>
  <property>
    <name>javax.jdo.option.ConnectionUserName</name>
    <value>sa</value>
  </property>
  <property>
    <name>javax.jdo.option.ConnectionPassword</name>
    <value></value>
  </property>
</configuration>


# Format the namenode
hdfs namenode -format

nohup hive --service metastore &
nohup hive --service hiveserver2 &



http://localhost:9870/
http://localhost:8088/cluster


# derby
wget https://archive.apache.org/dist/db/derby/db-derby-10.17.1.0/db-derby-10.17.1.0-bin.tar.gz


schematool -initSchema -dbType derby