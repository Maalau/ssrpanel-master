#ss-panel-v3-mod_UIChanges 官方dev版本
#Author: 十一
#Blog: blog.67cc.cn
#Time：2018-8-25 11:05:33
#!/bin/bash

	yum install java-1.8.0-openjdk java-1.8.0-openjdk-devel -y
	ssrpanel_v2ray_new_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/aiyahacke/ssrpanel-v2ray/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
	wget -c --no-check-certificate "https://github.com/aiyahacke/ssrpanel-v2ray/releases/download/${ssrpanel_v2ray_new_ver}/ssrpanel-v2ray-${ssrpanel_v2ray_new_ver}.zip"
	unzip ssrpanel-v2ray-${ssrpanel_v2ray_new_ver}.zip -d ssrpanel-v2ray
	chmod -R a+x ssrpanel-v2ray && cd ssrpanel-v2ray
	echo -e "如果以下手动配置错误，请在${config}手动编辑修改"
	read -p "请输入你的对接IP(例如:不加http:// 如果是本机请直接回车): " WEBAPI_URL
	read -p "请输入你的对接数据库名称:" DB_NAME
	read -p "请输入你的对接数据库用户名" DB_USER
	read -p "请输入你的对接数据库密码:" DB_PSW
	read -p "请输入后台节点额外ID:" EW_ID
	read -p "请输入后台节点端口号:" JD_POCT
	read -p "请输入你的面板添加节点后得到的节点ID:" JD_ID
	read -p "请输入你的面板后台流量比例:" JD_LB
	echo -e "modify Config.py...\n"
	IPAddress=`wget http://members.3322.org/dyndns/getip -O - -q ; echo`;
	config="config.properties";
	WEBAPI_URL=${WEBAPI_URL:-"${IPAddress}"}
	sed -i "s#mysql:\/\/127.0.0.1#mysql:\/\/${WEBAPI_URL}#" ${config}
	DB_NAME=${DB_NAME:-"ssrpanel"}
	sed -i "s#ssrpanel#${DB_NAME}#" ${config}
	DB_USER=${DB_USER:-"ssrpanel"}
	sed -i "s#datasource.username=root#datasource.username=${DB_USER}#" ${config}
	DB_PSW=${DB_PSW:-"ssrpanel"}
	sed -i "s#datasource.password=root#datasource.password=${DB_PSW}#" ${config}
	EW_ID=${EW_ID:-"16"}
	sed -i "s#v2ray.alter-id=16#v2ray.alter-id=${EW_ID}#" ${config}
	JD_POCT=${JD_POCT:-"10086"}
	sed -i "s#v2ray.grpc.port=10086#$v2ray.grpc.port={JD_POCT}#" ${config}
	JD_ID=${JD_ID:-"1"}
	sed -i "s#node.id=3#node.id=${JD_ID}#" ${config}
	JD_LB=${JD_LB:-"1.0"}
	sed -i "s#node.traffic-rate=1.0#node.traffic-rate=${JD_LB}#" ${config}
	#
	cd /root/
	wget wget https://github.com/v2ray/v2ray-core/releases/download/v3.49/v2ray-linux-64.zip
	unzip v2ray-linux-64.zip -d v2ray-linux-64
	chmod -R a+x v2ray-linux-64
	cp /root/ssrpanel-v2ray/config.json /root/v2ray-linux-64/
	java -jar /root/ssrpanel-v2ray/ssrpanel-v2ray-${ssrpanel_v2ray_new_ver}.jar
	echo -e "运行中...\n"
		
	

