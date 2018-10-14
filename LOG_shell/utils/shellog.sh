#!/bin/sh
# shell日志输出功能

# $0 当前执行的脚本名
# $1 行号
# $2 日志内容
# $LOGFILE 日志文件名,在conf/path.conf里配置

source conf/path.conf

# 日志存放路径
if [ ! -d $LOG_PATH ]; then
    mkdir $LOG_PATH 
fi

# 输出日志函数
function _write_log()
{
    if [ $# -eq 2 ]; then
        if [ -z $LOG_FILE ]; then
	    echo -e "`date +"%Y-%m-%d %H:%M:%S"` [$0:$1]: $2"
	else
	    echo -e "`date +"%Y-%m-%d %H:%M:%S"` [$0:$1]: $2" | tee -a $LOG_FILE
	fi
    elif [ $# -eq 1 ]; then
        if [ -z $LOG_FILE ]; then
	    echo -e "`date +"%Y-%m-%d %H:%M:%S"` [$0:$1]"
	else
	    echo -e "`date +"%Y-%m-%d %H:%M:%S"` [$0:$1]" | tee -a $LOG_FILE
	fi
    else
        return 1
    fi
}
# $LINENO为所执行命令的行数
alias write_log='_write_log $LINENO'  


# 检查上一条命令执行正确与否
function _check_last_command()
{
    if [ $? -eq 0 ]; then
        _write_log $1 "INFO: last command succeed!"
    else
        _write_log $1 "ERROR: last command failed!"
    fi
}

alias check_last_command='_check_last_command $LINENO'
