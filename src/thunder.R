# 1.Read Excel 2007 File
library("RODBC")
conn<-odbcConnectExcel2007("F:/tempt/2015density_factors_pdayu001_2.xlsx")
tr<-sqlFetch(conn, "2015density_factors_pdayu001_2")
tr2<-tr[34:27607,]
close(conn)
conn2<-odbcConnectExcel2007("F:/tempt/2015density_factors_pxiaoyu001.xlsx")
ts<-sqlFetch(conn2, "2015density_factors_pxiaoyu001")
ts2<-ts[171:158366,]

#随机采样
clients<-read.csv("clients.csv")
set.seed(100)
select<-sample(1:nrow(clients),length(clients$client_id)*0.7,
               replace=FALSE)       #默认replace=FALSE不放回抽样
train_clinet<-clients[select,]       #选取训练集数据
test_clinet<-clients[-select,]       #剩下的测试集数据

lm3.fit<-lm(level~aspect+dem_by+dem_clip+direction_change+humidity+pingmianql+poumianql+precipitation+pressure+quanljql+slope+slope_by+speed+temperature,data=tr3)
lm3.fit<-lm(level~aspect+dem_by+I(dem_by^2)+I(dem_by^3)+dem_clip+I(dem_clip^2)+I(dem_clip^3)
            +direction_change+I(direction_change^2)+I(direction_change^3)
            +humidity+I(humidity^2)+I(humidity^3)+pingmianql+poumianql+precipitation+I(precipitation^2)
            +I(precipitation^3)+pressure+I(pressure^2)+I(pressure^3)+quanljql
            +slope+I(slope^2)+I(slope^3)+slope_by+I(slope_by^2)+I(slope_by^3)
            +speed+I(speed^2)+I(speed^3)+temperature+I(temperature^2)+I(temperature^3),data=tr3)

qu0_2<-sqlFetch(conn4, "2015density_factors_all_qu0_2")
qu0_2$density_lg=log(qu0_2$density)
qu0_2_tr<-qu0_2[select,]
qu0_2_ts<-qu0_2[-select,]

#tr2是p值大于0.01的点，根据训练集、验证集划分为tr3、tr4，线性方程式是lm2
#pdayu005是p值大于0.05的点（即所有有显著性的点），根据训练集、验证集划分为pdayu005_tr、pdayu005_ts
#pdayu005的线性方程式为lm13
#pdayu0001是p值大于0.001的点，根据训练集、验证集划分为pdayu0001_tr、pdayu0001_ts，线性方程式为lm14
#jhpy是江汉平原的所有点，根据训练集、验证集划分为jhpy_tr、jhpy_ts，线性方程式为lm15
#level_poly是按等级merge后的面，线性方程式为lm16