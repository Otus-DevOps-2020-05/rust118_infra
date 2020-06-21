# rust118_infra
rust118 Infra repository

bastion_IP = 84.201.134.147
someinternalhost_IP = 10.130.0.3

Задание: Исследовать способ подключения к someinternalhost в одну команду на рабочем устройстве.

Ответ:
ssh -J appuser@84.201.134.147 appuser@10.130.0.3

Задание: Предложить вариант решения для подключения из консоли при помощи команды вида ssh someinternalhost из локальной консоли рабочего устройства, чтобы подключение выполнялось по алиасу someinternalhost.

Ответ:
echo \
"Host bastion
    HostName 84.201.134.147
    User app-user

Host someinternalhost
    HostName 10.130.0.3
    User appuser
    ProxyJump bastion" \
>> ~/.ssh/config
