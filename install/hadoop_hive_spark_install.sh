#!/usr/bin/bash

set -e

HADOOP_CONF=/opt/hadoop/etc/hadoop
SPARK_VERSION=3.5.2
JAVA_VERSION=1.8
SCALA_VERSIOn=2.11.12
HADOOP_VERSION=3.4.0
HIVE_VERSION=4.0.0
POSTGRESQL_JAR_VERSION=42.7.4

check_and_install_java() {
  echo "Java check and installation started"
  java_version=$(java -version 2>&1)
  if [[ $java_version =~ ([0-9]+\.[0-9]+) ]]; then version=${BASH_REMATCH[1]}
    echo $version
    if (( $(echo "$version == $JAVA_VERSION" | bc -l) )); then
      echo "Java version is $version, which is valid for hadoop"
    else
      echo "Java version is $version, which is not valid for hadoop"
      echo "Removing existing Java"
      sudo apt remove --purge java* -y
      echo "Installing Java 8"
      sudo apt-get install openjdk-8-jdk openjdk-8-jre -y
    fi
  else 
    "Java version not identified, so installing Java 8"
    sudo apt-get install openjdk-8-jdk openjdk-8-jre -y
  fi
  echo "Java check and installation completed"
}

check_and_install_scala() {
  echo "Scala check and installation started"
  scala_version=$(scala -version 2>&1)
  if [[ $scala_version =~ ([0-9]+\.[0-9]+\.[0-9]+) ]]; then version=${BASH_REMATCH[1]}
    echo $version
    if (( $(echo "$version == $SCALA_VERSION" | bc -l) )); then
      echo "Scala version is $version, which is valid for hadoop"
    else:
      echo "Scala version is $version, which is not valid for hadoop"
      ehoc "Removing existing scala"
      sudo apt remomove --purge scala* -y
      echo "Installing Scala $SCALA_VERSION"
      wget -P /tmp https://downloads.lightbend.com/scala/$SCALA_VERSION/scala-"$SCALA_VERSION".deb
      sudo dpkg -i /tmp/scala-"$SCALA_VERSION".deb
      sudo apt-get install -f
    fi
  else
    "Scala version not identified, so install Scala $SCALA_VERSION"
    wget -P /tmp https://downloads.lightbend.com/scala/"$SCALA_VERSION"/scala-"$SCALA_VERSION".deb
    sudo dpkg -i /tmp/scala-"$SCALA_VERSION".deb
    sudo apt-get install -f
  fi
  echo "Scala check and installation completed"
}

add_hadoop_core_site_xml() {
  echo "Adding core-site.xml for hadoop"
  if [ -f $HADOOP_CONF/core-site.xml ]; then rm -rf $HADOOP_CONF/core-site.xml; fi
  echo '
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
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
' >> $HADOOP_CONF/core-site.xml
}

add_hadoop_yarn_site_xml() {
  echo "Adding yarn-site.xml for hadoop"
  if [ -f $HADOOP_CONF/yarn-site.xml ]; then rm -rf $HADOOP_CONF/yarn-site.xml; fi
  echo '
<?xml version="1.0"?>
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
' >> $HADOOP_CONF/yarn-site.xml
}

add_hadoop_hdfs_site_xml() {
  echo "Adding hdfs-site.xml for hadoop"
  if [ -f $HADOOP_CONF/hdfs-site.xml ]; then rm -rf $HADOOP_CONF/hive-site.xml; fi
  echo '
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
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
    <value>file:///opt/data/hadoop/hdfs/namenode</value>
  </property>
  <!-- Directories where the DataNode stores blocks -->
  <property>
    <name>dfs.datanode.data.dir</name>
    <value>file:///opt/data/hadoop/hdfs/datanode</value>
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
' >> $HADOOP_CONF/hdfs-site.xml
}

# TODO: automate this function
hadoop_install() {
  echo "hadoop install, should be manual as I have no clue how to exeucte queries in a different userspace"
  sudo apt-get update && sudo apt dist-upgrade && sudo apt full-upgrade -y
  sudo apt-get install ssh openssh-client openssh-server
  # TODO: maybe we don't need a new user for hadoop
  sudo adduser hadoop && su - hadoop # password : hadoop
  ssh-keygen -t rsa
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
  chmod 640 ~/.ssh/authorized_keys
  # check ssh to localhost
  ssh localhost
  exit
  exit
  sudo chmod 7777 -R /opt
  su - hadoop
  wget https://dlcdn.apache.org/hadoop/common/hadoop-"$HADOOP_VERSION"/hadoop-"$HADOOP_VERSION".tar.gz
  tar -xvzf hadoop-"$HADOOP_VERSION".tar.gz && rm hadoop-"$HADOOP_VERSION".tar.gz && mv hadoop-"$HADOOP_VERSION" /opt/hadoop
  sudo chmod 7777 -R /opt
  exit
  export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 >> /opt/hadoop/etc/hadoop/hadoop-env.sh
  ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && chmod 700 ~/.ssh
  add_hadoop_core_site_xml
  add_hadoop_yarn_site_xml
  echo "Format namenode"
  hdfs namenode -format
  start-dfs.sh && start-yarn.sh
  echo "Please check localhost:9870 for hadoop dfs"
  echo "Please check localhost:8088 for hadoop yarn cluster"
}

# TODO: automate this function
postgres_install() {
  echo "postgres install, should be manual as I have no clue how to exeucte queries in a different userspace"
  sudo apt-get update && sudo apt dist-upgrade && sudo apt full-upgrade -y
  sudo apt-get install postgresql postgresql-contrib
  sudo -i -u postgres
  createuser hiveuser -P # password : hive
  createdb -O hiveuser metastore_db
  exit
  sudo echo "local   all             hiveuser                                md5" >> /etc/postgresql/12/main/pg_hba.conf
  sudo systemctl restart postgresql
}

postgres_jar_install() {
  wget -P /tmp https://jdbc.postgresql.org/download/postgresql-"$POSTGRESQL_JAR_VERSION".jar
  mv /tmp/postgresql-"$POSTGRESQL_JAR_VERSION".jar $HIVE_HOME/lib/
}

add_hive_hive_site_xml() {
  echo "Adding hive-site.xml for hive"
  if [ -f $HIVE_HOME/conf/hive-site.xml ]; then rm -rf $HIVE_HOME/conf/hive-site.xml; fi
  echo '
<?xml version="1.0"?>
<configuration>
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
    <value>hive</value>
    <description>Password to use against metastore database</description>
  </property>
  <property>
    <name>datanucleus.schema.autoCreateAll</name>
    <value>true</value>
    <description>Auto-create the schema on startup</description>
  </property>
</configuration>
' >> $HIVE_HOME/conf/hive-site.xml
}

hive_install() {
  postgres_install
  wget https://dlcdn.apache.org/hive/hive-"$HIVE_VERSION"/apache-hive-"$HIVE_VERSION"-bin.tar.gz
  tar -xvf apache-hive-"$HIVE_VERSION"-bin.tar.gz && rm apache-hive-"$HIVE_VERSION"-bin.tar.gz && mv apache-hive-"$HIVE_VERSION"-bin /opt/hive
  sudo chmod 7777 -R /opt
  postgres_jar_install
  add_hive_hive_site_xml
  add_hadoop_hdfs_site_xml
  sudo chmod 7777 -R /opt
  schematool -dbType postgres -initschema
  nohup hive --service metastore >> /opt/hive_logs/metastore.log &
  nohup hive --service hiveserver2 >> /opt/hive_logs/hiveserver2.log &
}

spark_pyspark_install() {
  echo "Spark installation started"
  if [ -d /opt/spark ]; then rm -rf /opt/spark; fi
  wget -P /tmp https://dlcdn.apache.org/spark/spark-"$SPARK_VERSION"/spark-"$SPARK_VERSION"-bin-hadoop3.tgz
  tar -xvzf /tmp/spark-"$SPARK_VERSION"-bin-hadoop3.tgz
  sudo chmod 7777 -R /opt
  mv spark-"$SPARK_VERSION"-bin-hadoop3 /opt/spark
  sudo chmod 7777 -R /opt
  echo "Spark installation completed"
  echo "PySpark installation started"
  if [ $(pip3 list | grep pyspark | wc -l) == 1 ]; then pip3 uninstall -y pyspark; fi
  pip3 install pyspark
  echo "PySpark installation completed"
}

check_and_install_java
check_and_install_scala
hadoop_install
hive_install
spark_pyspark_install
