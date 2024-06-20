# Kafka Utility Script
This repository contains a utility shell script for managing Kafka topics and consumer groups. The script includes various functions such as creating, listing, deleting, and describing topics and consumer groups, as well as resetting consumer group offsets.

## Prerequisites
- Kafka installed and configured on your machine.
- Shell environment (bash).

## Installation
Clone the Repository:

```bash
git clone https://github.com/aswinayyolath/kafka-utility.git
cd kafka-utility
```

## Update the Script
Open the kafka_utility.sh script and update the KAFKA_BIN_DIR variable with the path to your Kafka bin directory.

```bash
KAFKA_BIN_DIR="/path/to/kafka/bin"
```

### Make the Script Executable

```bash
chmod +x kafka_utility.sh
```

### Usage
Execute the script with the appropriate command and parameters. Below are the available functionalities:

### Create a Topic
Creates a new Kafka topic with the specified number of partitions and replication factor.

```bash
./kafka_utility.sh create-topic <topic_name> <partitions> <replication_factor>
```

Example:

```bash
./kafka_utility.sh create-topic my_topic 1 1
```

### List Topics
Lists all existing Kafka topics.

```bash
./kafka_utility.sh list-topics
```

### Delete a Topic
Marks a Kafka topic for deletion.

```bash
./kafka_utility.sh delete-topic <topic_name>
```

Example:

```bash
./kafka_utility.sh delete-topic my_topic
```

### Describe a Topic
Provides detailed information about a Kafka topic.

```bash
./kafka_utility.sh describe-topic <topic_name>
```

Example:

```bash
./kafka_utility.sh describe-topic my_topic
```

### Describe a Consumer Group
Provides detailed information about a Kafka consumer group.

```bash
./kafka_utility.sh describe-consumer-group <group_name>
```

Example:

```bash
./kafka_utility.sh describe-consumer-group my_group
```

### List Consumer Groups
Lists all existing Kafka consumer groups.

```bash
./kafka_utility.sh list-consumer-groups
```

### Reset Consumer Group Offsets
Resets the offsets for a Kafka consumer group to the specified policy (earliest, latest, or none).

```bash
./kafka_utility.sh reset-consumer-group-offsets <group_name> <topic_name> <offset_reset_policy>
```

Example:

```bash
./kafka_utility.sh reset-consumer-group-offsets my_group my_topic latest
```

### Create a Consumer Group
Creates a Kafka consumer group and subscribes it to a topic.

```bash
./kafka_utility.sh create-consumer-group <group_name> <topic_name>
```

Example:

```bash
./kafka_utility.sh create-consumer-group my_group my_topic
```


### Acknowledgments
This script is inspired by the need to simplify Kafka topic and consumer group management for developers. Thanks to the Kafka community for their valuable resources and documentation.
