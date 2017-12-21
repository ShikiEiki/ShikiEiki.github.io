#!/bin/bash
# ss的自动安装脚本,第一次写,写着玩玩
function mainlogic
{
apt-get update
apt-get -y dist-upgrade
apt-get -y upgrade
apt-get -y autoremove
apt-get -y autoclean
apt-get -y install python-pip python-m2crypto
pip install --upgrade pip
pip install setuptools
pip install shadowsocks

echo -e "{" > ~/ss.json
resultVar=$(ifconfig | grep "inet addr" | grep -v "127.0.0.1" | awk '{print $2}' | awk -F ':' '{print $2}')
echo -e "\t\"server\":\"$resultVar\"," >> ~/ss.json
echo -e "\t\"server_port\":8388," >> ~/ss.json
echo -e "\t\"local_address\":\"127.0.0.1\"," >> ~/ss.json
echo -e "\t\"local_port\":1080," >> ~/ss.json
echo -e "\t\"password\":\"FUCKGFW\"," >> ~/ss.json
echo -e "\t\"timeout\":300," >> ~/ss.json
echo -e "\t\"method\":\"rc4-md5\"" >> ~/ss.json
echo -e "}" >> ~/ss.json
resultVar=$(ssserver -c ~/ss.json -d restart)
echo $resultVar

}

echo -e  "\n==============================================================================\n\n 			PPBear SS 自动安装脚本 \n\n==============================================================================\n"
read -p "是否需要执行安装?(y/n)   :"  answer
if [ "$answer" == "y" ] || [ "$answer" == "Y" ];then
mainlogic
elif [ "$answer" == "n" ] || [ "$answer" == "N" ];then
exit 0
else 
echo "命令错误"
fi

exit 0
