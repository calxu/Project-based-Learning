# 项目框架的学习
整理从项目中学到知识，主要集中在shell脚本的学习。

## 1. awk命令的学习
整理了awk命令用于文件的拆分，比如原始数据如下，需要按买卖时间维度进行切分文件，使用awk命令请参考[awk_Learning](https://github.com/idKevin/Project-based-Learning/tree/master/awk_Learning)。
```
用户	商家	产品	买卖时间
user01	bus_M	pro_A	2017-08-03
user02	bus_N	pro_C	2017-08-04
user01	bus_M	pro_B	2017-08-04
user03	bus_O	pro_D	2017-08-03
user05	bus_M	pro_C	2017-08-05
user02	bus_N	pro_A	2017-08-04
user04	bus_O	pro_B	2017-08-05
user05	bus_M	pro_D	2017-08-03
user02	bus_O	pro_E	2017-08-03
user05	bus_N	pro_B	2017-08-04
```

## 2. 外部数据源在内部置信数据源的评估-二分类问题
整理了外部数据预测结果在真实数据源上的二分类效果评估。
假使A平台的数据platA.txt如下:
```
用户标识	标签(1:关注电子产品的数量>=5; 0:关注电子产品的数量=0)
user01	1
user02	0
user03	0
...
user38	1
user39	0
user40	1
```

B平台的数据platB.txt如下:
```
用户标识	标签(1:关注电子产品的数量>=5; 0:关注电子产品的数量=0)
user01	1
user03	0
user04	1
...
user48	1
user49	0
user50	1
```

我们已知A平台的数据为真实情况，需根据A平台的数据来评估B平台的数据的效果。详情请参考[classification_evaluation](https://github.com/idKevin/Project-based-Learning/tree/master/classification_evaluation)。

## 3. shell日志输出功能模块
在shell项目我们经常需要对日志进行监控，方便日后做分析。这里整理了日志输出功能模块，可以直接调用。详情请参考[shell_LOG](https://github.com/idKevin/Project-based-Learning/tree/master/shell_LOG)。
