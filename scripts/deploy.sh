#!/bin/bash
REPOSITORY=/home/ec2-user/app/step2
PROJECT_NAME=spring-aws-sample

cd $REPOSITORY/$PROJECT_NAME/

echo "> 빌드 파일 복사"
cp $REPOSITORY/zip/*.jar $REPOSITORY/

echo "> 현재 구동중인 어플리케이션 PID 확인"
CURRENT_PID=$(pgrep -fl ${PROJECT_NAME} | grep jar | awk '{print $1}')
echo "PID : $CURRENT_PID"

if [ -z "$CURRENT_PID" ]; then
    echo "현재 실행중인 어플리케이션이 없습니다."
else
    echo "> kill -15 $CURRENT_PID"
    kill -15 $CURRENT_PID
    sleep 5
fi

echo "새어플리케이션 배포"
JAR_NAME=$(ls -tr $REPOSITORY/ | grep *.jar | tail -n 1)

echo "> Jar name : $JAR_NAME"
echo "> Jar name 에 실행권한 추가"

chmod +x $JAR_NAME

echo "> Jar 실행"
nohup java -jar -Dspring.config.location=classpath:/application.properties,/home/ec2-user/app/application-oauth.properties,/home/ec2-user/app/application-real.properties -Dspring.profiles.active=real $REPOSITORY/$JAR_NAME 2>&1 &