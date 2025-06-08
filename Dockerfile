# 使用官方 OpenJDK 8 镜像作为基础镜像
FROM openjdk:8-jdk-alpine

# 设置工作目录
WORKDIR /app

# 复制 Maven 构建产物
COPY target/aui-ims-robot-0.0.1-SNAPSHOT.jar app.jar

# 暴露应用端口
EXPOSE 8881

# 设置 JVM 参数和环境变量
ENV JAVA_OPTS="-Xms512m -Xmx1024m -Djava.security.egd=file:/dev/./urandom"

# 启动应用
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"] 