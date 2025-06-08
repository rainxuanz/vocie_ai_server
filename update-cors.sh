#!/bin/bash

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== CORS 配置修复脚本 ===${NC}"

# 检查是否在正确的目录
if [ ! -f "pom.xml" ]; then
    echo -e "${RED}错误: 请在项目根目录运行此脚本${NC}"
    exit 1
fi

echo -e "${YELLOW}1. 删除旧的 CorsFilter (如果存在)...${NC}"
if [ -f "src/main/java/com/aliyuncs/aui/filter/CorsFilter.java" ]; then
    rm src/main/java/com/aliyuncs/aui/filter/CorsFilter.java
    echo -e "${GREEN}   已删除旧的 CorsFilter${NC}"
else
    echo -e "${GREEN}   旧的 CorsFilter 不存在，跳过${NC}"
fi

echo -e "${YELLOW}2. 清理并重新构建项目...${NC}"
mvn clean package -DskipTests

if [ $? -eq 0 ]; then
    echo -e "${GREEN}   构建成功！${NC}"
else
    echo -e "${RED}   构建失败！请检查错误信息${NC}"
    exit 1
fi

echo -e "${YELLOW}3. 显示启动命令...${NC}"
echo -e "${GREEN}请使用以下命令启动应用:${NC}"
echo -e "${YELLOW}java -jar target/aui-ims-robot-0.0.1-SNAPSHOT.jar${NC}"
echo ""
echo -e "${GREEN}或者如果仍有Bean冲突，使用:${NC}"
echo -e "${YELLOW}java -jar target/aui-ims-robot-0.0.1-SNAPSHOT.jar --spring.main.allow-bean-definition-overriding=true${NC}"
echo ""
echo -e "${GREEN}测试 CORS 的端点:${NC}"
echo -e "${YELLOW}GET  http://your-server:8881/api/test/cors${NC}"
echo -e "${YELLOW}POST http://your-server:8881/api/test/cors${NC}"

echo -e "${GREEN}=== 脚本执行完成 ===${NC}" 