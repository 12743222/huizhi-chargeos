#!/bin/bash

# ============================================
# 慧知充电桩平台 - 服务器一键部署脚本
# 使用方法: chmod +x server-setup.sh && ./server-setup.sh
# ============================================

set -e

echo "============================================"
echo "  慧知充电桩平台 - 开始一键部署"
echo "============================================"

# 检查是否在 docker 目录
if [ ! -f "deploy.sh" ]; then
    echo "❌ 请先进入 /home/hcp/docker 目录再运行此脚本"
    exit 1
fi

# 1. 安装 Docker（如果没有的话）
if command -v docker &> /dev/null; then
    echo "✅ Docker 已安装: $(docker --version)"
else
    echo "📦 正在安装 Docker..."
    curl -fsSL https://get.docker.com | bash
    systemctl start docker
    systemctl enable docker
    echo "✅ Docker 安装完成: $(docker --version)"
fi

# 2. 安装 Docker Compose（如果没有的话）
if docker compose version &> /dev/null; then
    echo "✅ Docker Compose 已安装: $(docker compose version)"
fi

# 3. 开放防火墙端口
echo "🔓 正在开放防火墙端口..."
./deploy.sh port 2>/dev/null || {
    systemctl stop firewalld 2>/dev/null || true
    echo "⚠️  防火墙已关闭或跳过"
}
echo "✅ 端口开放完成"

# 4. 启动基础服务
echo "🗄️  正在启动基础服务（MySQL、Redis、Nacos）..."
./deploy.sh base
echo "⏳ 等待 30 秒让数据库初始化..."
sleep 30

# 检查基础服务状态
echo "📋 检查基础服务状态："
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | head -10

# 5. 启动业务模块
echo "🚀 正在启动所有业务模块..."
./deploy.sh modules
echo "⏳ 等待 20 秒让服务启动..."
sleep 20

# 6. 最终检查
echo ""
echo "============================================"
echo "  📋 部署状态检查"
echo "============================================"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "============================================"
echo "  🎉 部署完成！"
echo "============================================"
echo ""
echo "  访问地址："
echo "  ┌──────────────────────────────────────────┐"
echo "  │  管理后台: http://8.130.122.177:9094     │"
echo "  │  Nacos:    http://8.130.122.177:8848/nacos│"
echo "  └──────────────────────────────────────────┘"
echo ""
echo "  Nacos 默认账号: nacos / nacos"
echo ""
