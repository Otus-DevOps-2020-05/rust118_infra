#!/bin/bash

case $1 in

    "--list")
	if [ -f ../my.addresses ]
	then
	    sh -c "../my.tf-apply.sh"
	fi

        DB_IP=$(cat ../my.addresses | grep external_ip_address_my-db | awk '{print "\""$3"\""}')
        APP_IP=$(cat ../my.addresses | grep external_ip_address_my-app | awk '{print "\""$3"\""}')

	echo -e "{\n" \
		"    \"_meta\": {\n" \
		"        \"hostvars\": {\n" \
		"            \"appserver\": {\n" \
		"                \"ansible_host\": $APP_IP\n" \
		"            },\n" \
		"            \"dbserver\": {\n" \
		"                \"ansible_host\": $DB_IP\n" \
		"            }\n" \
		"        }\n" \
		"    },\n" \
		"    \"all\": {\n" \
		"        \"children\": [\n" \
		"            \"app\",\n" \
		"            \"db\",\n" \
		"            \"ungrouped\"\n" \
		"        ]\n" \
		"    },\n" \
		"    \"app\": {\n" \
		"        \"hosts\": [\n" \
		"            \"appserver\"\n" \
		"        ]\n" \
		"    },\n" \
		"    \"db\": {\n" \
		"        \"hosts\": [\n" \
		"            \"dbserver\"\n" \
		"        ]\n" \
		"    }\n" \
		"}\n" \
	;;

    *)
	echo "Usage: $0 --list"
	exit 1
	;;
esac

exit 0
