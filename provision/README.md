# Rendezvous Infra

## プロビジョニング

```
% ansible-playbook -i inventories/production --private-key="~/.ssh/rendezvous.pem" site.yml
```

※ 秘密鍵は [rendezvous.pem](https://redmine.aiming-inc.biz/projects/general/wiki/Dev_rendezvous_keys) をダウンロードして使うこと
