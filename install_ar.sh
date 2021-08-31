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

sleep 2

# 설치용 폴더 생성
cd /root

[ -d install_ar ] || mkdir /root/install_ar

# pip3 설치 진행

if which pip3 > /dev/null; then
    echo "pip3 is already installed on your NAS."
else
    curl -O https://bootstrap.pypa.io/get-pip.py
    mv get-pip.py /root/install_ar
    python3 /root/install_ar/get-pip.py

        if which pip3 > /dev/nill; then
            echo "pip3 has been successfully installed on your NAS."
        else
            echo "somthing is wrong. check it out. try again later."
        fi
fi

curl -O https://cdn.rigidsolution.com/file/autorclone.zip
7z x autorclone.zip -o/volume1/homes
echo "alias ar=\"bash /volume1/homes/AutoRclone/ar.sh\"" >> /root/.bashrc
sleep 5
source /root/.bashrc
source /root/.bashrc

sudo pip3 install -r /volume1/homes/AutoRclone/requirements.txt

rm -rf /root/install_ar

printf "\nAll installation procedures have been successfully completed.\n\n"
