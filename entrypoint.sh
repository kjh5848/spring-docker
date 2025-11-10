#!/bin/bash


# 1. Git 리포지토리 주소 설정
REPO_URL=${SPRING_APP_REPO:-"https://github.com/busanuv/blog-last.git"}

# 2. 기존 폴더 삭제 후 새로 클론
git clone "$REPO_URL"

# 3. 프로젝트 디렉터리로 이동
cd spring-app

# 4. gradlew 실행 권한 부여
chmod +x ./gradlew

# 5. Gradle 빌드 (테스트 생략)
./gradlew clean build

# 6. jar 파일 실행 권한 부여
chmod +x build/libs/*.jar

# 7. Spring Boot 실행 (docker 프로필 활성화)
exec java -jar -Dspring.profiles.active=docker build/libs/*.jar