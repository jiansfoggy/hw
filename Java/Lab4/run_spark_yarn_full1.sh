#!/bin/bash

# Run SSSP using Yarn

# Set names of files for input and output.
#  Input file is already on HDFS
#  Output directory will be copied back from HDFS

############
# Step One #
############
INPUT_FILE='hdfs:///Public/data/Lab4Full'
# INPUT_FILE='hdfs:///Public/data/Lab4Short'

OUTPUT_DIR="out_yarn_f1"

# Create HDFS directory path same as current directory
hadoop fs -mkdir -p "hdfs://$PWD"

# Remove any old copies of output directory on HDFS and Linux FS
hadoop fs -rm -f -r "hdfs://$PWD/$OUTPUT_DIR"
rm -rf "./$OUTPUT_DIR"

# Run SSSP job
spark-submit \
    --master yarn \
    --deploy-mode cluster \
    --name SSSP \
    --num-executors 4 \
    --class SSSP \
    ./jar/SSSP.jar yarn "$INPUT_FILE" "hdfs://$PWD/$OUTPUT_DIR" "1"

# Save spark-submit exit code
spark_exit=$?

# Copy result from HDFS to Linux FS
if [[ $spark_exit -eq 0 ]] ; then
    echo "Copying output from $OUTPUT_DIR"
    hadoop fs -get $PWD/$OUTPUT_DIR .
    exit $?
else
    echo "Spark job failed with status $spark_exit"
    exit $spark_exit
fi
