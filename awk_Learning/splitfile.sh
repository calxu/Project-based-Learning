#!/bin/bash
# Task: 用awk按时间拆分文件
# Author: Calvin,Xu
# sh splitfile.sh buyingData

# 以Tab为分隔符读入数据，同时传入输入的外部文件名变量
awk -F'\t' -v filename="$1" \
'BEGIN{OFS="\t"}   # 以tab为分隔符输出数据
{
    # 标题行不处理，直接读取下一行
    if (NR == 1)
        next

    # 分别读取以tab为分隔符的各列数据
    user = $1;
    merchant = $2;
    product = $3;
    buyingTime = $4;
    # 在买卖时间字段里去除"-"字符
    gsub("-", "", buyingTime);

    # 此处重定向不同于shell的重定向。在这里首次输出会清空文件，后续是增加。
    # 详细说明见官方文档: https://www.gnu.org/software/gawk/manual/html_node/Redirection.html
    print user, merchant, product, buyingTime > filename"_"buyingTime;
}' $1
