============================================
  慧知充电桩平台 - Docker 部署包
  版本: V3.0.9 | 服务器: 8.130.122.177
============================================

目录说明：
├── docker-compose.yml    # Docker 编排文件
├── deploy.sh             # 启动脚本
├── server-setup.sh       # 一键部署脚本（服务器上运行）
├── mysql/                # MySQL 数据库（含初始化SQL）
├── redis/                # Redis 缓存
├── nacos/                # Nacos 注册中心配置
├── nginx/                # Nginx 前端静态文件
└── hcp/                  # 后端各模块 JAR 包

部署步骤：
1. 在本地双击运行 F:\慧知\deploy.bat
2. 选择 "1. 上传部署包到服务器"
3. 输入密码: Aa123456
4. 上传完成后选择 "2. SSH 登录服务器"
5. 执行:
   cd /home/hcp/docker
   chmod +x server-setup.sh
   ./server-setup.sh

等待脚本运行完成即可。

访问地址：
  管理后台: http://8.130.122.177:9094
  Nacos:    http://8.130.122.177:8848/nacos (账号 nacos/nacos)
