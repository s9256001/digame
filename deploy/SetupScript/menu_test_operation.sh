#!/bin/bash
source menu
source ../Deploy/secret

function server_stop()
{
    echo 'server stop...'
    
	echo 'gamelobby:'
	serverName=gamelobby
    ssh -i ../Deploy/$testPem $testUser@$testURL "pm2 stop $serverName"
    echo 'wallet:'
	serverName=wallet
    ssh -i ../Deploy/$testPem $testUser@$testURL "pm2 stop $serverName"
    
    echo 'betquery:'
	serverName=betquery
    ssh -i ../Deploy/$testPem $testUser@$testURL "pm2 stop $serverName"
    echo 'gameserver:'
	serverName=gameserver
    ssh -i ../Deploy/$testPem $testUser@$testURL "pm2 stop $serverName"
	echo 'gameserver2:'
	serverName=gameserver2
    ssh -i ../Deploy/$testPem $testUser@$testURL "pm2 stop $serverName"
	echo 'dataserver:'
	serverName=dataserver
    ssh -i ../Deploy/$testPem $testUser@$testURL "pm2 stop $serverName"
}
function server_deploy()
{
    echo 'server deploy...'
    
    pushd $PWD > /dev/null
    cd ../Server
    
    scp -i ../Deploy/$testPem -r env/server/linux_test/* $testUser@$testURL:~/Server/server/
    scp -i ../Deploy/$testPem -r env/wallet/linux_test/* $testUser@$testURL:~/Server/wallet/
  
    popd > /dev/null
}
function server_down()
{
    echo 'server start...'
    
    envDir=Server/server
    echo 'dataserver:'
    serverName=dataserver
    ssh -i ../Deploy/$testPem $testUser@$testURL "pm2 delete $serverName"
    echo 'gameserver:'
    serverName=gameserver
    ssh -i ../Deploy/$testPem $testUser@$testURL "pm2 delete $serverName"
	echo 'gameserver2:'
    serverName=gameserver2
    ssh -i ../Deploy/$testPem $testUser@$testURL "pm2 delete $serverName"
    echo 'betquery:'
    serverName=betquery
    ssh -i ../Deploy/$testPem $testUser@$testURL "pm2 delete $serverName"
    
    envDir=Server/wallet
    echo 'wallet:'
    serverName=wallet
    ssh -i ../Deploy/$testPem $testUser@$testURL "pm2 delete $serverName"
	echo 'gamelobby:'
    serverName=gamelobby
    ssh -i ../Deploy/$testPem $testUser@$testURL "pm2 delete $serverName"
}
function server_start()
{
    echo 'server start...'
    
    envDir=Server/server
    echo 'dataserver:'
    serverName=dataserver
    ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/$serverName ; pm2 start --name $serverName server.out"
    echo 'gameserver:'
    serverName=gameserver
    ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/$serverName ; pm2 start --name $serverName server.out"
	echo 'gameserver2:'
    serverName=gameserver2
    ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/$serverName ; pm2 start --name $serverName server.out"
    echo 'betquery:'
    serverName=betquery
    ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/$serverName ; pm2 start --name $serverName server.out"
    
    envDir=Server/wallet
    echo 'wallet:'
    serverName=wallet
	ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/$serverName ; pm2 start --name $serverName server.out"
	echo 'gamelobby:'
    serverName=gamelobby
	ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/$serverName ; pm2 start --name $serverName server.out"
}
function server_status()
{
    echo 'server status...'
    
    ssh -i ../Deploy/$testPem $testUser@$testURL "pm2 list"
}
function server_version()
{
    echo 'server status...'
    
    envDir=Server/server
    echo 'dataserver:'
    serverName=dataserver
    ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/logs/$serverName ; grep ServerVersion server.log | tail -1"
    echo 'gameserver:'
    serverName=gameserver
    ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/logs/$serverName ; grep ServerVersion server.log | tail -1"
	echo 'gameserver2:'
    serverName=gameserver2
    ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/logs/$serverName ; grep ServerVersion server.log | tail -1"
    echo 'betquery:'
    serverName=betquery
    ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/logs/$serverName ; grep ServerVersion server.log | tail -1"
    
    envDir=Server/wallet
    echo 'wallet:'
    serverName=wallet
    ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/logs/$serverName ; grep ServerVersion server.log | tail -1"
	echo 'gamelobby:'
    serverName=gamelobby
    ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/logs/$serverName ; grep ServerVersion server.log | tail -1"
}
function server_error()
{
    echo 'server status...'
    
    envDir=Server/server
    echo 'dataserver:'
    serverName=dataserver
    ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
    echo 'gameserver:'
    serverName=gameserver
    ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
	echo 'gameserver2:'
    serverName=gameserver2
    ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
    echo 'betquery:'
    serverName=betquery
    ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
    
    envDir=Server/wallet
    echo 'wallet:'
    serverName=wallet
    ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
	echo 'gamelobby:'
    serverName=gamelobby
    ssh -i ../Deploy/$testPem $testUser@$testURL "cd $envDir/logs/$serverName ; grep -rnw './server.log' -e '| ERR |'"
}

commands=(1 2 3 4 5 6 7)
descriptions=(\
    'stop'\
    'deploy'\
    'down'\
    'start'\
    'status'\
    'version'\
	'error'\
    )
funcs=(\
    'server_stop'\
    'server_deploy'\
    'server_down'\
    'server_start'\
    'server_status'\
    'server_version'\
	'server_error'\
    )

menu_loop "test operation" commands descriptions funcs
