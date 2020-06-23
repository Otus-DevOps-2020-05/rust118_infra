# rust118_infra
rust118 Infra repository

testapp_IP = 84.201.132.220

testapp_port = 9292

Задание: В результате применения CLI мы должны получать инстанс с уже запущенным приложением.

Ответ:
yc compute instance create \
--name reddit-app \
--hostname reddit-app \
--memory=4 \
--create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=4GB \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--metadata serial-port-enable=1 \
--metadata-from-file user-data=metadata.yaml


bastion_IP = 84.201.133.2
someinternalhost_IP = 10.130.0.28

Задание: Исследовать способ подключения к someinternalhost в одну команду на рабочем устройстве.

Ответ:
ssh -J appuser@84.201.133.2 appuser@10.130.0.28

Задание: Предложить вариант решения для подключения из консоли при помощи команды вида ssh someinternalhost из локальной консоли рабочего устройства, чтобы подключение выполнялось по алиасу someinternalhost.

Ответ:
echo \
"Host bastion
    HostName 84.201.133.2
    User app-user

Host someinternalhost
    HostName 10.130.0.28
    User appuser
    ProxyJump bastion" \
>> ~/.ssh/config
