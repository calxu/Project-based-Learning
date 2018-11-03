# 二分类问题的性能评估
这里整理了实际项目中二分类评测三大类常用指标的代码，方便以后的直接调用。适用于我们依据真实情况的分布，判断外部数据集置信程度。

## 1.基础知识
Precision(查准率，也叫精准率)、Recall(查全率，也叫召回率、真正例率)、FPR(假正例率，在业务中有时也叫误杀率)这三个评估指标是二分类问题中经常用到指标。

> 用周志华机器学习西瓜书P30里对这三个指标的案例描述：
> 1. 拉一车西瓜，若关注挑出的西瓜中有多少比例是好瓜，则我们关注的是Precision(查准率)。
> 2. 拉一车西瓜，若关注所有好瓜中有多少比例被挑了出来，则我们关注的是Recall(也叫查全率，TPR)。
> 3. 拉一车西瓜，若关注所有坏瓜有多少比例被挑了出来，则我们关注的是FPR(也叫误杀率)。

根据真实情况与预测情况的组合可以将类别分为真正例(True Positive)、假正例(False Positive)、真反例(True Negative)、假反例(False Negative)四种情形，如表1所示。

<center>表1 分类结果混淆矩阵</center>

<div align=center><img src="https://raw.githubusercontent.com/idKevin/Project-based-Learning/assets/images/confusion_matrix_01.png" width="60%" height="60%"></div>

其中Precision、Recall和FPR分别定义为：

<img src="https://raw.githubusercontent.com/idKevin/Project-based-Learning/assets/images/Precision.png" width="40%" height="40%">

<img src="https://raw.githubusercontent.com/idKevin/Project-based-Learning/assets/images/Recall.png" width="40%" height="40%">

<img src="https://raw.githubusercontent.com/idKevin/Project-based-Learning/assets/images/FPR.png" width="30%" height="30%">

**注：以上的TP+FN是真实情况所有的正例数；FP+TN是真实情况所有的负例数。即预测数据和真实情况是完全一致的**

## 2. 外部预测结果评估测评
### 2.1 数据准备
真实情况和预测结果的数据统一整理成如下形式，第一列为用户标识符，第二列为label：
```
user01	0
user02	1
user03	0
user04	1
user05	1
```
### 2.2 脚本执行与参数说明
测评执行intersect_evaluation.sh脚本，第一个参数(即platA.txt)为内部真实情况的数据，第二个参数(即platB.txt)为外部预测结果的数据，运行：

    $sh intersect_evaluation.sh platA.txt platB.txt

### 2.3 Result
```
$ sh intersect_evaluation.sh platA.txt platB.txt
内部A平台数据总量40; 标签为1的数量22; 标签为0的数量18.
外部B平台数据总量30; 标签为1的数量16; 标签为0的数量14.
A平台1交B平台1(TP)=8; A平台1交B平台0(FN)=4; A平台0交B平台1(FP)=3; A平台0交B平台0(TN)=5.

外部B平台中关注电子产品数量>=5(即Label=1)在内部A平台上的Precision、Recall和FPR指标:
Precision=72.73%; Recall=36.36%; FPR=16.67%.

外部B平台B中关注电子产品数量=0(即Label=0)在内部A平台上的对应的指标:
NPV=55.56%; TNR=27.78%; FNR=18.18%.
```

在这里我们以内部A平台为真实情况，以外部B平台为部分预测结果，Label=1为关注电子产品数大于5的用户，Label=0为未关注电子产品的用户，相应的与表1对照关系如下表所示。

<center>表2 分类结果混淆矩阵</center>

<div align=center><img src="https://raw.githubusercontent.com/idKevin/Project-based-Learning/assets/images/confusion_matrix_02.png" width="60%" height="60%"></div>

这里以准备好的platA.txt和platB.txt数据作详细的说明，platA.txt与platB.txt的数据集存在交集(**但并非完全一致**），我们需要依据platA.txt的真实情况判断platB.txt的置信情况，内部平台与外部平台数据结果分布情况如表3所示（**注：此处预测数据集并非完全等于真实数据集**）。

<center>表3 内外部平台数据分布情况</center>

<div align=center><img src="https://raw.githubusercontent.com/idKevin/Project-based-Learning/assets/images/confusion_matrix_03.png" width="60%" height="60%"></div>

如果聚焦外部B平台标签为1(即关注电子产品数>=5)的用户的情况，则

<img src="https://raw.githubusercontent.com/idKevin/Project-based-Learning/assets/images/Precision.png" width="40%" height="40%">

<img src="https://raw.githubusercontent.com/idKevin/Project-based-Learning/assets/images/Recall_innerLabel1.png" width="40%" height="40%">

<img src="https://raw.githubusercontent.com/idKevin/Project-based-Learning/assets/images/FPR_innerLabel0.png" width="30%" height="30%">

**这里求Recall和FPR时，我们分母未直接取(TP+FN)、(FP+TN)，而是取innerLabel0和innerLabel1。因为TP+FN是innerLabel1的子集(并非真实情况中全部Label=1的情况)，评估时重点关注外部数据集在内部平台的召回情况，FPR同理。而西瓜书P30中(即表1)真实情况和预测结果的数据集是同一批数据，但往往现实项目中两个平台的数据并非完全一致，只是存在交集，这时我们需要根据交集的效果从而评估整个数据集的效果。Precision重点关注在内部平台上的准确率，所以分母取得是(TP+FP)。**

如果聚焦外部B平台标签为0(即关注电子产品数=0)的用户情况，则

<img src="https://raw.githubusercontent.com/idKevin/Project-based-Learning/assets/images/NPV.png" width="40%" height="40%">

<img src="https://raw.githubusercontent.com/idKevin/Project-based-Learning/assets/images/TNR.png" width="40%" height="40%">

<img src="https://raw.githubusercontent.com/idKevin/Project-based-Learning/assets/images/FNR.png" width="30%" height="30%">

**NPV、TNR和FNR这几个指标非常不常用，但是我们反过来想就能一下子想明白，若我们聚焦的是外部B平台标签为0的用户，假使我们把标为为0的用户定义为1，NPV就对应Precision，TNR对应Recall(TPR)，FNR对应FPR(业务中也尝称为误杀)。**

## 3. References
- 参考WIKI：[https://en.wikipedia.org/wiki/Precision_and_recall](https://en.wikipedia.org/wiki/Precision_and_recall "https://en.wikipedia.org/wiki/Precision_and_recall")
- 参考书籍：周志华. 机器学习[M]. 清华大学出版社, 2016.
