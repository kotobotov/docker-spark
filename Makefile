current_version := "2.2.0-hadoop2.8-hive-java8"
build:
	docker build -t kotobotov/spark-base:$(current_version) ./base
	docker build -t kotobotov/spark-master:$(current_version) ./master
	docker build -t kotobotov/spark-worker:$(current_version) ./worker
	docker build -t kotobotov/spark-submit:$(current_version) ./submit

network:
	docker network create spark-net

spark:
	docker-compose -f docker-compose-minimal.yml up -d

down:
	docker-compose -f docker-compose-minimal.yml down
	docker-compose -f docker-compose-spark-app.yml down
	docker network rm spark-net

spark-app:
	docker-compose -f docker-compose-spark-app.yml build
	docker-compose -f docker-compose-spark-app.yml up
