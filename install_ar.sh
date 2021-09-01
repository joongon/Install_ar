#! /bin/bash

#echo "Select your platform between 1(Synology, default) and 2(Ubuntu) : "

printf "\n\nWelcome to installation of AutoRclone, all relevant tools will be installed automatically step by step.\n\n"

printf "First above all, you need to install python3. Even though python2 is already on your system,
AutoRclone is programmed by python3. That's why python3 is prerequisite for this AutoRclone.
Please refer to Synology Community or Blog for installing python3 on your NAS : DSM > Package Center > Python3\n\n"

printf "First off, installation fo rclone is getting started.\n\n"

# Rclone 설치 여부 확인, 없으면 설치

if which rclone > /dev/null; then
    echo "rclone is already installed on your NAS."
else
    curl https://rclone.org/install.sh | sudo bash
fi

#sleep 2

# 설치용 폴더 생성
#cd /root

#[ -d /root/install_ar ] || mkdir /root/install_ar
mkdir /root/install_ar
cd /root/install_ar
# pip3 설치 진행

if which pip3 > /dev/null; then
    echo "pip3 is already installed on your NAS."
else
    curl -O https://bootstrap.pypa.io/get-pip.py
    mv get-pip.py /root/install_ar
    python3 /root/install_ar/get-pip.py

        if which pip3 > /dev/null; then
            echo "pip3 has been successfully installed on your NAS."
        else
            echo "somthing is wrong. check it out. try again later."
        fi
fi

curl -O https://cdn.rigidsolution.com/file/autorclone.zip

sleep 5

#volume1, volume2, volume3 가 있다고 가정, volume3, volume2, volume1 우선순위로 설치 진행
#해당 설치 위치에 따라 ar.sh내의 설치 root 이동명령에 반영

is_v2=$(df -h | grep volume2)
is_v3=$(df -h | grep volume3)

[ -z $is_v3 ] && install_path="default" || install_path="p_v3"
[ -z $is_v2 ] && install_path="default" || install_path="p_v2"

if [ $install_path = "default" ]; then
    7z x autorclone.zip -o/volume1/homes
    echo "alias ar=\"bash /volume1/homes/AutoRclone/ar.sh\"" >> /root/.bashrc
    sudo pip3 install -r /volume1/homes/AutoRclone/requirements.txt
        
elif [ $install_path = "p_v2" ]; then
    7z x autorclone.zip -o/volume2/
    echo "alias ar=\"bash /volume2/AutoRclone/ar.sh\"" >> /root/.bashrc
    sudo pip3 install -r /volume2/AutoRclone/requirements.txt
    sed -i 's/cd \/volume1\/homes\/AutoRclone/cd \/volume2\/AutoRclone/g' /volume2/AutoRclone/ar.sh

elif [ $install_path = "p_v3" ]; then
    7z x autorclone.zip -o/volume3/
    echo "alias ar=\"bash /volume3/AutoRclone/ar.sh\"" >> /root/.bashrc
    sudo pip3 install -r /volume3/AutoRclone/requirements.txt
    sed -i 's/cd \/volume1\/homes\/AutoRclone/cd \/volume3\/AutoRclone/g' /volume3/AutoRclone/ar.sh
else
    prinf "It is not possible to find right path to install AutoRclone on your System,\n
           so check out the path and try again.\n"
           exit
fi

rm -rf /root/install_ar

printf "\nAll installation procedures have been successfully completed.\n\n"
printf "For using AutoRclone you need to copy Service Account files into $INSTALL_ROOT/accounts.\n\n"

source /root/.bashrc
sleep 5
source /root/.bashrc
