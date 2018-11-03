#!/bin/bash -i
# shell日志输出功能测试

source utils/shellog.sh

# 输出日志函数测试
write_log "***********************"
write_log "***This is log test.***"
write_log "***********************"

# 上条命令执行正确与否测试
echo "********END********"
check_last_command

error_command
check_last_command
