sudo apt upgrade -y
    -y java -version
    scala -version
    apt install python3 python3-pip -y python3 –version
    website. cd ~ wget
    https://dlcdn.apache.org/spark/spark-4.0.1/spark-4.0.1-bin-hadoop3.tgz
    tar xvf spark-4.0.1-bin-hadoop3.tgz
    location. sudo su cd /home//Downloads/ mv spark-4.0.1-bin-hadoop3
    /usr/local/spark
    Spark paths. nano ~/.bashrc
Add the following lines at the end: export
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 export
SCALA_HOME=/usr/share/scala export SPARK_HOME=/usr/local/spark export
PATH=PATH:SPARK_HOME/bin:$SPARK_HOME/sbin
Save the file: Ctrl+O, Enter, then Ctrl+X Apply the changes: source
~/.bashrc
8.  (Optional) Install and configure Hadoop (for Spark with HDFS/YARN) •
    If you want to run Spark on top of HDFS, install and configure
    Hadoop. • Otherwise you can use Spark in standalone mode. Refer to
    Hadoop installation steps (Hadoop 3.3.6).

    –version OR ls /usr/local/spark (List Spark directory.)
10. Start Spark (Interactive Shell) Run Spark shell (Scala):
    /usr/local/spark/bin/spark-shell
For PySpark (Python): /usr/local/spark/bin/pyspark
11. Test Spark jobs (Basic Operations) Load a sample text file and run
    commands in spark-shell.
Start Spark shell: /usr/local/spark/bin/spark-shell
In the Spark shell (>>>): val textFile = sc.textFile(“sample.txt”)
textFile.count() textFile.take(5)
Counts the number of lines in the file and displays the first 5 lines.

12. Working with DataFrames (Example) Load a CSV file and perform basic
    operations. val df = spark.read.csv(“data.csv”, header = true,
    inferSchema = true) df.show() df.printSchema()
    df.select(“column_name”).show()
Displays data and schema information.
13. Exit Spark shell To quit the Spark shell session: :quit
This will stop the Spark shell and show shutdown logs.

Hadoop
HADOOP INSTALLATION ON UBUNTU VM
STEP 1: Update Ubuntu and install prerequisites
sudo apt update sudo apt install openjdk-11-jdk ssh rsync -y
Check Java: java -version javac -version
Notes: - apt update refreshes the package list. - apt install installs
Java, SSH and rsync.
STEP 2: Configure SSH for localhost
Hadoop uses SSH to start services, even on a single machine.
sudo systemctl enable –now ssh ssh-keygen -t rsa -P “” -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys chmod 600
~/.ssh/authorized_keys ssh localhost
If prompted to trust the host, type yes. To exit the SSH session: exit
STEP 3: Download and extract Hadood
cd ~ wget
https://archive.apache.org/dist/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
tar -xzf hadoop-3.3.6.tar.gz mv hadoop-3.3.6 hadoop
Check the extracted directory: ls ~/hadoop
STEP 4: Set environment variables
Open the Bash configuration file: nano ~/.bashrc
Add these lines at the bottom:
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 export
HADOOP_HOME=HOME/hadoopexportHADOOP_(C)ONF_(D)IR=HADOOP_HOME/etc/hadoop
export PATH=PATH:HADOOP_HOME/bin:$HADOOP_HOME/sbi
Save in Nano: Ctrl+O, Enter, then Ctrl+X
Apply the changes: source ~/.bashr
Set Java’s location in Hadoop’s environment file: nano
$HADOOP_HOME/etc/hadoop/hadoop-env.s
Add or update this line: export
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
Save and exit.
Verify: echo $JAVA_HOME echo $HADOOP_HOME hadoop version
STEP 5: Configure Hadoop XML files
Hadoop uses XML files to determine how its services work.
A. Configure core-site.xml
Open file: nano $HADOOP_HOME/etc/hadoop/core-site.xml
Inside the element, add:
fs.defaultFS hdfs://localhost:9000
B. Configure hdfs-site.xml
Open file: nano $HADOOP_HOME/etc/hadoop/hdfs-site.xml
Add these properties inside :
dfs.replication 1 dfs.namenode.name.dir
file:///home/YOUR_USERNAME/hadoopdata/namenode dfs.datanode.data.dir
file:///home/YOUR_USERNAME/hadoopdata/datanode
Replace YOUR_USERNAME with your actual Ubuntu username. Find your
username using: whoami
C. Configure mapred-site.xml
Open file: nano $HADOOP_HOME/etc/hadoop/mapred-site.xml
Add inside :
mapreduce.framework.name yarn
D. Configure yarn-site.xml
Open file: nano $HADOOP_HOME/etc/hadoop/yarn-site.xml
Add inside :
yarn.nodemanager.aux-services mapreduce_shuffle
For each XML file, keep the structure:
… add properties …
Do not remove the closing tag.
SEP 6: Format the NameNod
hdfs namenode -format
Initializes HDFS metadata. Format only once on a fresh installation.
STEP 7: Start Hadoop services
Start HDFS: start-dfs.sh
Start YARN: start-yarn.sh
Check Java processes: jps
You should see: NameNode, DataNode, SecondaryNameNode, ResourceManager,
NodeManager.
STEP 8: Test HDFS
Create a directory: hdfs dfs -mkdir -p /user/$USER/input
Create a sample file: echo “Hadoop is a distributed processing
framework” > sample.txt
Upload to HDFS: hdfs dfs -put sample.txt /user/$USER/input/
List files: hdfs dfs -ls /user/$USER/input
Display file contents: hdfs dfs -cat /user/$USER/input/sample.txt
If the file appears correctly, HDFS is working.
STEP 9: Stop Hadoop services
Stop YARN: stop-yarn.sh
Stop HDFS: stop-dfs.sh
Open MPI and MPI
1.  Update package list sudo apt update
2.  Install MPI and Python tools sudo apt install mpich python3-pip
    python3-dev -y
3.  Install mpi4py python3 -m pip install mpi4py
If pip blocks installation in a system-managed environment, create and
activate a virtual environment, then install mpi4py inside it.
4.  Create the MPI Python program nano mpi_example.py
Enter the following code:
from mpi4py import MPI
comm = MPI.COMM_WORLD rank = comm.Get_rank() size = comm.Get_size()
print(f”Hello from process {rank} of {size}“)
Save and exit the editor.
5.  Run the MPI program mpirun -np 4 python3 mpi_example.py
Expected output (the order may vary): Hello from process 0 of 4 Hello
from process 1 of 4 Hello from process 2 of 4 Hello from process 3 of 4
Explanation: - MPI starts multiple processes. - Each process gets a
unique rank. - Get_size() returns the total number of processes. -
Output order can vary because processes run in parallel
PART B: OPENMP (SHARED-MEMORY PARALLELISM)
1.  Install GCC build tools sudo apt update sudo apt install
    build-essential -y
2.  Create the C program nano hello.c
Enter the following code:
#include <stdio.h> #include <omp.h>
int main(void) { #pragma omp parallel { int thread_id =
omp_get_thread_num(); printf(“Hello from thread %d\n”, thread_id); }
return 0; }
Save and exit the editor.
3.  Compile the program gcc -fopenmp hello.c -o hello
4.  Run the program ./hello
