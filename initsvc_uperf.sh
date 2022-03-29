#!/vendor/bin/sh
# Uperf Service Script
# https://github.com/yc9559/
# Author: Matt Yang
# Version: 20200401
BASEDIR=${0%/*}
USER_PATH="/data/media/0/yc/uperf"
wait_until_login() {
    # in case of /data encryption is disabled
    while [ "$(getprop sys.boot_completed)" != "1" ]; do
        sleep 1
    done

    # we doesn't have the permission to rw "/sdcard" before the user unlocks the screen
    local test_file="$USER_PATH/.PERMISSION_TEST"
    true >"$test_file"
    while [ ! -f "$test_file" ]; do
        true >"$test_file"
        sleep 1
    done
    rm "$test_file"

}
wait_until_login
mv $USER_PATH/log_uperf_initsvc.log $USER_PATH/log_uperf_initsvc.lastboot.log
date '+%Y-%m-%d %H:%M:%S' >$USER_PATH/log_uperf_initsvc.log 2>&1
echo "YC调度-天玑优化：开始加载" >$USER_PATH/log_uperf_initsvc.log 2>&1
echo "balance" >$USER_PATH/cur_powermode
env >>$USER_PATH/log_uperf_initsvc.log 2>&1
sh $BASEDIR/run_uperf.sh >>$USER_PATH/log_uperf_initsvc.log 2>&1
sh $BASEDIR/run_adj.sh >>$USER_PATH/log_uperf_initsvc.log 2>&1 &
