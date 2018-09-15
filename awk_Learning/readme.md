# 将原始文件按字段拆分

## 原始文件数据buyingData
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

## 文件的切分

执行以下的代码：
```
$ sh splitfile.sh buyingData
```

原始文件将以买卖时间切分成多个文件，分别为output_20170803、output_20170804和output_20170805

- output_20170803文件的内容为：
```
user01	bus_M	pro_A	20170803
user03	bus_O	pro_D	20170803
user05	bus_M	pro_D	20170803
user02	bus_O	pro_E	20170803
```

- output_20170804文件的内容为：
```
user02	bus_N	pro_C	20170804
user01	bus_M	pro_B	20170804
user02	bus_N	pro_A	20170804
user05	bus_N	pro_B	20170804
```

- output_20170805文件的内容为：
```
user05	bus_M	pro_C	20170805
user04	bus_O	pro_B	20170805
```
