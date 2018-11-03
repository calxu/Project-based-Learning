#!/bin/bash
# 外部数据在内部数据上交集的情况

if [ $# -ne 2 ]; then
    echo "USAGE: sh intersect_evaluation.sh \"内部平台的数据(platA.txt)\" \"外部平台的数据(platB.txt)\""
    echo -e "内部平台与外部平台数据格式均为 user_id\tlabel"
    exit 1
else
    inner_data=$1
    outer_data=$2
fi

# 测评外部数据的置信度
awk -F'\t' \
'BEGIN{ innerBoth=0; innerLabel1=0; innerLabel0=0; outerBoth=0; outerLabel1=0; outerLabel0=0; \
        TP=0; FN=0; FP=0; TN=0 }
{
    if (ARGIND == 1)
    {
        if ($2 == 0 || $2 == 1)
        {
            innerBoth += 1;
            # 内部平台标签为1的数据统计
            if ($2 == 1)
            {
                innerLabel1 += 1;
                innerLabel1Array[$1] = 1
            }
            # 内部平台标签为0的数据统计
            else
            {
                innerLabel0 += 1;
                innerLabel0Array[$1] = 0
            }
        }
    }
    else if(ARGIND == 2)
    {
        if ($2 == 0 || $2 == 1)
        {
            # 外部平台数据0-1标签的统计
            outerBoth += 1;
            if ($2 == 1)
                outerLabel1 += 1;
            else
                outerLabel0 += 1;
            
            # 统计内外部平台相交的数据情况
            if ($2 == 1)
            {
                if ($1 in innerLabel1Array)
                    TP += 1;
                else if ($1 in innerLabel0Array)
                    FP += 1;
            }
            else
            {
                if ($1 in innerLabel1Array)
                    FN += 1;
                else if ($1 in innerLabel0Array)
                    TN += 1;
            }
        }
     }
 }
 
END{
    OFS="\t"; 
    printf("内部A平台数据总量%d; 标签为1的数量%d; 标签为0的数量%d.\n", innerBoth, innerLabel1, innerLabel0);
    printf("外部B平台数据总量%d; 标签为1的数量%d; 标签为0的数量%d.\n", outerBoth, outerLabel1, outerLabel0);
    printf("A平台1交B平台1(TP)=%d; A平台1交B平台0(FN)=%d; A平台0交B平台1(FP)=%d; A平台0交B平台0(TN)=%d.\n\n", TP, FN, FP, TN);
    
    # 聚焦外部平台Label=1的数据分布
    printf("外部B平台中关注电子产品数量>=5(即Label=1)在内部A平台上的Precision、Recall和FPR指标: \
           \nPrecision=%.2f%%; Recall=%.2f%%; FPR=%.2f%%.\n\n", TP/(TP+FP)*100.0, TP/innerLabel1*100.0, FP/innerLabel0*100.0);
    
    # 聚焦外部平台Label=0的数据分布
    printf("外部B平台B中关注电子产品数量=0(即Label=0)在内部A平台上的对应的指标:\
           \nNPV=%.2f%%; TNR=%.2f%%; FNR=%.2f%%.\n", TN/(TN+FN)*100.0, TN/innerLabel0*100.0, FN/innerLabel1*100.0);
 }' $inner_data $outer_data
