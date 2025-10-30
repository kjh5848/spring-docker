# 1. OpenJDK 21 기반 이미지를 사용
# - 이 이미지는 이미 Java 21(JDK)이 설치된 리눅스 환경입니다.
# - 즉, 컨테이너 내부에서 Java 코드를 바로 실행할 수 있습니다.
FROM openjdk:21-jdk-slim


# 2. 컨테이너 내부 작업 디렉터리를 /app으로 설정
# - 이후 명령어(COPY, RUN 등)는 모두 /app 디렉터리에서 실행됩니다.
# - 마치 cd /app 명령을 미리 수행한 것과 동일한 효과입니다.
WORKDIR /app


# 3. 현재 로컬 프로젝트의 모든 파일을 컨테이너 내부 /app 폴더로 복사
# - COPY <로컬 경로> <컨테이너 경로>
# - 점(.)은 “현재 폴더”를 의미합니다.
# - Gradle 설정 파일, 소스 코드(src/), build.gradle 등이 모두 복사됩니다.
COPY . .


# 4. gradlew(Gradle Wrapper) 파일에 실행 권한을 부여
# - 리눅스에서는 실행 파일에 권한이 없으면 “Permission denied” 오류가 발생합니다.
# - chmod +x 명령으로 실행 권한을 추가합니다.
RUN chmod +x ./gradlew


# 5. Gradle을 이용해 Spring Boot 프로젝트를 jar 파일로 빌드
# - clean : 기존 빌드 결과물을 삭제
# - bootJar : Spring Boot용 실행 가능한 jar(app.jar) 생성
# - --no-daemon : Docker 컨테이너 안에서는 백그라운드 데몬이 필요 없으므로 비활성화
# - 이 명령이 성공하면 build/libs 폴더 안에 app.jar가 만들어집니다.
RUN ./gradlew clean bootJar --no-daemon


# 6. 컨테이너 실행 시 Spring Boot 애플리케이션 실행
# - CMD는 컨테이너가 “실행될 때” 마지막으로 수행되는 명령입니다.
# - java -jar 명령으로 build/libs/app.jar를 실행합니다.
# - 즉, 이 컨테이너가 켜지면 자동으로 Spring Boot 서버가 구동됩니다.
CMD ["java", "-jar", "build/libs/spring-doker-0.0.1-SNAPSHOT.jar"]