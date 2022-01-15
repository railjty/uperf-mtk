# uperf
本分支为定频版本
#### 介绍
YC调度，为天玑SoC进行优化
感谢@yc9559 [Uperf-Github](https://github.com/yc9559/uperf)
 **本项目主要考量功耗压制，性能一定远远不如官方**
 **如有需要极致性能的请使用铁人调度或者MIUI12.5增强版或MIUI13的官方调度搭配删除温控相关模块**

 **相关修改**
1. 配置文件：
加回fast模式  
* fast模式：降低CPU高负载时的GPU频率，强制提高内存频率，在TDP内提供最佳CPU性能 **在双高压情况提供极限CPU性能，GPU性能较弱** （天玑1200实测性能单烤双烤CPU为官方调度90%+，GPU为官方调度50%）。  
* performance模式：根据负载降低CPU频率，GPU调频至最高以完整释放GPU性能，强制提高内存频率， **在双高压情况提供高GPU性能，CPU性能较弱** （天玑1200实测性能双烤时CPU为官方调度40%，GPU为官方调度100%，单烤正常）。  
* balance模式：降低CPU和GPU频率至高能效频率，根据负载提高内存频率， **在双高压情况提供中等CPU和GPU性能**（天玑1200实测性能单烤双烤CPU为官方调度35%，GPU为官方调度50%） 。  
* powersave模式：**仅保证基本使用**，同时尽可能降低CPU和GPU性能以省电，性能极差，已无法提供测试数据，仅供日常应用（MIUI 13除外）和息屏待机使用
2. service.sh  
用户后台应用锁定两个小核，系统后台应用锁定另外两个小核，压制后台应用耗电；  
关闭MIUIDaemon负优化