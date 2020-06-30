# rust118_infra
rust118 Infra repository

№8

- Создана переменная для приватного ключа
- Создана переменная для зоны со значением по умолчанию
- Исходники отформатированы
- Создан terraform.vars.example
- Создана конфигурация с дополнительным ресурсом для нового экземпляра приложения.
  При наличии нескольких ресурсов для экземляров одного приложения легко допустить 
  расхождение в конфигурациях этих экземпляров. 
- Создана конфигурация балансировщика
- Добавлена output-переменная для адреса балансировщика
- Реализована конфигурация к применением количества экземпляов через count

№7

Задание: Создать fried образ ОС с помощью утилиты packer, проверить, создав ВМ из образа и уставовив приложение.
Ответ: ubuntu16.json

Задание: Создать baked образ ОС с помощью утилиты packer, проверить, создав ВМ из образа.
Ответ: immutable.json

Задание: автоматизировать создание ВМ из baked-образа, с помощью yccli.
Ответ: config-scripts/create-reddit-vm.sh

№6

testapp_IP = 84.201.130.243
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

№5

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
    User appuser

Host someinternalhost
    HostName 10.130.0.28
    User appuser
    ProxyJump bastion" \
>> ~/.ssh/config
