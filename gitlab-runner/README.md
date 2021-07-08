# Gitlab Runner

## Prepare

Create Docker volume `gitlab-runner-config`.

```yml
# docker-compose.override.yml
version: "3.5"

volumes:
  gitlab-runner-config:
    name: gitlab-runner-config
```

Register new runner

```shell
docker run --rm -it -v gitlab-runner-config:/etc/gitlab-runner gitlab/gitlab-runner:alpine register
```

## Refs

https://docs.gitlab.com/runner/register/index.html#docker
