yumSourcePath=/etc/yum.repos.d
yumSourcePathBackup=${yumSourcePath}/backup
sshConfigPath=/etc/ssh/sshd_config

[OpenResty]
#openresty的安装路径
openrestyPath=/usr/local/newCisco
openrestyUser=nginx
openrestyGroup=nginx
server_name='192.168.1.80'
#版本号
openrestyVersion_latest=openresty-1.11.2.2.tar.gz
openrestyVersion_1.11=openresty-1.11.2.2.tar.gz
#openresty安装主目录
openRestyRoot=${openrestyPath}/${openrestyVersion_latest%\.tar\.gz}
luaRoot=/wwwlua
lualibPath=${openrestyPath}/lualib