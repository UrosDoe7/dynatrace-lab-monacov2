#!/bin/bash
. ./env.sh

while [ "$APPLY" !=  "Y" ]
do
        clear
        echo "Variables : "
        echo ""
        echo "0) export DT_TENANT_URL="$DT_TENANT_URL
        echo "1) export DT_API_TOKEN="$DT_API_TOKEN
        echo "2) export HostGroupName="$HostGroupName
        echo "3) export DomainName="$DomainName
        echo "4) export Email="$Email
        echo "A) Apply the configuration (Ctrl/c to quit)"
        echo ""
        sleep 0.2
        read  -p "Input Selection (0, 1, 2, 3, 4 or A ): " reponse

        case "$reponse" in
                "0") read  -p "0) export DT_TENANT_URL=https://" value
                     sed -i 's/DT_TENANT_URL=.*$/DT_TENANT_URL=\"https\:\/\/'$value'\"/g' ./env.sh;. ./env.sh
                ;;
                "1") read  -p "1) export DT_API_TOKEN=" value
                     sed -i s/DT_API_TOKEN=.*$/DT_API_TOKEN=\"$value\"/g ./env.sh;. ./env.sh
                ;;
                "2") read  -p "2) export HostGroupName=" value
                     sed -i s/HostGroupName=.*$/HostGroupName=\"$value\"/g ./env.sh;. ./env.sh
                ;;
                "3") read  -p "3) export DomainName=" value
                     sed -i s/DomainName=.*$/DomainName=\"$value\"/g ./env.sh;. ./env.sh
                ;;
                "4") read  -p "4) export Email=" value
                     sed -i s/Email=.*$/Email=\"$value\"/g ./env.sh;. ./env.sh
                ;;
                "A") APPLY="Y"
                      cp project/config.yml project/config.yml.old
                      cp delete.yaml delete.yaml.old
                      sed "s/config-id/$HostGroupName/g" project/config.yml.ref > project/config.yml
                      sed "s/config-id/$HostGroupName/g" delete.yaml.ref > delete.yaml
                      echo "- env.sh is ready to be exported locally"
                      echo "- project/config.yml, is configured with the unique id: "$HostGroupName
                      echo
                ;;
        esac
done
echo "Let's start deployment for "$HostGroupName
echo " - export the variables on local session:      . env.sh"
echo " - deploy json configurations with monaco:     ./monaco deploy manifest.yaml"
echo " - backup json configurations with monaco:     ./monaco download manifest.yaml -e MyEnv"
echo " - (optional) delete config with monaco:       ./monaco delete"

