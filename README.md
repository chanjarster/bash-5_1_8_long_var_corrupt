构建镜像：

```bash
./build.sh
```

循环创建容器执行：

```bash
./loop-run-docker.sh
```

容器内循环执行，关闭的话需要`docker rm -f env-corrupt`：

```bash
./run-docker.sh
```
