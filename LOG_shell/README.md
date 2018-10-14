# shell日志输出功能模块

## Usage
Step 1: 在首行导入函数: source utils/shellog.sh

Step 2: 输出日志函数测试: write_log "***This is log test.***"

Step 3: 命令执行状态测试: check_last_command

## Test
执行如下命令，即打开一个新的subshell去执行test.sh
```
   $ ./test.sh
```

执行结果如下，第6行error_command是错误的命令，shell本身输出command not found（在日志中不显示）：
```
2018-10-15 02:06:00 [./test.sh:7]: ***********************
2018-10-15 02:06:00 [./test.sh:8]: ***This is log test.***
2018-10-15 02:06:00 [./test.sh:9]: ***********************
********END********
2018-10-15 02:06:00 [./test.sh:13]: INFO: last command succeed!
error_command: command not found
2018-10-15 02:06:00 [./test.sh:16]: ERROR: last command failed!
```
同时，在当前log目录的文件也记录相应的日志，其中不存在shell本身输出的第6行信息。

## Conclustion
该shell日志输出功能将脚本日志输出到屏幕的同时，也将日志信息存在log文件夹下对应的日志，方便日后的分析。
