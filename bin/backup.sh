#! /bin/sh

ssh rendezvous "cd /tmp; mysqldump -urendezvous -pedc08630b029fc979af5fd9e8fd979f690b0be149bac465bd66c2456c8fcd651 rendezvous > rendezvous.`date +'%Y%m%d'`.sql;"; scp rendezvous:/tmp/rendezvous.`date +'%Y%m%d'`.sql ./backup/
