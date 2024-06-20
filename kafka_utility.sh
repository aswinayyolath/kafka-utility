#!/bin/bash

# Kafka utility script for managing Kafka topics and consumer groups

KAFKA_BIN_DIR="/Users/aswina/Downloads/kafka_2.13-3.7.0/bin"
KAFKA_BROKER="localhost:9092"


# Colors for echo statements
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

function create_topic() {
  local topic_name=$1
  local partitions=$2
  local replication_factor=$3

  if "$KAFKA_BIN_DIR/kafka-topics.sh" --create \
    --bootstrap-server "$KAFKA_BROKER" \
    --replication-factor "$replication_factor" \
    --partitions "$partitions" \
    --topic "$topic_name"; then
    echo -e "${GREEN}Topic \"$topic_name\" created with replication factor $replication_factor and partitions $partitions.${NC}"
  else
    echo -e "${RED}Failed to create topic \"$topic_name\".${NC}"
  fi
}

function list_topics() {
  echo -e "${YELLOW}Listing all topics...${NC}"
  "$KAFKA_BIN_DIR/kafka-topics.sh" --list --bootstrap-server "$KAFKA_BROKER"
}

function delete_topic() {
  local topic_name=$1

  if "$KAFKA_BIN_DIR/kafka-topics.sh" --delete --bootstrap-server "$KAFKA_BROKER" --topic "$topic_name"; then
    echo -e "${GREEN}Topic \"$topic_name\" marked for deletion.${NC}"
  else
    echo -e "${RED}Failed to mark topic \"$topic_name\" for deletion.${NC}"
  fi
}

function describe_topic() {
  local topic_name=$1

  echo -e "${YELLOW}Describing topic \"$topic_name\"...${NC}"
  "$KAFKA_BIN_DIR/kafka-topics.sh" --describe --bootstrap-server "$KAFKA_BROKER" --topic "$topic_name"
}

function describe_consumer_group() {
  local group_name=$1

  echo -e "${YELLOW}Describing consumer group \"$group_name\"...${NC}"
  "$KAFKA_BIN_DIR/kafka-consumer-groups.sh" --describe --bootstrap-server "$KAFKA_BROKER" --group "$group_name"
}

function list_consumer_groups() {
  echo -e "${YELLOW}Listing all consumer groups...${NC}"
  "$KAFKA_BIN_DIR/kafka-consumer-groups.sh" --list --bootstrap-server "$KAFKA_BROKER"
}

function reset_consumer_group_offsets() {
  local group_name=$1
  local topic_name=$2
  local offset_reset_policy=$3  # earliest, latest, or none

  if "$KAFKA_BIN_DIR/kafka-consumer-groups.sh" --bootstrap-server "$KAFKA_BROKER" --group "$group_name" --topic "$topic_name" --reset-offsets --to-"$offset_reset_policy" --execute; then
    echo -e "${GREEN}Offsets for consumer group \"$group_name\" on topic \"$topic_name\" reset to $offset_reset_policy.${NC}"
  else
    echo -e "${RED}Failed to reset offsets for consumer group \"$group_name\" on topic \"$topic_name\".${NC}"
  fi
}

function create_consumer_group() {
  local group_name=$1
  local topic_name=$2

  # Start a dummy consumer to create the group
  "$KAFKA_BIN_DIR/kafka-console-consumer.sh" --bootstrap-server "$KAFKA_BROKER" --topic "$topic_name" --group "$group_name" --timeout-ms 1000 2>/dev/null

  # Check if the consumer group was created
  if "$KAFKA_BIN_DIR/kafka-consumer-groups.sh" --list --bootstrap-server "$KAFKA_BROKER" | grep -q "$group_name"; then
    echo -e "${GREEN}Consumer group \"$group_name\" created and subscribed to topic \"$topic_name\".${NC}"
  else
    echo -e "${RED}Failed to create consumer group \"$group_name\" for topic \"$topic_name\".${NC}"
  fi
}

case $1 in
  create-topic)
    create_topic "$2" "$3" "$4"
    ;;
  list-topics)
    list_topics
    ;;
  delete-topic)
    delete_topic "$2"
    ;;
  describe-topic)
    describe_topic "$2"
    ;;
  describe-consumer-group)
    describe_consumer_group "$2"
    ;;
  list-consumer-groups)
    list_consumer_groups
    ;;
  reset-consumer-group-offsets)
    reset_consumer_group_offsets "$2" "$3" "$4"
    ;;
  create-consumer-group)
    create_consumer_group "$2" "$3"
    ;;
  *)
    echo -e "${RED}Usage: $0 {create-topic|list-topics|delete-topic|describe-topic|describe-consumer-group|list-consumer-groups|reset-consumer-group-offsets|create-consumer-group} [arguments...]${NC}"
    ;;
esac
