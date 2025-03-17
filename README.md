# 通用 Docker 模板

## 使用步骤

1. 修改 `build.sh` 中的 IMAGE_NAME
2. 修改 `run.sh` 中的 IMAGE_NAME 和 CONTAINER_NAME
3. 根据需要编辑 `environment.yaml` 里的依赖
4. 执行：
```
chmod +x build.sh run.sh
./build.sh
./run.sh
```
容器内已自动激活虚拟环境。
