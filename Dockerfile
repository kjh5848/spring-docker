# 1. OpenJDK 21 기반 이미지를 사용
# - 이 이미지는 이미 Java 21(JDK)이 설치된 리눅스 환경입니다.
# - 즉, 컨테이너 내부에서 Java 코드를 바로 실행할 수 있습니다.
FROM openjdk:21-jdk-slim

RUN apt-get update && apt-get install -y git

# 2. 컨테이너 내부 작업 디렉터리를 /app으로 설정
# - 이후 명령어(COPY, RUN 등)는 모두 /app 디렉터리에서 실행됩니다.
# - 마치 cd /app 명령을 미리 수행한 것과 동일한 효과입니다.
WORKDIR /app


COPY ./entrypoint.sh ./entrypoint.sh


# 5. 실행 권한 부여
RUN chmod +x ./entrypoint.sh

# 6. 컨테이너 시작 시 entrypoint.sh 실행
ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]