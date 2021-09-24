#!/bin/bash
set -eu

# docker.sock から gid を取得して、vscode ユーザーがそのグループに所属するようにする
docker_group_id=$(ls -n /var/run/docker.sock | cut -d ' ' -f 4)
getent group ${docker_group_id} || sudo groupadd -g ${docker_group_id} docker
sudo usermod -aG ${docker_group_id} vscode

# 無限待ち（vscode デフォルトの entrypoint と同じ方法で）
while sleep 1000; do :; done
