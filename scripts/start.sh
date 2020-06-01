#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh

REPOSITORY=/home/ec2-user/app/step3
PROJECT_NAME=spring-aws-sample

echo "> 빌드 파일 복사"
cp $REPOSITORY/zip/*.jar $REPOSITORY/

echo "새어플리케이션 배포"
JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

echo "> Jar name : $JAR_NAME"
echo "> Jar name 에 실행권한 추가"

chmod +x $JAR_NAME

IDLE_PROFILE=$(find_idle_profile)

echo "> Jar 실행"
nohup java -jar -Dspring.config.location=classpath:/application.yml,/home/ec2-user/app/application-$IDLE_PROFILE.yml,/home/ec2-user/app/application-oauth.properties,/home/ec2-user/app/application-real-db.properties -Dspring.profiles.active=$IDLE_PROFILE $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &
