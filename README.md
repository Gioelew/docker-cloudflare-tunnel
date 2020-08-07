# docker-cloudflare-tunnel

Create free tunnel using Docker and TryCloudflare

利用免费的tryCloudflare，将容器内端口映射到公网服务，同时获得Argo Tunnel的安全性加成。

注意：该服务为免费测试服务，性能和稳定性无法保障。

## Usage

```docker
docker run -d --link service --name doc -e ADDR=http://service:19282 mikubill/docker-cloudflare-tunnel
```

然后`docker logs doc`查看地址即可。
