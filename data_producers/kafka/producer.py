import json, random, time, uuid
from kafka import KafkaProducer
producer = KafkaProducer(bootstrap_servers="localhost:9092",
                         value_serializer=lambda v: json.dumps(v).encode())
while True:
    event = {"id": str(uuid.uuid4()), "ts": int(time.time()), "value": random.random()}
    producer.send("orders", event)
    time.sleep(0.5)
