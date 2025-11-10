# 1. OpenJDK 21 기반 이미지를 사용
# - 이 이미지는 Java 21(JDK)가 이미 설치된 경량 리눅스 환경(slim)입니다.
# - JDK 설치 과정이 생략되어 빌드 속도가 빠르고 이미지 용량이 작습니다.
FROM eclipse-temurin:21-jdk


# 2. 필수 패키지 설치 (예: git)
# - apt-get update: 패키지 목록을 최신으로 갱신합니다.
# - apt-get install -y git: git을 설치하며, -y 옵션으로 자동 확인을 수행합니다.
RUN apt-get update && apt-get install -y git

# 3. 작업 디렉터리 설정
# - 이후 실행되는 명령어의 기준 경로를 /app으로 고정합니다.
# - 마치 “cd /app” 명령을 미리 수행한 것과 같습니다.
WORKDIR /app

# 4. 로컬 entrypoint.sh 파일을 컨테이너 내부로 복사
# - COPY <호스트경로> <컨테이너경로>
# - 이 예시에서는 현재 폴더의 entrypoint.sh를 컨테이너 /app/entrypoint.sh로 복사합니다.
COPY ./entrypoint.sh ./entrypoint.sh

# 5. entrypoint.sh에 실행 권한 추가
# - chmod +x 명령어로 해당 스크립트를 실행 가능하게 만듭니다.
RUN chmod +x ./entrypoint.sh

# 6. 컨테이너 시작 시 entrypoint.sh 자동 실행
# - ENTRYPOINT는 컨테이너가 실행될 때 반드시 호출되는 명령어를 정의합니다.
# - /bin/bash를 통해 쉘 환경에서 entrypoint.sh 스크립트를 실행합니다.
ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]