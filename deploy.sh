#!/bin/bash

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}开始构建和部署 AUI IMS Robot 服务...${NC}"

# 1. 清理之前的构建
echo -e "${YELLOW}清理之前的构建...${NC}"
mvn clean

# 2. 构建项目
echo -e "${YELLOW}构建 Maven 项目...${NC}"
if mvn package -DskipTests; then
    echo -e "${GREEN}Maven 构建成功！${NC}"
else
    echo -e "${RED}Maven 构建失败！${NC}"
    exit 1
fi

# 3. 停止并删除旧容器
echo -e "${YELLOW}停止并删除旧容器...${NC}"
docker-compose down

# 4. 构建新的 Docker 镜像
echo -e "${YELLOW}构建 Docker 镜像...${NC}"
if docker-compose build; then
    echo -e "${GREEN}Docker 镜像构建成功！${NC}"
else
    echo -e "${RED}Docker 镜像构建失败！${NC}"
    exit 1
fi

# 5. 启动容器
echo -e "${YELLOW}启动容器...${NC}"
if docker-compose up -d; then
    echo -e "${GREEN}容器启动成功！${NC}"
    echo -e "${GREEN}服务已部署到: http://localhost:8881${NC}"
    echo -e "${GREEN}API 文档地址: http://localhost:8881/swagger-ui.html${NC}"
else
    echo -e "${RED}容器启动失败！${NC}"
    exit 1
fi

# 6. 查看容器状态
echo -e "${YELLOW}查看容器状态...${NC}"
docker-compose ps

# 7. 显示日志
echo -e "${YELLOW}显示最近的日志...${NC}"
docker-compose logs --tail=50 aui-ims-robot

echo -e "${GREEN}部署完成！${NC}"
echo -e "${GREEN}您可以使用以下命令查看实时日志: docker-compose logs -f aui-ims-robot${NC}" 