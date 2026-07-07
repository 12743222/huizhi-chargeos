#!/bin/bash
# ============================================
# 拷贝 JAR 文件到 Docker 构建目录
# 在 Maven 打包完成后执行
# ============================================
set -e

echo "Copying JARs to Docker build context..."

# 后端服务 JAR 映射 (Maven 模块 -> Docker 上下文)
declare -A JAR_MAP=(
  ["hcp-auth/target/hcp-auth.jar"]="docker/hcp/auth/jar/hcp-auth.jar"
  ["hcp-gateway/target/hcp-gateway.jar"]="docker/hcp/gateway/jar/hcp-gateway.jar"
  ["hcp-demo/target/hcp-demo.jar"]="docker/hcp/demo/jar/hcp-demo.jar"
  ["hcp-modules/system/target/hcp-system.jar"]="docker/hcp/modules/system/jar/hcp-system.jar"
  ["hcp-modules/gen/target/hcp-gen.jar"]="docker/hcp/modules/gen/jar/hcp-gen.jar"
  ["hcp-modules/file/target/hcp-file.jar"]="docker/hcp/modules/file/jar/hcp-file.jar"
  ["hcp-modules/job/target/hcp-job.jar"]="docker/hcp/modules/job/jar/hcp-job.jar"
  ["hcp-visual/monitor/target/hcp-monitor.jar"]="docker/hcp/visual/monitor/jar/hcp-monitor.jar"
)

for src in "${!JAR_MAP[@]}"; do
  dst="${JAR_MAP[$src]}"
  if [ -f "$src" ]; then
    cp "$src" "$dst"
    echo "  OK: $src -> $dst"
  else
    echo "  WARN: $src not found, skipping"
  fi
done

echo "Done!"
