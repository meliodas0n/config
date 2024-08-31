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
# not working wget https://archive.apache.org/dist/db/derby/db-derby-10.17.1.0/db-derby-10.17.1.0-bin.tar.gz
schematool -initSchema -dbType derby
wget https://archive.apache.org/dist/db/derby/db-derby-10.14.2.0/db-derby-10.14.2.0-bin.tar.gz 


# Start Hive Metastore
hive --service metastore &

# Start HiveServer2
hive --service hiveserver2 &

# Start Beeline and connect to HiveServer2
beeline
!connect jdbc:hive2://localhost:10000 default

# SQL Commands in Beeline
CREATE DATABASE test_db;
USE test_db;

CREATE TABLE employee (
    id INT,
    name STRING,
    age INT,
    department STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

INSERT INTO employee VALUES (1, 'John Doe', 30, 'Engineering');
INSERT INTO employee VALUES (2, 'Jane Smith', 25, 'Marketing');
INSERT INTO employee VALUES (3, 'Mike Johnson', 35, 'Sales');

SELECT * FROM employee;



sudo apt-get update
sudo apt-get install postgresql postgresql-contrib
sudo -i -u postgres
createuser hiveuser -P
createdb -O hiveuser metastore_db
sudo nano /etc/postgresql/12/main/pg_hba.conf
local   all             hiveuser                                md5
sudo systemctl restart postgresql
cp postgresql-42.x.x.jar /path/to/hive/lib/
<property>
    <name>javax.jdo.option.ConnectionURL</name>
    <value>jdbc:postgresql://localhost:5432/metastore_db</value>
    <description>JDBC connect string for a JDBC metastore</description>
</property>

<property>
    <name>javax.jdo.option.ConnectionDriverName</name>
    <value>org.postgresql.Driver</value>
    <description>Driver class name for a JDBC metastore</description>
</property>

<property>
    <name>javax.jdo.option.ConnectionUserName</name>
    <value>hiveuser</value>
    <description>Username to use against metastore database</description>
</property>

<property>
    <name>javax.jdo.option.ConnectionPassword</name>
    <value>your_password</value>
    <description>Password to use against metastore database</description>
</property>

<property>
    <name>datanucleus.schema.autoCreateAll</name>
    <value>true</value>
    <description>Auto-create the schema on startup</description>
</property>
schematool -dbType postgres -initSchema
hive --service metastore


<configuration>
    <!-- Default block size for HDFS files -->
    <property>
        <name>dfs.blocksize</name>
        <value>134217728</value> <!-- 128 MB -->
    </property>
    <!-- Default replication factor for HDFS files -->
    <property>
        <name>dfs.replication</name>
        <value>1</value> <!-- Set to 1 for single-node cluster -->
    </property>
    <!-- Directories where the NameNode stores metadata and edits -->
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>file:///usr/local/hadoop/hdfs/namenode</value>
    </property>
    <!-- Directories where the DataNode stores blocks -->
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>file:///usr/local/hadoop/hdfs/datanode</value>
    </property>
    <!-- Namenode-specific directories for storing secondary Namenode checkpoints -->
    <property>
        <name>dfs.namenode.checkpoint.dir</name>
        <value>file:///usr/local/hadoop/hdfs/namesecondary</value>
    </property>
    <!-- Namenode checkpoint interval (seconds) -->
    <property>
        <name>dfs.namenode.checkpoint.period</name>
        <value>3600</value> <!-- Every hour -->
    </property>
    <!-- Namenode checkpoint size threshold -->
    <property>
        <name>dfs.namenode.checkpoint.txns</name>
        <value>1000000</value> <!-- 1 million transactions -->
    </property>
    <!-- Enable safe mode exit threshold (0.9 means 90% of blocks must be available) -->
    <property>
        <name>dfs.namenode.safemode.threshold-pct</name>
        <value>0.9</value>
    </property>
    <!-- The secondary namenode will perform a checkpoint every 3600 seconds -->
    <property>
        <name>dfs.namenode.checkpoint.period</name>
        <value>3600</value>
    </property>
</configuration>

sudo lsof -i :<port_number>

hdfs dfs -df -h