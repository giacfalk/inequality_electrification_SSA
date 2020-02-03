//Earth Engine Script for: 
//Satellite observations reveal inequalities in the progress and effectiveness of recent electrification in sub-Saharan Africa
//Giacomo Falchetta, Shonali Pachauri, Olha Danylo, Edward Byers, Simon Parkinson
// Version: 02/02/2020

//Import VIIRS nighttime lights
var imageCollection = ee.ImageCollection("NOAA/VIIRS/DNB/MONTHLY_V1/VCMSLCFG");
var nl14 =  imageCollection.filterDate('2014-01-01', '2015-01-01').select('avg_rad').median()
var nl15 =  imageCollection.filterDate('2015-01-01', '2016-01-01').select('avg_rad').median()
var nl16 =  imageCollection.filterDate('2016-01-01', '2017-01-01').select('avg_rad').median()
var nl17 =  imageCollection.filterDate('2017-01-01', '2018-01-01').select('avg_rad').median().subtract(0.125)
var nl18 =  imageCollection.filterDate('2018-01-01', '2019-01-01').select('avg_rad').median().subtract(0.125)
var nl19 =  imageCollection.filterDate('2019-01-01', '2020-01-01').select('avg_rad').median().subtract(0.125)

//population growth rates
var pop_gr_18_AGO = 3.27613387502724
var pop_gr_17_AGO = 3.32208099815609
var pop_gr_16_AGO = 3.37827278015957
var pop_gr_15_AGO = 3.43885068439195
var pop_gr_14_AGO = 3.49749274416236
var pop_gr_18_BEN = 2.73486201301479
var pop_gr_17_BEN = 2.75005559171415
var pop_gr_16_BEN = 2.76140949283081
var pop_gr_15_BEN = 2.77171416813917
var pop_gr_14_BEN = 2.78218150622205
var pop_gr_18_BWA = 2.197675757572
var pop_gr_17_BWA = 2.0703261666536
var pop_gr_16_BWA = 1.83285279210013
var pop_gr_15_BWA = 1.52530794175403
var pop_gr_14_BWA = 1.25643944756989
var pop_gr_18_BFA = 2.86707836702633
var pop_gr_17_BFA = 2.89085080621834
var pop_gr_16_BFA = 2.91531907101852
var pop_gr_15_BFA = 2.9394629768943
var pop_gr_14_BFA = 2.96190081353413
var pop_gr_18_BDI = 3.16677344240935
var pop_gr_17_BDI = 3.18136752395714
var pop_gr_16_BDI = 3.17701608653719
var pop_gr_15_BDI = 3.15690921658653
var pop_gr_14_BDI = 3.13685242336121
var pop_gr_18_CMR = 2.61229075104427
var pop_gr_17_CMR = 2.63769436262766
var pop_gr_16_CMR = 2.66049460889168
var pop_gr_15_CMR = 2.68179172973963
var pop_gr_14_CMR = 2.70155571704048
var pop_gr_18_CAF = 1.51905153699811
var pop_gr_17_CAF = 1.27750413591005
var pop_gr_16_CAF = 0.985894485598455
var pop_gr_15_CAF = 0.647403918742867
var pop_gr_14_CAF = 0.364290952465212
var pop_gr_18_TCD = 3.02357969868233
var pop_gr_17_TCD = 3.07753170826125
var pop_gr_16_TCD = 3.14395958930813
var pop_gr_15_TCD = 3.22205014713465
var pop_gr_14_TCD = 3.29694554087429
var pop_gr_18_COD = 3.22669890036105
var pop_gr_17_COD = 3.25850835081213
var pop_gr_16_COD = 3.2829146280863
var pop_gr_15_COD = 3.30283220957388
var pop_gr_14_COD = 3.31967666506265
var pop_gr_18_COG = 2.58170130027223
var pop_gr_17_COG = 2.57062991427374
var pop_gr_16_COG = 2.53958563357028
var pop_gr_15_COG = 2.48360817719048
var pop_gr_14_COG = 2.44063895825017
var pop_gr_18_CIV = 2.55235886056005
var pop_gr_17_CIV = 2.54780738985139
var pop_gr_16_CIV = 2.53609976063172
var pop_gr_15_CIV = 2.52209468070187
var pop_gr_14_CIV = 2.5045486872559
var pop_gr_18_GNQ = 3.6545067728316
var pop_gr_17_GNQ = 3.78071654676193
var pop_gr_16_GNQ = 3.91123234744071
var pop_gr_15_GNQ = 4.0420301414799
var pop_gr_14_GNQ = 4.17245490625393
var pop_gr_18_SWZ = 1.01179839738944
var pop_gr_17_SWZ = 0.962067725012171
var pop_gr_16_SWZ = 0.896297661168183
var pop_gr_15_SWZ = 0.820626096641609
var pop_gr_14_SWZ = 0.750005807309634
var pop_gr_18_ERI = 1.17
var pop_gr_17_ERI = 1.08
var pop_gr_16_ERI = 1.01
var pop_gr_15_ERI = 0.95
var pop_gr_14_ERI = 0.91
var pop_gr_18_ETH = 2.62001348207265
var pop_gr_17_ETH = 2.66346797807375
var pop_gr_16_ETH = 2.70810630355162
var pop_gr_15_ETH = 2.75612778784043
var pop_gr_14_ETH = 2.79992186176293
var pop_gr_18_GAB = 2.60295406093609
var pop_gr_17_GAB = 2.79685556362484
var pop_gr_16_GAB = 3.04339515547628
var pop_gr_15_GAB = 3.33509878560114
var pop_gr_14_GAB = 3.60651493569597
var pop_gr_18_GMB = 2.94672228129321
var pop_gr_17_GMB = 2.96856591791365
var pop_gr_16_GMB = 2.98860565833539
var pop_gr_15_GMB = 3.00847380343068
var pop_gr_14_GMB = 3.02604517693881
var pop_gr_18_GHA = 2.19282883696746
var pop_gr_17_GHA = 2.22053243013657
var pop_gr_16_GHA = 2.24659926762795
var pop_gr_15_GHA = 2.26881454933197
var pop_gr_14_GHA = 2.29178069316277
var pop_gr_18_GIN = 2.83313635348047
var pop_gr_17_GIN = 2.76501086533523
var pop_gr_16_GIN = 2.64448734263112
var pop_gr_15_GIN = 2.48970209028172
var pop_gr_14_GIN = 2.34241788318246
var pop_gr_18_GNB = 2.49377196123486
var pop_gr_17_GNB = 2.5320809488394
var pop_gr_16_GNB = 2.57057561074146
var pop_gr_15_GNB = 2.61050891599343
var pop_gr_14_GNB = 2.64523178650368
var pop_gr_18_KEN = 2.30594867522983
var pop_gr_17_KEN = 2.35681257338264
var pop_gr_16_KEN = 2.42114319740052
var pop_gr_15_KEN = 2.49193687127904
var pop_gr_14_KEN = 2.55944064959946
var pop_gr_18_LSO = 0.796281136528556
var pop_gr_17_LSO = 0.787780033893684
var pop_gr_16_LSO = 0.773100849082541
var pop_gr_15_LSO = 0.759743303173462
var pop_gr_14_LSO = 0.732722394020671
var pop_gr_18_LBR = 2.45252259258425
var pop_gr_17_LBR = 2.48564419709564
var pop_gr_16_LBR = 2.52928313182972
var pop_gr_15_LBR = 2.5528646851682
var pop_gr_14_LBR = 2.58316127213526
var pop_gr_18_MDG = 2.6696132402134
var pop_gr_17_MDG = 2.67988323936388
var pop_gr_16_MDG = 2.68818381201029
var pop_gr_15_MDG = 2.69421338218148
var pop_gr_14_MDG = 2.70099601097503
var pop_gr_18_MWI = 2.64191728771031
var pop_gr_17_MWI = 2.66661638772471
var pop_gr_16_MWI = 2.70990355147984
var pop_gr_15_MWI = 2.75946170038592
var pop_gr_14_MWI = 2.80309477008311
var pop_gr_18_MLI = 3.00791357916659
var pop_gr_17_MLI = 2.99911536700425
var pop_gr_16_MLI = 2.97529528280165
var pop_gr_15_MLI = 2.93599204683621
var pop_gr_14_MLI = 2.90192170501969
var pop_gr_18_MRT = 2.78043440578277
var pop_gr_17_MRT = 2.81899978265231
var pop_gr_16_MRT = 2.85611024246197
var pop_gr_15_MRT = 2.89357407247678
var pop_gr_14_MRT = 2.92732033171414
var pop_gr_18_MOZ = 2.91345897465103
var pop_gr_17_MOZ = 2.90062914205222
var pop_gr_16_MOZ = 2.87212045581116
var pop_gr_15_MOZ = 2.8348607835446
var pop_gr_14_MOZ = 2.7985685320841
var pop_gr_18_NAM = 1.88227929401189
var pop_gr_17_NAM = 1.87215433710164
var pop_gr_16_NAM = 1.84629715847982
var pop_gr_15_NAM = 1.80785137184809
var pop_gr_14_NAM = 1.77153651995332
var pop_gr_18_NER = 3.81686919885997
var pop_gr_17_NER = 3.83915445342991
var pop_gr_16_NER = 3.86007879547775
var pop_gr_15_NER = 3.88158148097942
var pop_gr_14_NER = 3.89988996490931
var pop_gr_18_NGA = 2.58654585214901
var pop_gr_17_NGA = 2.60767638578282
var pop_gr_16_NGA = 2.62770266215666
var pop_gr_15_NGA = 2.64741919950385
var pop_gr_14_NGA = 2.6650191731708
var pop_gr_18_RWA = 2.6440088912302
var pop_gr_17_RWA = 2.63966474965408
var pop_gr_16_RWA = 2.60235576419092
var pop_gr_15_RWA = 2.54269020713426
var pop_gr_14_RWA = 2.4855336438108
var pop_gr_18_SEN = 2.78193167027988
var pop_gr_17_SEN = 2.8006583330572
var pop_gr_16_SEN = 2.80736130621428
var pop_gr_15_SEN = 2.80841559034367
var pop_gr_14_SEN = 2.80670053587632
var pop_gr_18_SLE = 2.13664820752458
var pop_gr_17_SLE = 2.1542319550644
var pop_gr_16_SLE = 2.1644412134304
var pop_gr_15_SLE = 2.18162669445746
var pop_gr_14_SLE = 2.20688492215074
var pop_gr_18_SOM = 2.83176765182727
var pop_gr_17_SOM = 2.80476948965157
var pop_gr_16_SOM = 2.77625364862548
var pop_gr_15_SOM = 2.74531814986838
var pop_gr_14_SOM = 2.71747131833683
var pop_gr_18_ZAF = 1.35769728766652
var pop_gr_17_ZAF = 1.40774075042753
var pop_gr_16_ZAF = 1.4648292142325
var pop_gr_15_ZAF = 1.5289263067937
var pop_gr_14_ZAF = 1.58316828741381
var pop_gr_18_SSD = 0.595441569950834
var pop_gr_17_SSD = 0.719738421888599
var pop_gr_16_SSD = 1.08459461293809
var pop_gr_15_SSD = 1.51174398345437
var pop_gr_14_SSD = 1.91156250220449
var pop_gr_18_SDN = 2.39226526455048
var pop_gr_17_SDN = 2.39521985845548
var pop_gr_16_SDN = 2.39880790446865
var pop_gr_15_SDN = 2.40721227692973
var pop_gr_14_SDN = 2.41211568805284
var pop_gr_18_TZA = 2.98167411522997
var pop_gr_17_TZA = 2.99538813201206
var pop_gr_16_TZA = 3.00052290646443
var pop_gr_15_TZA = 3.00254050954064
var pop_gr_14_TZA = 3.00210408079214
var pop_gr_18_TGO = 2.44590420703926
var pop_gr_17_TGO = 2.47931830191209
var pop_gr_16_TGO = 2.5187418574522
var pop_gr_15_TGO = 2.56094509209806
var pop_gr_14_TGO = 2.60114952364707
var pop_gr_18_UGA = 3.72138730033183
var pop_gr_17_UGA = 3.74987516893954
var pop_gr_16_UGA = 3.65264430964001
var pop_gr_15_UGA = 3.49608916682811
var pop_gr_14_UGA = 3.35231963073483
var pop_gr_18_ZMB = 2.91280100356014
var pop_gr_17_ZMB = 2.95158327478263
var pop_gr_16_ZMB = 3.00334567903779
var pop_gr_15_ZMB = 3.06687453847381
var pop_gr_14_ZMB = 3.1213045608998
var pop_gr_18_ZWE = 1.41078272176006
var pop_gr_17_ZWE = 1.46006070897861
var pop_gr_16_ZWE = 1.54975881577614
var pop_gr_15_ZWE = 1.66381285051873
var pop_gr_14_ZWE = 1.7546923484321

// urbanisation levels
var pop_urb18_AGO = 65.514
var pop_urb17_AGO = 64.839
var pop_urb16_AGO = 64.149
var pop_urb15_AGO = 63.446
var pop_urb14_AGO = 62.731
var pop_urb13_AGO = 62.002
var pop_urb18_BEN = 47.312
var pop_urb17_BEN = 46.768
var pop_urb16_BEN = 46.229
var pop_urb15_BEN = 45.695
var pop_urb14_BEN = 45.166
var pop_urb13_BEN = 44.642
var pop_urb18_BWA = 69.446
var pop_urb17_BWA = 68.7
var pop_urb16_BWA = 67.933
var pop_urb15_BWA = 67.155
var pop_urb14_BWA = 66.368
var pop_urb13_BWA = 65.572
var pop_urb18_BFA = 29.358
var pop_urb17_BFA = 28.743
var pop_urb16_BFA = 28.134
var pop_urb15_BFA = 27.53
var pop_urb14_BFA = 26.934
var pop_urb13_BFA = 26.346
var pop_urb18_BDI = 13.032
var pop_urb17_BDI = 12.706
var pop_urb16_BDI = 12.388
var pop_urb15_BDI = 12.078
var pop_urb14_BDI = 11.776
var pop_urb13_BDI = 11.482
var pop_urb18_CMR = 56.374
var pop_urb17_CMR = 55.777
var pop_urb16_CMR = 55.179
var pop_urb15_CMR = 54.578
var pop_urb14_CMR = 53.976
var pop_urb13_CMR = 53.373
var pop_urb18_CAF = 41.364
var pop_urb17_CAF = 40.98
var pop_urb16_CAF = 40.618
var pop_urb15_CAF = 40.277
var pop_urb14_CAF = 39.959
var pop_urb13_CAF = 39.663
var pop_urb18_TCD = 23.059
var pop_urb17_TCD = 22.858
var pop_urb16_TCD = 22.677
var pop_urb15_TCD = 22.515
var pop_urb14_TCD = 22.372
var pop_urb13_TCD = 22.248
var pop_urb18_COD = 44.46
var pop_urb17_COD = 43.88
var pop_urb16_COD = 43.307
var pop_urb15_COD = 42.74
var pop_urb14_COD = 42.18
var pop_urb13_COD = 41.627
var pop_urb18_COG = 66.916
var pop_urb17_COG = 66.459
var pop_urb16_COG = 66.001
var pop_urb15_COG = 65.543
var pop_urb14_COG = 65.085
var pop_urb13_COG = 64.627
var pop_urb18_CIV = 50.779
var pop_urb17_CIV = 50.326
var pop_urb16_CIV = 49.881
var pop_urb15_CIV = 49.444
var pop_urb14_CIV = 49.014
var pop_urb13_CIV = 48.593
var pop_urb18_GNQ = 72.143
var pop_urb17_GNQ = 71.646
var pop_urb16_GNQ = 71.138
var pop_urb15_GNQ = 70.616
var pop_urb14_GNQ = 70.083
var pop_urb13_GNQ = 69.544
var pop_urb18_SWZ = 23.799
var pop_urb17_SWZ = 23.625
var pop_urb16_SWZ = 23.459
var pop_urb15_SWZ = 23.3
var pop_urb14_SWZ = 23.149
var pop_urb13_SWZ = 22.999
var pop_urb18_ETH = 20.763
var pop_urb17_ETH = 20.31
var pop_urb16_ETH = 19.866
var pop_urb15_ETH = 19.428
var pop_urb14_ETH = 18.998
var pop_urb13_ETH = 18.575
var pop_urb18_GAB = 89.37
var pop_urb17_GAB = 88.976
var pop_urb16_GAB = 88.559
var pop_urb15_GAB = 88.118
var pop_urb14_GAB = 87.651
var pop_urb13_GAB = 87.156
var pop_urb18_GMB = 61.27
var pop_urb17_GMB = 60.599
var pop_urb16_GMB = 59.918
var pop_urb15_GMB = 59.228
var pop_urb14_GMB = 58.528
var pop_urb13_GMB = 57.82
var pop_urb18_GHA = 56.06
var pop_urb17_GHA = 55.407
var pop_urb16_GHA = 54.749
var pop_urb15_GHA = 54.086
var pop_urb14_GHA = 53.419
var pop_urb13_GHA = 52.748
var pop_urb18_GIN = 36.14
var pop_urb17_GIN = 35.793
var pop_urb16_GIN = 35.46
var pop_urb15_GIN = 35.141
var pop_urb14_GIN = 34.836
var pop_urb13_GIN = 34.545
var pop_urb18_GNB = 43.36
var pop_urb17_GNB = 42.945
var pop_urb16_GNB = 42.533
var pop_urb15_GNB = 42.123
var pop_urb14_GNB = 41.715
var pop_urb13_GNB = 41.31
var pop_urb18_KEN = 27.03
var pop_urb17_KEN = 26.562
var pop_urb16_KEN = 26.105
var pop_urb15_KEN = 25.658
var pop_urb14_KEN = 25.221
var pop_urb13_KEN = 24.794
var pop_urb18_LSO = 28.153
var pop_urb17_LSO = 27.73
var pop_urb16_LSO = 27.317
var pop_urb15_LSO = 26.908
var pop_urb14_LSO = 26.502
var pop_urb13_LSO = 26.101
var pop_urb18_LBR = 51.151
var pop_urb17_LBR = 50.697
var pop_urb16_LBR = 50.254
var pop_urb15_LBR = 49.82
var pop_urb14_LBR = 49.397
var pop_urb13_LBR = 48.985
var pop_urb18_MDG = 37.191
var pop_urb17_MDG = 36.522
var pop_urb16_MDG = 35.856
var pop_urb15_MDG = 35.193
var pop_urb14_MDG = 34.534
var pop_urb13_MDG = 33.878
var pop_urb18_MWI = 16.937
var pop_urb17_MWI = 16.714
var pop_urb16_MWI = 16.506
var pop_urb15_MWI = 16.313
var pop_urb14_MWI = 16.132
var pop_urb13_MWI = 15.966
var pop_urb18_MLI = 42.356
var pop_urb17_MLI = 41.572
var pop_urb16_MLI = 40.783
var pop_urb15_MLI = 39.991
var pop_urb14_MLI = 39.196
var pop_urb13_MLI = 38.398
var pop_urb18_MRT = 53.672
var pop_urb17_MRT = 52.824
var pop_urb16_MRT = 51.962
var pop_urb15_MRT = 51.089
var pop_urb14_MRT = 50.203
var pop_urb13_MRT = 49.306
var pop_urb18_MOZ = 35.988
var pop_urb17_MOZ = 35.455
var pop_urb16_MOZ = 34.926
var pop_urb15_MOZ = 34.4
var pop_urb14_MOZ = 33.878
var pop_urb13_MOZ = 33.36
var pop_urb18_NAM = 50.032
var pop_urb17_NAM = 49.005
var pop_urb16_NAM = 47.961
var pop_urb15_NAM = 46.9
var pop_urb14_NAM = 45.826
var pop_urb13_NAM = 44.756
var pop_urb18_NER = 16.425
var pop_urb17_NER = 16.35
var pop_urb16_NER = 16.29
var pop_urb15_NER = 16.247
var pop_urb14_NER = 16.219
var pop_urb13_NER = 16.208
var pop_urb18_NGA = 50.344
var pop_urb17_NGA = 49.519
var pop_urb16_NGA = 48.683
var pop_urb15_NGA = 47.838
var pop_urb14_NGA = 46.982
var pop_urb13_NGA = 46.118
var pop_urb18_RWA = 17.211
var pop_urb17_RWA = 17.125
var pop_urb16_RWA = 17.056
var pop_urb15_RWA = 17.004
var pop_urb14_RWA = 16.967
var pop_urb13_RWA = 16.947
var pop_urb18_SEN = 47.192
var pop_urb17_SEN = 46.74
var pop_urb16_SEN = 46.296
var pop_urb15_SEN = 45.862
var pop_urb14_SEN = 45.436
var pop_urb13_SEN = 45.019
var pop_urb18_SLE = 42.055
var pop_urb17_SLE = 41.636
var pop_urb16_SLE = 41.228
var pop_urb15_SLE = 40.829
var pop_urb14_SLE = 40.432
var pop_urb13_SLE = 40.036
var pop_urb18_SOM = 44.971
var pop_urb17_SOM = 44.391
var pop_urb16_SOM = 43.816
var pop_urb15_SOM = 43.245
var pop_urb14_SOM = 42.679
var pop_urb13_SOM = 42.117
var pop_urb18_ZAF = 66.355
var pop_urb17_ZAF = 65.85
var pop_urb16_ZAF = 65.341
var pop_urb15_ZAF = 64.828
var pop_urb14_ZAF = 64.312
var pop_urb13_ZAF = 63.793
var pop_urb18_SSD = 19.615
var pop_urb17_SSD = 19.346
var pop_urb16_SSD = 19.092
var pop_urb15_SSD = 18.852
var pop_urb14_SSD = 18.626
var pop_urb13_SSD = 18.415
var pop_urb18_SDN = 34.642
var pop_urb17_SDN = 34.37
var pop_urb16_SDN = 34.121
var pop_urb15_SDN = 33.894
var pop_urb14_SDN = 33.689
var pop_urb13_SDN = 33.507
var pop_urb18_TZA = 33.776
var pop_urb17_TZA = 33.053
var pop_urb16_TZA = 32.333
var pop_urb15_TZA = 31.617
var pop_urb14_TZA = 30.904
var pop_urb13_TZA = 30.196
var pop_urb18_TGO = 41.702
var pop_urb17_TGO = 41.162
var pop_urb16_TGO = 40.628
var pop_urb15_TGO = 40.1
var pop_urb14_TGO = 39.579
var pop_urb13_TGO = 39.061
var pop_urb18_UGA = 23.774
var pop_urb17_UGA = 23.196
var pop_urb16_UGA = 22.624
var pop_urb15_UGA = 22.06
var pop_urb14_UGA = 21.504
var pop_urb13_UGA = 20.958
var pop_urb18_ZMB = 43.521
var pop_urb17_ZMB = 42.976
var pop_urb16_ZMB = 42.438
var pop_urb15_ZMB = 41.907
var pop_urb14_ZMB = 41.382
var pop_urb13_ZMB = 40.865
var pop_urb18_ZWE = 32.209
var pop_urb17_ZWE = 32.237
var pop_urb16_ZWE = 32.296
var pop_urb15_ZWE = 32.385
var pop_urb14_ZWE = 32.504
var pop_urb13_ZWE = 32.654
var pop_urb18_ERI = 40.4
var pop_urb17_ERI = 39.9
var pop_urb16_ERI = 39.4
var pop_urb15_ERI = 38.9
var pop_urb14_ERI = 38.3
var pop_urb13_ERI = 37.7

var pop_rur18_AGO = 34.486
var pop_rur17_AGO = 35.161
var pop_rur16_AGO = 35.851
var pop_rur15_AGO = 36.554
var pop_rur14_AGO = 37.269
var pop_rur13_AGO = 37.998
var pop_rur18_BEN = 52.688
var pop_rur17_BEN = 53.232
var pop_rur16_BEN = 53.771
var pop_rur15_BEN = 54.305
var pop_rur14_BEN = 54.834
var pop_rur13_BEN = 55.358
var pop_rur18_BWA = 30.554
var pop_rur17_BWA = 31.3
var pop_rur16_BWA = 32.067
var pop_rur15_BWA = 32.845
var pop_rur14_BWA = 33.632
var pop_rur13_BWA = 34.428
var pop_rur18_BFA = 70.642
var pop_rur17_BFA = 71.257
var pop_rur16_BFA = 71.866
var pop_rur15_BFA = 72.47
var pop_rur14_BFA = 73.066
var pop_rur13_BFA = 73.654
var pop_rur18_BDI = 86.968
var pop_rur17_BDI = 87.294
var pop_rur16_BDI = 87.612
var pop_rur15_BDI = 87.922
var pop_rur14_BDI = 88.224
var pop_rur13_BDI = 88.518
var pop_rur18_CMR = 43.626
var pop_rur17_CMR = 44.223
var pop_rur16_CMR = 44.821
var pop_rur15_CMR = 45.422
var pop_rur14_CMR = 46.024
var pop_rur13_CMR = 46.627
var pop_rur18_CAF = 58.636
var pop_rur17_CAF = 59.02
var pop_rur16_CAF = 59.382
var pop_rur15_CAF = 59.723
var pop_rur14_CAF = 60.041
var pop_rur13_CAF = 60.337
var pop_rur18_TCD = 76.941
var pop_rur17_TCD = 77.142
var pop_rur16_TCD = 77.323
var pop_rur15_TCD = 77.485
var pop_rur14_TCD = 77.628
var pop_rur13_TCD = 77.752
var pop_rur18_COD = 55.54
var pop_rur17_COD = 56.12
var pop_rur16_COD = 56.693
var pop_rur15_COD = 57.26
var pop_rur14_COD = 57.82
var pop_rur13_COD = 58.373
var pop_rur18_COG = 33.084
var pop_rur17_COG = 33.541
var pop_rur16_COG = 33.999
var pop_rur15_COG = 34.457
var pop_rur14_COG = 34.915
var pop_rur13_COG = 35.373
var pop_rur18_CIV = 49.221
var pop_rur17_CIV = 49.674
var pop_rur16_CIV = 50.119
var pop_rur15_CIV = 50.556
var pop_rur14_CIV = 50.986
var pop_rur13_CIV = 51.407
var pop_rur18_GNQ = 27.857
var pop_rur17_GNQ = 28.354
var pop_rur16_GNQ = 28.862
var pop_rur15_GNQ = 29.384
var pop_rur14_GNQ = 29.917
var pop_rur13_GNQ = 30.456
var pop_rur18_SWZ = 76.201
var pop_rur17_SWZ = 76.375
var pop_rur16_SWZ = 76.541
var pop_rur15_SWZ = 76.7
var pop_rur14_SWZ = 76.851
var pop_rur13_SWZ = 77.001
var pop_rur18_ETH = 79.237
var pop_rur17_ETH = 79.69
var pop_rur16_ETH = 80.134
var pop_rur15_ETH = 80.572
var pop_rur14_ETH = 81.002
var pop_rur13_ETH = 81.425
var pop_rur18_GAB = 10.63
var pop_rur17_GAB = 11.024
var pop_rur16_GAB = 11.441
var pop_rur15_GAB = 11.882
var pop_rur14_GAB = 12.349
var pop_rur13_GAB = 12.844
var pop_rur18_GMB = 38.73
var pop_rur17_GMB = 39.401
var pop_rur16_GMB = 40.082
var pop_rur15_GMB = 40.772
var pop_rur14_GMB = 41.472
var pop_rur13_GMB = 42.18
var pop_rur18_GHA = 43.94
var pop_rur17_GHA = 44.593
var pop_rur16_GHA = 45.251
var pop_rur15_GHA = 45.914
var pop_rur14_GHA = 46.581
var pop_rur13_GHA = 47.252
var pop_rur18_GIN = 63.86
var pop_rur17_GIN = 64.207
var pop_rur16_GIN = 64.54
var pop_rur15_GIN = 64.859
var pop_rur14_GIN = 65.164
var pop_rur13_GIN = 65.455
var pop_rur18_GNB = 56.64
var pop_rur17_GNB = 57.055
var pop_rur16_GNB = 57.467
var pop_rur15_GNB = 57.877
var pop_rur14_GNB = 58.285
var pop_rur13_GNB = 58.69
var pop_rur18_KEN = 72.97
var pop_rur17_KEN = 73.438
var pop_rur16_KEN = 73.895
var pop_rur15_KEN = 74.342
var pop_rur14_KEN = 74.779
var pop_rur13_KEN = 75.206
var pop_rur18_LSO = 71.847
var pop_rur17_LSO = 72.27
var pop_rur16_LSO = 72.683
var pop_rur15_LSO = 73.092
var pop_rur14_LSO = 73.498
var pop_rur13_LSO = 73.899
var pop_rur18_LBR = 48.849
var pop_rur17_LBR = 49.303
var pop_rur16_LBR = 49.746
var pop_rur15_LBR = 50.18
var pop_rur14_LBR = 50.603
var pop_rur13_LBR = 51.015
var pop_rur18_MDG = 62.809
var pop_rur17_MDG = 63.478
var pop_rur16_MDG = 64.144
var pop_rur15_MDG = 64.807
var pop_rur14_MDG = 65.466
var pop_rur13_MDG = 66.122
var pop_rur18_MWI = 83.063
var pop_rur17_MWI = 83.286
var pop_rur16_MWI = 83.494
var pop_rur15_MWI = 83.687
var pop_rur14_MWI = 83.868
var pop_rur13_MWI = 84.034
var pop_rur18_MLI = 57.644
var pop_rur17_MLI = 58.428
var pop_rur16_MLI = 59.217
var pop_rur15_MLI = 60.009
var pop_rur14_MLI = 60.804
var pop_rur13_MLI = 61.602
var pop_rur18_MRT = 46.328
var pop_rur17_MRT = 47.176
var pop_rur16_MRT = 48.038
var pop_rur15_MRT = 48.911
var pop_rur14_MRT = 49.797
var pop_rur13_MRT = 50.694
var pop_rur18_MOZ = 64.012
var pop_rur17_MOZ = 64.545
var pop_rur16_MOZ = 65.074
var pop_rur15_MOZ = 65.6
var pop_rur14_MOZ = 66.122
var pop_rur13_MOZ = 66.64
var pop_rur18_NAM = 49.968
var pop_rur17_NAM = 50.995
var pop_rur16_NAM = 52.039
var pop_rur15_NAM = 53.1
var pop_rur14_NAM = 54.174
var pop_rur13_NAM = 55.244
var pop_rur18_NER = 83.575
var pop_rur17_NER = 83.65
var pop_rur16_NER = 83.71
var pop_rur15_NER = 83.753
var pop_rur14_NER = 83.781
var pop_rur13_NER = 83.792
var pop_rur18_NGA = 49.656
var pop_rur17_NGA = 50.481
var pop_rur16_NGA = 51.317
var pop_rur15_NGA = 52.162
var pop_rur14_NGA = 53.018
var pop_rur13_NGA = 53.882
var pop_rur18_RWA = 82.789
var pop_rur17_RWA = 82.875
var pop_rur16_RWA = 82.944
var pop_rur15_RWA = 82.996
var pop_rur14_RWA = 83.033
var pop_rur13_RWA = 83.053
var pop_rur18_SEN = 52.808
var pop_rur17_SEN = 53.26
var pop_rur16_SEN = 53.704
var pop_rur15_SEN = 54.138
var pop_rur14_SEN = 54.564
var pop_rur13_SEN = 54.981
var pop_rur18_SLE = 57.945
var pop_rur17_SLE = 58.364
var pop_rur16_SLE = 58.772
var pop_rur15_SLE = 59.171
var pop_rur14_SLE = 59.568
var pop_rur13_SLE = 59.964
var pop_rur18_SOM = 55.029
var pop_rur17_SOM = 55.609
var pop_rur16_SOM = 56.184
var pop_rur15_SOM = 56.755
var pop_rur14_SOM = 57.321
var pop_rur13_SOM = 57.883
var pop_rur18_ZAF = 33.645
var pop_rur17_ZAF = 34.15
var pop_rur16_ZAF = 34.659
var pop_rur15_ZAF = 35.172
var pop_rur14_ZAF = 35.688
var pop_rur13_ZAF = 36.207
var pop_rur18_SSD = 80.385
var pop_rur17_SSD = 80.654
var pop_rur16_SSD = 80.908
var pop_rur15_SSD = 81.148
var pop_rur14_SSD = 81.374
var pop_rur13_SSD = 81.585
var pop_rur18_SDN = 65.358
var pop_rur17_SDN = 65.63
var pop_rur16_SDN = 65.879
var pop_rur15_SDN = 66.106
var pop_rur14_SDN = 66.311
var pop_rur13_SDN = 66.493
var pop_rur18_TZA = 66.224
var pop_rur17_TZA = 66.947
var pop_rur16_TZA = 67.667
var pop_rur15_TZA = 68.383
var pop_rur14_TZA = 69.096
var pop_rur13_TZA = 69.804
var pop_rur18_TGO = 58.298
var pop_rur17_TGO = 58.838
var pop_rur16_TGO = 59.372
var pop_rur15_TGO = 59.9
var pop_rur14_TGO = 60.421
var pop_rur13_TGO = 60.939
var pop_rur18_UGA = 76.226
var pop_rur17_UGA = 76.804
var pop_rur16_UGA = 77.376
var pop_rur15_UGA = 77.94
var pop_rur14_UGA = 78.496
var pop_rur13_UGA = 79.042
var pop_rur18_ZMB = 56.479
var pop_rur17_ZMB = 57.024
var pop_rur16_ZMB = 57.562
var pop_rur15_ZMB = 58.093
var pop_rur14_ZMB = 58.618
var pop_rur13_ZMB = 59.135
var pop_rur18_ZWE = 67.791
var pop_rur17_ZWE = 67.763
var pop_rur16_ZWE = 67.704
var pop_rur15_ZWE = 67.615
var pop_rur14_ZWE = 67.496
var pop_rur13_ZWE = 67.346
var pop_rur18_ERI = 59.3
var pop_rur17_ERI = 59.8
var pop_rur16_ERI = 60.3
var pop_rur15_ERI = 60.9
var pop_rur14_ERI = 61.5
var pop_rur13_ERI = 62.1

//
var pop15 = ee.Image('users/giacomofalchetta/hrsl_images')

var hafrica = ee.FeatureCollection('users/giacomofalchetta/gadm').filter(ee.Filter.or(ee.Filter.eq('ISO3', 'SSD'),  ee.Filter.eq('ISO3', 'SOM'), ee.Filter.eq('ISO3', 'SDN'), ee.Filter.eq('ISO3', 'ETH'), ee.Filter.eq('ISO3', 'ERI')));

var pops_hornafrica = ee.Image('JRC/GHSL/P2016/POP_GPW_GLOBE_V1/2015').clip(hafrica).select('population_count')

var wkt = ' \
  PROJCS["World_Mollweide", \
    GEOGCS["GCS_WGS_1984", \
      DATUM["WGS_1984", \
        SPHEROID["WGS_1984",6378137,298.257223563]], \
      PRIMEM["Greenwich",0], \
      UNIT["Degree",0.017453292519943295]], \
    PROJECTION["Mollweide"], \
    PARAMETER["False_Easting",0], \
    PARAMETER["False_Northing",0], \
    PARAMETER["Central_Meridian",0], \
    UNIT["Meter",1], \
    AUTHORITY["EPSG","54009"]]';

var proj_mollweide = ee.Projection(wkt);

var density = pops_hornafrica.divide(ee.Image.pixelArea())
var pops_hornafrica = density.resample('bilinear').reproject({
  crs: proj_mollweide,
  scale: 30
}).multiply(ee.Image.pixelArea()).rename('b1');

var replacement = ee.Image(0);
var pops_hornafrica = pops_hornafrica.where(pops_hornafrica.lt(0), replacement);

var pop15 = ee.ImageCollection.fromImages([pop15, pops_hornafrica]).mosaic()

Export.image.toDrive({
  image: pop15,
  description: 'pop15',
  scale: 30,
  maxPixels: 10000000000000, 
  fileFormat: 'GeoTIFF',
  crs : 'EPSG:4326'
});


var GHSSMOD2015 = ee.ImageCollection("JRC/GHSL/P2016/SMOD_POP_GLOBE_V1").filterDate('2014-01-01', '2016-01-01').median()

var pop15_urban = pop15.mask(GHSSMOD2015.gte(2).and(pop15.gt(0)))
var pop15_rural = pop15.mask(GHSSMOD2015.lte(1).and(pop15.gt(0)))

//
var Countries = ee.FeatureCollection('users/giacomofalchetta/gadm36_1');

//
var pop14_urban_AGO= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'AGO'))).divide((1+(pop_gr_14_AGO/100)*(((pop_urb15_AGO/pop_urb14_AGO)))))
var pop14_urban_BDI= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BDI'))).divide((1+(pop_gr_14_BDI/100)*(((pop_urb15_BDI/pop_urb14_BDI)))))
var pop14_urban_BEN= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BEN'))).divide((1+(pop_gr_14_BEN/100)*(((pop_urb15_BEN/pop_urb14_BEN)))))
var pop14_urban_BFA= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BFA'))).divide((1+(pop_gr_14_BFA/100)*(((pop_urb15_BFA/pop_urb14_BFA)))))
var pop14_urban_BWA= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BWA'))).divide((1+(pop_gr_14_BWA/100)*(((pop_urb15_BWA/pop_urb14_BWA)))))
var pop14_urban_CAF= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'CAF'))).divide((1+(pop_gr_14_CAF/100)*(((pop_urb15_CAF/pop_urb14_CAF)))))
var pop14_urban_CIV= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'CIV'))).divide((1+(pop_gr_14_CIV/100)*(((pop_urb15_CIV/pop_urb14_CIV)))))
var pop14_urban_CMR= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'CMR'))).divide((1+(pop_gr_14_CMR/100)*(((pop_urb15_CMR/pop_urb14_CMR)))))
var pop14_urban_COD= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'COD'))).divide((1+(pop_gr_14_COD/100)*(((pop_urb15_COD/pop_urb14_COD)))))
var pop14_urban_COG= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'COG'))).divide((1+(pop_gr_14_COG/100)*(((pop_urb15_COG/pop_urb14_COG)))))
var pop14_urban_ERI= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ERI'))).divide((1+(pop_gr_14_ERI/100)*(((pop_urb15_ERI/pop_urb14_ERI)))))
var pop14_urban_ETH= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ETH'))).divide((1+(pop_gr_14_ETH/100)*(((pop_urb15_ETH/pop_urb14_ETH)))))
var pop14_urban_GAB= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GAB'))).divide((1+(pop_gr_14_GAB/100)*(((pop_urb15_GAB/pop_urb14_GAB)))))
var pop14_urban_GHA= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GHA'))).divide((1+(pop_gr_14_GHA/100)*(((pop_urb15_GHA/pop_urb14_GHA)))))
var pop14_urban_GIN= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GIN'))).divide((1+(pop_gr_14_GIN/100)*(((pop_urb15_GIN/pop_urb14_GIN)))))
var pop14_urban_GMB= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GMB'))).divide((1+(pop_gr_14_GMB/100)*(((pop_urb15_GMB/pop_urb14_GMB)))))
var pop14_urban_GNB= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNB'))).divide((1+(pop_gr_14_GNB/100)*(((pop_urb15_GNB/pop_urb14_GNB)))))
var pop14_urban_GNQ= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNQ'))).divide((1+(pop_gr_14_GNQ/100)*(((pop_urb15_GNQ/pop_urb14_GNQ)))))
var pop14_urban_KEN= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'KEN'))).divide((1+(pop_gr_14_KEN/100)*(((pop_urb15_KEN/pop_urb14_KEN)))))
var pop14_urban_LBR= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'LBR'))).divide((1+(pop_gr_14_LBR/100)*(((pop_urb15_LBR/pop_urb14_LBR)))))
var pop14_urban_LSO= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'LSO'))).divide((1+(pop_gr_14_LSO/100)*(((pop_urb15_LSO/pop_urb14_LSO)))))
var pop14_urban_MDG= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MDG'))).divide((1+(pop_gr_14_MDG/100)*(((pop_urb15_MDG/pop_urb14_MDG)))))
var pop14_urban_MLI= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MLI'))).divide((1+(pop_gr_14_MLI/100)*(((pop_urb15_MLI/pop_urb14_MLI)))))
var pop14_urban_MOZ= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MOZ'))).divide((1+(pop_gr_14_MOZ/100)*(((pop_urb15_MOZ/pop_urb14_MOZ)))))
var pop14_urban_MRT= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MRT'))).divide((1+(pop_gr_14_MRT/100)*(((pop_urb15_MRT/pop_urb14_MRT)))))
var pop14_urban_MWI= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MWI'))).divide((1+(pop_gr_14_MWI/100)*(((pop_urb15_MWI/pop_urb14_MWI)))))
var pop14_urban_NAM= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'NAM'))).divide((1+(pop_gr_14_NAM/100)*(((pop_urb15_NAM/pop_urb14_NAM)))))
var pop14_urban_NER= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'NER'))).divide((1+(pop_gr_14_NER/100)*(((pop_urb15_NER/pop_urb14_NER)))))
var pop14_urban_NGA= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'NGA'))).divide((1+(pop_gr_14_NGA/100)*(((pop_urb15_NGA/pop_urb14_NGA)))))
var pop14_urban_RWA= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'RWA'))).divide((1+(pop_gr_14_RWA/100)*(((pop_urb15_RWA/pop_urb14_RWA)))))
var pop14_urban_SDN= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SDN'))).divide((1+(pop_gr_14_SDN/100)*(((pop_urb15_SDN/pop_urb14_SDN)))))
var pop14_urban_SEN= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SEN'))).divide((1+(pop_gr_14_SEN/100)*(((pop_urb15_SEN/pop_urb14_SEN)))))
var pop14_urban_SLE= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SLE'))).divide((1+(pop_gr_14_SLE/100)*(((pop_urb15_SLE/pop_urb14_SLE)))))
var pop14_urban_SOM= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SOM'))).divide((1+(pop_gr_14_SOM/100)*(((pop_urb15_SOM/pop_urb14_SOM)))))
var pop14_urban_SSD= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SSD'))).divide((1+(pop_gr_14_SSD/100)*(((pop_urb15_SSD/pop_urb14_SSD)))))
var pop14_urban_SWZ= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SWZ'))).divide((1+(pop_gr_14_SWZ/100)*(((pop_urb15_SWZ/pop_urb14_SWZ)))))
var pop14_urban_TCD= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'TCD'))).divide((1+(pop_gr_14_TCD/100)*(((pop_urb15_TCD/pop_urb14_TCD)))))
var pop14_urban_TGO= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'TGO'))).divide((1+(pop_gr_14_TGO/100)*(((pop_urb15_TGO/pop_urb14_TGO)))))
var pop14_urban_TZA= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'TZA'))).divide((1+(pop_gr_14_TZA/100)*(((pop_urb15_TZA/pop_urb14_TZA)))))
var pop14_urban_UGA= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'UGA'))).divide((1+(pop_gr_14_UGA/100)*(((pop_urb15_UGA/pop_urb14_UGA)))))
var pop14_urban_ZAF= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZAF'))).divide((1+(pop_gr_14_ZAF/100)*(((pop_urb15_ZAF/pop_urb14_ZAF)))))
var pop14_urban_ZMB= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZMB'))).divide((1+(pop_gr_14_ZMB/100)*(((pop_urb15_ZMB/pop_urb14_ZMB)))))
var pop14_urban_ZWE= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZWE'))).divide((1+(pop_gr_14_ZWE/100)*(((pop_urb15_ZWE/pop_urb14_ZWE)))))

var pop14_rural_AGO= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'AGO'))).divide((1+(pop_gr_14_AGO/100)*(((pop_rur15_AGO/pop_rur14_AGO)))))
var pop14_rural_BDI= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BDI'))).divide((1+(pop_gr_14_BDI/100)*(((pop_rur15_BDI/pop_rur14_BDI)))))
var pop14_rural_BEN= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BEN'))).divide((1+(pop_gr_14_BEN/100)*(((pop_rur15_BEN/pop_rur14_BEN)))))
var pop14_rural_BFA= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BFA'))).divide((1+(pop_gr_14_BFA/100)*(((pop_rur15_BFA/pop_rur14_BFA)))))
var pop14_rural_BWA= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BWA'))).divide((1+(pop_gr_14_BWA/100)*(((pop_rur15_BWA/pop_rur14_BWA)))))
var pop14_rural_CAF= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'CAF'))).divide((1+(pop_gr_14_CAF/100)*(((pop_rur15_CAF/pop_rur14_CAF)))))
var pop14_rural_CIV= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'CIV'))).divide((1+(pop_gr_14_CIV/100)*(((pop_rur15_CIV/pop_rur14_CIV)))))
var pop14_rural_CMR= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'CMR'))).divide((1+(pop_gr_14_CMR/100)*(((pop_rur15_CMR/pop_rur14_CMR)))))
var pop14_rural_COD= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'COD'))).divide((1+(pop_gr_14_COD/100)*(((pop_rur15_COD/pop_rur14_COD)))))
var pop14_rural_COG= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'COG'))).divide((1+(pop_gr_14_COG/100)*(((pop_rur15_COG/pop_rur14_COG)))))
var pop14_rural_ERI= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ERI'))).divide((1+(pop_gr_14_ERI/100)*(((pop_rur15_ERI/pop_rur14_ERI)))))
var pop14_rural_ETH= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ETH'))).divide((1+(pop_gr_14_ETH/100)*(((pop_rur15_ETH/pop_rur14_ETH)))))
var pop14_rural_GAB= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GAB'))).divide((1+(pop_gr_14_GAB/100)*(((pop_rur15_GAB/pop_rur14_GAB)))))
var pop14_rural_GHA= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GHA'))).divide((1+(pop_gr_14_GHA/100)*(((pop_rur15_GHA/pop_rur14_GHA)))))
var pop14_rural_GIN= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GIN'))).divide((1+(pop_gr_14_GIN/100)*(((pop_rur15_GIN/pop_rur14_GIN)))))
var pop14_rural_GMB= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GMB'))).divide((1+(pop_gr_14_GMB/100)*(((pop_rur15_GMB/pop_rur14_GMB)))))
var pop14_rural_GNB= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNB'))).divide((1+(pop_gr_14_GNB/100)*(((pop_rur15_GNB/pop_rur14_GNB)))))
var pop14_rural_GNQ= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNQ'))).divide((1+(pop_gr_14_GNQ/100)*(((pop_rur15_GNQ/pop_rur14_GNQ)))))
var pop14_rural_KEN= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'KEN'))).divide((1+(pop_gr_14_KEN/100)*(((pop_rur15_KEN/pop_rur14_KEN)))))
var pop14_rural_LBR= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'LBR'))).divide((1+(pop_gr_14_LBR/100)*(((pop_rur15_LBR/pop_rur14_LBR)))))
var pop14_rural_LSO= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'LSO'))).divide((1+(pop_gr_14_LSO/100)*(((pop_rur15_LSO/pop_rur14_LSO)))))
var pop14_rural_MDG= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MDG'))).divide((1+(pop_gr_14_MDG/100)*(((pop_rur15_MDG/pop_rur14_MDG)))))
var pop14_rural_MLI= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MLI'))).divide((1+(pop_gr_14_MLI/100)*(((pop_rur15_MLI/pop_rur14_MLI)))))
var pop14_rural_MOZ= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MOZ'))).divide((1+(pop_gr_14_MOZ/100)*(((pop_rur15_MOZ/pop_rur14_MOZ)))))
var pop14_rural_MRT= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MRT'))).divide((1+(pop_gr_14_MRT/100)*(((pop_rur15_MRT/pop_rur14_MRT)))))
var pop14_rural_MWI= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MWI'))).divide((1+(pop_gr_14_MWI/100)*(((pop_rur15_MWI/pop_rur14_MWI)))))
var pop14_rural_NAM= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'NAM'))).divide((1+(pop_gr_14_NAM/100)*(((pop_rur15_NAM/pop_rur14_NAM)))))
var pop14_rural_NER= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'NER'))).divide((1+(pop_gr_14_NER/100)*(((pop_rur15_NER/pop_rur14_NER)))))
var pop14_rural_NGA= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'NGA'))).divide((1+(pop_gr_14_NGA/100)*(((pop_rur15_NGA/pop_rur14_NGA)))))
var pop14_rural_RWA= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'RWA'))).divide((1+(pop_gr_14_RWA/100)*(((pop_rur15_RWA/pop_rur14_RWA)))))
var pop14_rural_SDN= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SDN'))).divide((1+(pop_gr_14_SDN/100)*(((pop_rur15_SDN/pop_rur14_SDN)))))
var pop14_rural_SEN= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SEN'))).divide((1+(pop_gr_14_SEN/100)*(((pop_rur15_SEN/pop_rur14_SEN)))))
var pop14_rural_SLE= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SLE'))).divide((1+(pop_gr_14_SLE/100)*(((pop_rur15_SLE/pop_rur14_SLE)))))
var pop14_rural_SOM= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SOM'))).divide((1+(pop_gr_14_SOM/100)*(((pop_rur15_SOM/pop_rur14_SOM)))))
var pop14_rural_SSD= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SSD'))).divide((1+(pop_gr_14_SSD/100)*(((pop_rur15_SSD/pop_rur14_SSD)))))
var pop14_rural_SWZ= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SWZ'))).divide((1+(pop_gr_14_SWZ/100)*(((pop_rur15_SWZ/pop_rur14_SWZ)))))
var pop14_rural_TCD= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'TCD'))).divide((1+(pop_gr_14_TCD/100)*(((pop_rur15_TCD/pop_rur14_TCD)))))
var pop14_rural_TGO= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'TGO'))).divide((1+(pop_gr_14_TGO/100)*(((pop_rur15_TGO/pop_rur14_TGO)))))
var pop14_rural_TZA= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'TZA'))).divide((1+(pop_gr_14_TZA/100)*(((pop_rur15_TZA/pop_rur14_TZA)))))
var pop14_rural_UGA= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'UGA'))).divide((1+(pop_gr_14_UGA/100)*(((pop_rur15_UGA/pop_rur14_UGA)))))
var pop14_rural_ZAF= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZAF'))).divide((1+(pop_gr_14_ZAF/100)*(((pop_rur15_ZAF/pop_rur14_ZAF)))))
var pop14_rural_ZMB= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZMB'))).divide((1+(pop_gr_14_ZMB/100)*(((pop_rur15_ZMB/pop_rur14_ZMB)))))
var pop14_rural_ZWE= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZWE'))).divide((1+(pop_gr_14_ZWE/100)*(((pop_rur15_ZWE/pop_rur14_ZWE)))))

var pop14 = ee.ImageCollection([pop14_urban_AGO,pop14_rural_AGO,pop14_urban_BDI,pop14_rural_BDI,pop14_urban_BEN,pop14_rural_BEN,pop14_urban_BFA,pop14_rural_BFA,pop14_urban_BWA,pop14_rural_BWA,pop14_urban_CAF,pop14_rural_CAF,pop14_urban_CIV,pop14_rural_CIV,pop14_urban_CMR,pop14_rural_CMR,pop14_urban_COD,pop14_rural_COD,pop14_urban_COG,pop14_rural_COG,pop14_urban_ERI,pop14_rural_ERI,pop14_urban_ETH,pop14_rural_ETH,pop14_urban_GAB,pop14_rural_GAB,pop14_urban_GHA,pop14_rural_GHA,pop14_urban_GIN,pop14_rural_GIN,pop14_urban_GMB,pop14_rural_GMB,pop14_urban_GNB,pop14_rural_GNB,pop14_urban_GNQ,pop14_rural_GNQ,pop14_urban_KEN,pop14_rural_KEN,pop14_urban_LBR,pop14_rural_LBR,pop14_urban_LSO,pop14_rural_LSO,pop14_urban_MDG,pop14_rural_MDG,pop14_urban_MLI,pop14_rural_MLI,pop14_urban_MOZ,pop14_rural_MOZ,pop14_urban_MRT,pop14_rural_MRT,pop14_urban_MWI,pop14_rural_MWI,pop14_urban_NAM,pop14_rural_NAM,pop14_urban_NER,pop14_rural_NER,pop14_urban_NGA,pop14_rural_NGA,pop14_urban_RWA,pop14_rural_RWA,pop14_urban_SDN,pop14_rural_SDN,pop14_urban_SEN,pop14_rural_SEN,pop14_urban_SLE,pop14_rural_SLE,pop14_urban_SOM,pop14_rural_SOM,pop14_urban_SSD,pop14_rural_SSD,pop14_urban_SWZ,pop14_rural_SWZ,pop14_urban_TCD,pop14_rural_TCD,pop14_urban_TGO,pop14_rural_TGO,pop14_urban_TZA,pop14_rural_TZA,pop14_urban_UGA,pop14_rural_UGA,pop14_urban_ZAF,pop14_rural_ZAF,pop14_urban_ZMB,pop14_rural_ZMB,pop14_urban_ZWE,pop14_rural_ZWE]).mosaic()
var pop14_urban = pop14.mask(GHSSMOD2015.gte(2).and(pop14.gt(0)))
var pop14_rural = pop14.mask(GHSSMOD2015.lte(1).and(pop14.gt(0)))

var pop16_urban_AGO= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'AGO'))).multiply((1+(pop_gr_16_AGO/100)*(((pop_urb16_AGO/pop_urb15_AGO)))))
var pop16_urban_BDI= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BDI'))).multiply((1+(pop_gr_16_BDI/100)*(((pop_urb16_BDI/pop_urb15_BDI)))))
var pop16_urban_BEN= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BEN'))).multiply((1+(pop_gr_16_BEN/100)*(((pop_urb16_BEN/pop_urb15_BEN)))))
var pop16_urban_BFA= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BFA'))).multiply((1+(pop_gr_16_BFA/100)*(((pop_urb16_BFA/pop_urb15_BFA)))))
var pop16_urban_BWA= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BWA'))).multiply((1+(pop_gr_16_BWA/100)*(((pop_urb16_BWA/pop_urb15_BWA)))))
var pop16_urban_CAF= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'CAF'))).multiply((1+(pop_gr_16_CAF/100)*(((pop_urb16_CAF/pop_urb15_CAF)))))
var pop16_urban_CIV= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'CIV'))).multiply((1+(pop_gr_16_CIV/100)*(((pop_urb16_CIV/pop_urb15_CIV)))))
var pop16_urban_CMR= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'CMR'))).multiply((1+(pop_gr_16_CMR/100)*(((pop_urb16_CMR/pop_urb15_CMR)))))
var pop16_urban_COD= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'COD'))).multiply((1+(pop_gr_16_COD/100)*(((pop_urb16_COD/pop_urb15_COD)))))
var pop16_urban_COG= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'COG'))).multiply((1+(pop_gr_16_COG/100)*(((pop_urb16_COG/pop_urb15_COG)))))
var pop16_urban_ERI= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ERI'))).multiply((1+(pop_gr_16_ERI/100)*(((pop_urb16_ERI/pop_urb15_ERI)))))
var pop16_urban_ETH= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ETH'))).multiply((1+(pop_gr_16_ETH/100)*(((pop_urb16_ETH/pop_urb15_ETH)))))
var pop16_urban_GAB= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GAB'))).multiply((1+(pop_gr_16_GAB/100)*(((pop_urb16_GAB/pop_urb15_GAB)))))
var pop16_urban_GHA= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GHA'))).multiply((1+(pop_gr_16_GHA/100)*(((pop_urb16_GHA/pop_urb15_GHA)))))
var pop16_urban_GIN= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GIN'))).multiply((1+(pop_gr_16_GIN/100)*(((pop_urb16_GIN/pop_urb15_GIN)))))
var pop16_urban_GMB= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GMB'))).multiply((1+(pop_gr_16_GMB/100)*(((pop_urb16_GMB/pop_urb15_GMB)))))
var pop16_urban_GNB= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNB'))).multiply((1+(pop_gr_16_GNB/100)*(((pop_urb16_GNB/pop_urb15_GNB)))))
var pop16_urban_GNQ= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNQ'))).multiply((1+(pop_gr_16_GNQ/100)*(((pop_urb16_GNQ/pop_urb15_GNQ)))))
var pop16_urban_KEN= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'KEN'))).multiply((1+(pop_gr_16_KEN/100)*(((pop_urb16_KEN/pop_urb15_KEN)))))
var pop16_urban_LBR= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'LBR'))).multiply((1+(pop_gr_16_LBR/100)*(((pop_urb16_LBR/pop_urb15_LBR)))))
var pop16_urban_LSO= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'LSO'))).multiply((1+(pop_gr_16_LSO/100)*(((pop_urb16_LSO/pop_urb15_LSO)))))
var pop16_urban_MDG= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MDG'))).multiply((1+(pop_gr_16_MDG/100)*(((pop_urb16_MDG/pop_urb15_MDG)))))
var pop16_urban_MLI= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MLI'))).multiply((1+(pop_gr_16_MLI/100)*(((pop_urb16_MLI/pop_urb15_MLI)))))
var pop16_urban_MOZ= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MOZ'))).multiply((1+(pop_gr_16_MOZ/100)*(((pop_urb16_MOZ/pop_urb15_MOZ)))))
var pop16_urban_MRT= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MRT'))).multiply((1+(pop_gr_16_MRT/100)*(((pop_urb16_MRT/pop_urb15_MRT)))))
var pop16_urban_MWI= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MWI'))).multiply((1+(pop_gr_16_MWI/100)*(((pop_urb16_MWI/pop_urb15_MWI)))))
var pop16_urban_NAM= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'NAM'))).multiply((1+(pop_gr_16_NAM/100)*(((pop_urb16_NAM/pop_urb15_NAM)))))
var pop16_urban_NER= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'NER'))).multiply((1+(pop_gr_16_NER/100)*(((pop_urb16_NER/pop_urb15_NER)))))
var pop16_urban_NGA= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'NGA'))).multiply((1+(pop_gr_16_NGA/100)*(((pop_urb16_NGA/pop_urb15_NGA)))))
var pop16_urban_RWA= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'RWA'))).multiply((1+(pop_gr_16_RWA/100)*(((pop_urb16_RWA/pop_urb15_RWA)))))
var pop16_urban_SDN= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SDN'))).multiply((1+(pop_gr_16_SDN/100)*(((pop_urb16_SDN/pop_urb15_SDN)))))
var pop16_urban_SEN= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SEN'))).multiply((1+(pop_gr_16_SEN/100)*(((pop_urb16_SEN/pop_urb15_SEN)))))
var pop16_urban_SLE= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SLE'))).multiply((1+(pop_gr_16_SLE/100)*(((pop_urb16_SLE/pop_urb15_SLE)))))
var pop16_urban_SOM= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SOM'))).multiply((1+(pop_gr_16_SOM/100)*(((pop_urb16_SOM/pop_urb15_SOM)))))
var pop16_urban_SSD= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SSD'))).multiply((1+(pop_gr_16_SSD/100)*(((pop_urb16_SSD/pop_urb15_SSD)))))
var pop16_urban_SWZ= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SWZ'))).multiply((1+(pop_gr_16_SWZ/100)*(((pop_urb16_SWZ/pop_urb15_SWZ)))))
var pop16_urban_TCD= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'TCD'))).multiply((1+(pop_gr_16_TCD/100)*(((pop_urb16_TCD/pop_urb15_TCD)))))
var pop16_urban_TGO= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'TGO'))).multiply((1+(pop_gr_16_TGO/100)*(((pop_urb16_TGO/pop_urb15_TGO)))))
var pop16_urban_TZA= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'TZA'))).multiply((1+(pop_gr_16_TZA/100)*(((pop_urb16_TZA/pop_urb15_TZA)))))
var pop16_urban_UGA= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'UGA'))).multiply((1+(pop_gr_16_UGA/100)*(((pop_urb16_UGA/pop_urb15_UGA)))))
var pop16_urban_ZAF= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZAF'))).multiply((1+(pop_gr_16_ZAF/100)*(((pop_urb16_ZAF/pop_urb15_ZAF)))))
var pop16_urban_ZMB= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZMB'))).multiply((1+(pop_gr_16_ZMB/100)*(((pop_urb16_ZMB/pop_urb15_ZMB)))))
var pop16_urban_ZWE= pop15_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZWE'))).multiply((1+(pop_gr_16_ZWE/100)*(((pop_urb16_ZWE/pop_urb15_ZWE)))))

var pop16_rural_AGO= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'AGO'))).multiply((1+(pop_gr_16_AGO/100)*(((pop_rur16_AGO/pop_rur15_AGO)))))
var pop16_rural_BDI= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BDI'))).multiply((1+(pop_gr_16_BDI/100)*(((pop_rur16_BDI/pop_rur15_BDI)))))
var pop16_rural_BEN= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BEN'))).multiply((1+(pop_gr_16_BEN/100)*(((pop_rur16_BEN/pop_rur15_BEN)))))
var pop16_rural_BFA= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BFA'))).multiply((1+(pop_gr_16_BFA/100)*(((pop_rur16_BFA/pop_rur15_BFA)))))
var pop16_rural_BWA= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BWA'))).multiply((1+(pop_gr_16_BWA/100)*(((pop_rur16_BWA/pop_rur15_BWA)))))
var pop16_rural_CAF= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'CAF'))).multiply((1+(pop_gr_16_CAF/100)*(((pop_rur16_CAF/pop_rur15_CAF)))))
var pop16_rural_CIV= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'CIV'))).multiply((1+(pop_gr_16_CIV/100)*(((pop_rur16_CIV/pop_rur15_CIV)))))
var pop16_rural_CMR= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'CMR'))).multiply((1+(pop_gr_16_CMR/100)*(((pop_rur16_CMR/pop_rur15_CMR)))))
var pop16_rural_COD= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'COD'))).multiply((1+(pop_gr_16_COD/100)*(((pop_rur16_COD/pop_rur15_COD)))))
var pop16_rural_COG= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'COG'))).multiply((1+(pop_gr_16_COG/100)*(((pop_rur16_COG/pop_rur15_COG)))))
var pop16_rural_ERI= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ERI'))).multiply((1+(pop_gr_16_ERI/100)*(((pop_rur16_ERI/pop_rur15_ERI)))))
var pop16_rural_ETH= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ETH'))).multiply((1+(pop_gr_16_ETH/100)*(((pop_rur16_ETH/pop_rur15_ETH)))))
var pop16_rural_GAB= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GAB'))).multiply((1+(pop_gr_16_GAB/100)*(((pop_rur16_GAB/pop_rur15_GAB)))))
var pop16_rural_GHA= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GHA'))).multiply((1+(pop_gr_16_GHA/100)*(((pop_rur16_GHA/pop_rur15_GHA)))))
var pop16_rural_GIN= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GIN'))).multiply((1+(pop_gr_16_GIN/100)*(((pop_rur16_GIN/pop_rur15_GIN)))))
var pop16_rural_GMB= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GMB'))).multiply((1+(pop_gr_16_GMB/100)*(((pop_rur16_GMB/pop_rur15_GMB)))))
var pop16_rural_GNB= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNB'))).multiply((1+(pop_gr_16_GNB/100)*(((pop_rur16_GNB/pop_rur15_GNB)))))
var pop16_rural_GNQ= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNQ'))).multiply((1+(pop_gr_16_GNQ/100)*(((pop_rur16_GNQ/pop_rur15_GNQ)))))
var pop16_rural_KEN= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'KEN'))).multiply((1+(pop_gr_16_KEN/100)*(((pop_rur16_KEN/pop_rur15_KEN)))))
var pop16_rural_LBR= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'LBR'))).multiply((1+(pop_gr_16_LBR/100)*(((pop_rur16_LBR/pop_rur15_LBR)))))
var pop16_rural_LSO= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'LSO'))).multiply((1+(pop_gr_16_LSO/100)*(((pop_rur16_LSO/pop_rur15_LSO)))))
var pop16_rural_MDG= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MDG'))).multiply((1+(pop_gr_16_MDG/100)*(((pop_rur16_MDG/pop_rur15_MDG)))))
var pop16_rural_MLI= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MLI'))).multiply((1+(pop_gr_16_MLI/100)*(((pop_rur16_MLI/pop_rur15_MLI)))))
var pop16_rural_MOZ= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MOZ'))).multiply((1+(pop_gr_16_MOZ/100)*(((pop_rur16_MOZ/pop_rur15_MOZ)))))
var pop16_rural_MRT= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MRT'))).multiply((1+(pop_gr_16_MRT/100)*(((pop_rur16_MRT/pop_rur15_MRT)))))
var pop16_rural_MWI= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MWI'))).multiply((1+(pop_gr_16_MWI/100)*(((pop_rur16_MWI/pop_rur15_MWI)))))
var pop16_rural_NAM= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'NAM'))).multiply((1+(pop_gr_16_NAM/100)*(((pop_rur16_NAM/pop_rur15_NAM)))))
var pop16_rural_NER= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'NER'))).multiply((1+(pop_gr_16_NER/100)*(((pop_rur16_NER/pop_rur15_NER)))))
var pop16_rural_NGA= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'NGA'))).multiply((1+(pop_gr_16_NGA/100)*(((pop_rur16_NGA/pop_rur15_NGA)))))
var pop16_rural_RWA= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'RWA'))).multiply((1+(pop_gr_16_RWA/100)*(((pop_rur16_RWA/pop_rur15_RWA)))))
var pop16_rural_SDN= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SDN'))).multiply((1+(pop_gr_16_SDN/100)*(((pop_rur16_SDN/pop_rur15_SDN)))))
var pop16_rural_SEN= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SEN'))).multiply((1+(pop_gr_16_SEN/100)*(((pop_rur16_SEN/pop_rur15_SEN)))))
var pop16_rural_SLE= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SLE'))).multiply((1+(pop_gr_16_SLE/100)*(((pop_rur16_SLE/pop_rur15_SLE)))))
var pop16_rural_SOM= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SOM'))).multiply((1+(pop_gr_16_SOM/100)*(((pop_rur16_SOM/pop_rur15_SOM)))))
var pop16_rural_SSD= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SSD'))).multiply((1+(pop_gr_16_SSD/100)*(((pop_rur16_SSD/pop_rur15_SSD)))))
var pop16_rural_SWZ= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SWZ'))).multiply((1+(pop_gr_16_SWZ/100)*(((pop_rur16_SWZ/pop_rur15_SWZ)))))
var pop16_rural_TCD= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'TCD'))).multiply((1+(pop_gr_16_TCD/100)*(((pop_rur16_TCD/pop_rur15_TCD)))))
var pop16_rural_TGO= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'TGO'))).multiply((1+(pop_gr_16_TGO/100)*(((pop_rur16_TGO/pop_rur15_TGO)))))
var pop16_rural_TZA= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'TZA'))).multiply((1+(pop_gr_16_TZA/100)*(((pop_rur16_TZA/pop_rur15_TZA)))))
var pop16_rural_UGA= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'UGA'))).multiply((1+(pop_gr_16_UGA/100)*(((pop_rur16_UGA/pop_rur15_UGA)))))
var pop16_rural_ZAF= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZAF'))).multiply((1+(pop_gr_16_ZAF/100)*(((pop_rur16_ZAF/pop_rur15_ZAF)))))
var pop16_rural_ZMB= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZMB'))).multiply((1+(pop_gr_16_ZMB/100)*(((pop_rur16_ZMB/pop_rur15_ZMB)))))
var pop16_rural_ZWE= pop15_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZWE'))).multiply((1+(pop_gr_16_ZWE/100)*(((pop_rur16_ZWE/pop_rur15_ZWE)))))

var pop16 = ee.ImageCollection([pop16_urban_AGO,pop16_rural_AGO,pop16_urban_BDI,pop16_rural_BDI,pop16_urban_BEN,pop16_rural_BEN,pop16_urban_BFA,pop16_rural_BFA,pop16_urban_BWA,pop16_rural_BWA,pop16_urban_CAF,pop16_rural_CAF,pop16_urban_CIV,pop16_rural_CIV,pop16_urban_CMR,pop16_rural_CMR,pop16_urban_COD,pop16_rural_COD,pop16_urban_COG,pop16_rural_COG,pop16_urban_ERI,pop16_rural_ERI,pop16_urban_ETH,pop16_rural_ETH,pop16_urban_GAB,pop16_rural_GAB,pop16_urban_GHA,pop16_rural_GHA,pop16_urban_GIN,pop16_rural_GIN,pop16_urban_GMB,pop16_rural_GMB,pop16_urban_GNB,pop16_rural_GNB,pop16_urban_GNQ,pop16_rural_GNQ,pop16_urban_KEN,pop16_rural_KEN,pop16_urban_LBR,pop16_rural_LBR,pop16_urban_LSO,pop16_rural_LSO,pop16_urban_MDG,pop16_rural_MDG,pop16_urban_MLI,pop16_rural_MLI,pop16_urban_MOZ,pop16_rural_MOZ,pop16_urban_MRT,pop16_rural_MRT,pop16_urban_MWI,pop16_rural_MWI,pop16_urban_NAM,pop16_rural_NAM,pop16_urban_NER,pop16_rural_NER,pop16_urban_NGA,pop16_rural_NGA,pop16_urban_RWA,pop16_rural_RWA,pop16_urban_SDN,pop16_rural_SDN,pop16_urban_SEN,pop16_rural_SEN,pop16_urban_SLE,pop16_rural_SLE,pop16_urban_SOM,pop16_rural_SOM,pop16_urban_SSD,pop16_rural_SSD,pop16_urban_SWZ,pop16_rural_SWZ,pop16_urban_TCD,pop16_rural_TCD,pop16_urban_TGO,pop16_rural_TGO,pop16_urban_TZA,pop16_rural_TZA,pop16_urban_UGA,pop16_rural_UGA,pop16_urban_ZAF,pop16_rural_ZAF,pop16_urban_ZMB,pop16_rural_ZMB,pop16_urban_ZWE,pop16_rural_ZWE]).mosaic()
var pop16_urban = pop16.mask(GHSSMOD2015.gte(2).and(pop16.gt(0)))
var pop16_rural = pop16.mask(GHSSMOD2015.lte(1).and(pop16.gt(0)))

var pop17_urban_AGO= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'AGO'))).multiply((1+(pop_gr_17_AGO/100)*(((pop_urb17_AGO/pop_urb16_AGO)))))
var pop17_urban_BDI= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BDI'))).multiply((1+(pop_gr_17_BDI/100)*(((pop_urb17_BDI/pop_urb16_BDI)))))
var pop17_urban_BEN= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BEN'))).multiply((1+(pop_gr_17_BEN/100)*(((pop_urb17_BEN/pop_urb16_BEN)))))
var pop17_urban_BFA= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BFA'))).multiply((1+(pop_gr_17_BFA/100)*(((pop_urb17_BFA/pop_urb16_BFA)))))
var pop17_urban_BWA= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BWA'))).multiply((1+(pop_gr_17_BWA/100)*(((pop_urb17_BWA/pop_urb16_BWA)))))
var pop17_urban_CAF= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'CAF'))).multiply((1+(pop_gr_17_CAF/100)*(((pop_urb17_CAF/pop_urb16_CAF)))))
var pop17_urban_CIV= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'CIV'))).multiply((1+(pop_gr_17_CIV/100)*(((pop_urb17_CIV/pop_urb16_CIV)))))
var pop17_urban_CMR= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'CMR'))).multiply((1+(pop_gr_17_CMR/100)*(((pop_urb17_CMR/pop_urb16_CMR)))))
var pop17_urban_COD= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'COD'))).multiply((1+(pop_gr_17_COD/100)*(((pop_urb17_COD/pop_urb16_COD)))))
var pop17_urban_COG= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'COG'))).multiply((1+(pop_gr_17_COG/100)*(((pop_urb17_COG/pop_urb16_COG)))))
var pop17_urban_ERI= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ERI'))).multiply((1+(pop_gr_17_ERI/100)*(((pop_urb17_ERI/pop_urb16_ERI)))))
var pop17_urban_ETH= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ETH'))).multiply((1+(pop_gr_17_ETH/100)*(((pop_urb17_ETH/pop_urb16_ETH)))))
var pop17_urban_GAB= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GAB'))).multiply((1+(pop_gr_17_GAB/100)*(((pop_urb17_GAB/pop_urb16_GAB)))))
var pop17_urban_GHA= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GHA'))).multiply((1+(pop_gr_17_GHA/100)*(((pop_urb17_GHA/pop_urb16_GHA)))))
var pop17_urban_GIN= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GIN'))).multiply((1+(pop_gr_17_GIN/100)*(((pop_urb17_GIN/pop_urb16_GIN)))))
var pop17_urban_GMB= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GMB'))).multiply((1+(pop_gr_17_GMB/100)*(((pop_urb17_GMB/pop_urb16_GMB)))))
var pop17_urban_GNB= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNB'))).multiply((1+(pop_gr_17_GNB/100)*(((pop_urb17_GNB/pop_urb16_GNB)))))
var pop17_urban_GNQ= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNQ'))).multiply((1+(pop_gr_17_GNQ/100)*(((pop_urb17_GNQ/pop_urb16_GNQ)))))
var pop17_urban_KEN= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'KEN'))).multiply((1+(pop_gr_17_KEN/100)*(((pop_urb17_KEN/pop_urb16_KEN)))))
var pop17_urban_LBR= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'LBR'))).multiply((1+(pop_gr_17_LBR/100)*(((pop_urb17_LBR/pop_urb16_LBR)))))
var pop17_urban_LSO= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'LSO'))).multiply((1+(pop_gr_17_LSO/100)*(((pop_urb17_LSO/pop_urb16_LSO)))))
var pop17_urban_MDG= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MDG'))).multiply((1+(pop_gr_17_MDG/100)*(((pop_urb17_MDG/pop_urb16_MDG)))))
var pop17_urban_MLI= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MLI'))).multiply((1+(pop_gr_17_MLI/100)*(((pop_urb17_MLI/pop_urb16_MLI)))))
var pop17_urban_MOZ= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MOZ'))).multiply((1+(pop_gr_17_MOZ/100)*(((pop_urb17_MOZ/pop_urb16_MOZ)))))
var pop17_urban_MRT= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MRT'))).multiply((1+(pop_gr_17_MRT/100)*(((pop_urb17_MRT/pop_urb16_MRT)))))
var pop17_urban_MWI= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MWI'))).multiply((1+(pop_gr_17_MWI/100)*(((pop_urb17_MWI/pop_urb16_MWI)))))
var pop17_urban_NAM= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'NAM'))).multiply((1+(pop_gr_17_NAM/100)*(((pop_urb17_NAM/pop_urb16_NAM)))))
var pop17_urban_NER= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'NER'))).multiply((1+(pop_gr_17_NER/100)*(((pop_urb17_NER/pop_urb16_NER)))))
var pop17_urban_NGA= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'NGA'))).multiply((1+(pop_gr_17_NGA/100)*(((pop_urb17_NGA/pop_urb16_NGA)))))
var pop17_urban_RWA= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'RWA'))).multiply((1+(pop_gr_17_RWA/100)*(((pop_urb17_RWA/pop_urb16_RWA)))))
var pop17_urban_SDN= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SDN'))).multiply((1+(pop_gr_17_SDN/100)*(((pop_urb17_SDN/pop_urb16_SDN)))))
var pop17_urban_SEN= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SEN'))).multiply((1+(pop_gr_17_SEN/100)*(((pop_urb17_SEN/pop_urb16_SEN)))))
var pop17_urban_SLE= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SLE'))).multiply((1+(pop_gr_17_SLE/100)*(((pop_urb17_SLE/pop_urb16_SLE)))))
var pop17_urban_SOM= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SOM'))).multiply((1+(pop_gr_17_SOM/100)*(((pop_urb17_SOM/pop_urb16_SOM)))))
var pop17_urban_SSD= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SSD'))).multiply((1+(pop_gr_17_SSD/100)*(((pop_urb17_SSD/pop_urb16_SSD)))))
var pop17_urban_SWZ= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SWZ'))).multiply((1+(pop_gr_17_SWZ/100)*(((pop_urb17_SWZ/pop_urb16_SWZ)))))
var pop17_urban_TCD= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'TCD'))).multiply((1+(pop_gr_17_TCD/100)*(((pop_urb17_TCD/pop_urb16_TCD)))))
var pop17_urban_TGO= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'TGO'))).multiply((1+(pop_gr_17_TGO/100)*(((pop_urb17_TGO/pop_urb16_TGO)))))
var pop17_urban_TZA= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'TZA'))).multiply((1+(pop_gr_17_TZA/100)*(((pop_urb17_TZA/pop_urb16_TZA)))))
var pop17_urban_UGA= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'UGA'))).multiply((1+(pop_gr_17_UGA/100)*(((pop_urb17_UGA/pop_urb16_UGA)))))
var pop17_urban_ZAF= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZAF'))).multiply((1+(pop_gr_17_ZAF/100)*(((pop_urb17_ZAF/pop_urb16_ZAF)))))
var pop17_urban_ZMB= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZMB'))).multiply((1+(pop_gr_17_ZMB/100)*(((pop_urb17_ZMB/pop_urb16_ZMB)))))
var pop17_urban_ZWE= pop16_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZWE'))).multiply((1+(pop_gr_17_ZWE/100)*(((pop_urb17_ZWE/pop_urb16_ZWE)))))

var pop17_rural_AGO= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'AGO'))).multiply((1+(pop_gr_17_AGO/100)*(((pop_rur17_AGO/pop_rur16_AGO)))))
var pop17_rural_BDI= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BDI'))).multiply((1+(pop_gr_17_BDI/100)*(((pop_rur17_BDI/pop_rur16_BDI)))))
var pop17_rural_BEN= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BEN'))).multiply((1+(pop_gr_17_BEN/100)*(((pop_rur17_BEN/pop_rur16_BEN)))))
var pop17_rural_BFA= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BFA'))).multiply((1+(pop_gr_17_BFA/100)*(((pop_rur17_BFA/pop_rur16_BFA)))))
var pop17_rural_BWA= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BWA'))).multiply((1+(pop_gr_17_BWA/100)*(((pop_rur17_BWA/pop_rur16_BWA)))))
var pop17_rural_CAF= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'CAF'))).multiply((1+(pop_gr_17_CAF/100)*(((pop_rur17_CAF/pop_rur16_CAF)))))
var pop17_rural_CIV= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'CIV'))).multiply((1+(pop_gr_17_CIV/100)*(((pop_rur17_CIV/pop_rur16_CIV)))))
var pop17_rural_CMR= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'CMR'))).multiply((1+(pop_gr_17_CMR/100)*(((pop_rur17_CMR/pop_rur16_CMR)))))
var pop17_rural_COD= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'COD'))).multiply((1+(pop_gr_17_COD/100)*(((pop_rur17_COD/pop_rur16_COD)))))
var pop17_rural_COG= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'COG'))).multiply((1+(pop_gr_17_COG/100)*(((pop_rur17_COG/pop_rur16_COG)))))
var pop17_rural_ERI= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ERI'))).multiply((1+(pop_gr_17_ERI/100)*(((pop_rur17_ERI/pop_rur16_ERI)))))
var pop17_rural_ETH= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ETH'))).multiply((1+(pop_gr_17_ETH/100)*(((pop_rur17_ETH/pop_rur16_ETH)))))
var pop17_rural_GAB= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GAB'))).multiply((1+(pop_gr_17_GAB/100)*(((pop_rur17_GAB/pop_rur16_GAB)))))
var pop17_rural_GHA= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GHA'))).multiply((1+(pop_gr_17_GHA/100)*(((pop_rur17_GHA/pop_rur16_GHA)))))
var pop17_rural_GIN= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GIN'))).multiply((1+(pop_gr_17_GIN/100)*(((pop_rur17_GIN/pop_rur16_GIN)))))
var pop17_rural_GMB= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GMB'))).multiply((1+(pop_gr_17_GMB/100)*(((pop_rur17_GMB/pop_rur16_GMB)))))
var pop17_rural_GNB= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNB'))).multiply((1+(pop_gr_17_GNB/100)*(((pop_rur17_GNB/pop_rur16_GNB)))))
var pop17_rural_GNQ= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNQ'))).multiply((1+(pop_gr_17_GNQ/100)*(((pop_rur17_GNQ/pop_rur16_GNQ)))))
var pop17_rural_KEN= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'KEN'))).multiply((1+(pop_gr_17_KEN/100)*(((pop_rur17_KEN/pop_rur16_KEN)))))
var pop17_rural_LBR= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'LBR'))).multiply((1+(pop_gr_17_LBR/100)*(((pop_rur17_LBR/pop_rur16_LBR)))))
var pop17_rural_LSO= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'LSO'))).multiply((1+(pop_gr_17_LSO/100)*(((pop_rur17_LSO/pop_rur16_LSO)))))
var pop17_rural_MDG= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MDG'))).multiply((1+(pop_gr_17_MDG/100)*(((pop_rur17_MDG/pop_rur16_MDG)))))
var pop17_rural_MLI= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MLI'))).multiply((1+(pop_gr_17_MLI/100)*(((pop_rur17_MLI/pop_rur16_MLI)))))
var pop17_rural_MOZ= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MOZ'))).multiply((1+(pop_gr_17_MOZ/100)*(((pop_rur17_MOZ/pop_rur16_MOZ)))))
var pop17_rural_MRT= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MRT'))).multiply((1+(pop_gr_17_MRT/100)*(((pop_rur17_MRT/pop_rur16_MRT)))))
var pop17_rural_MWI= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MWI'))).multiply((1+(pop_gr_17_MWI/100)*(((pop_rur17_MWI/pop_rur16_MWI)))))
var pop17_rural_NAM= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'NAM'))).multiply((1+(pop_gr_17_NAM/100)*(((pop_rur17_NAM/pop_rur16_NAM)))))
var pop17_rural_NER= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'NER'))).multiply((1+(pop_gr_17_NER/100)*(((pop_rur17_NER/pop_rur16_NER)))))
var pop17_rural_NGA= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'NGA'))).multiply((1+(pop_gr_17_NGA/100)*(((pop_rur17_NGA/pop_rur16_NGA)))))
var pop17_rural_RWA= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'RWA'))).multiply((1+(pop_gr_17_RWA/100)*(((pop_rur17_RWA/pop_rur16_RWA)))))
var pop17_rural_SDN= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SDN'))).multiply((1+(pop_gr_17_SDN/100)*(((pop_rur17_SDN/pop_rur16_SDN)))))
var pop17_rural_SEN= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SEN'))).multiply((1+(pop_gr_17_SEN/100)*(((pop_rur17_SEN/pop_rur16_SEN)))))
var pop17_rural_SLE= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SLE'))).multiply((1+(pop_gr_17_SLE/100)*(((pop_rur17_SLE/pop_rur16_SLE)))))
var pop17_rural_SOM= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SOM'))).multiply((1+(pop_gr_17_SOM/100)*(((pop_rur17_SOM/pop_rur16_SOM)))))
var pop17_rural_SSD= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SSD'))).multiply((1+(pop_gr_17_SSD/100)*(((pop_rur17_SSD/pop_rur16_SSD)))))
var pop17_rural_SWZ= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SWZ'))).multiply((1+(pop_gr_17_SWZ/100)*(((pop_rur17_SWZ/pop_rur16_SWZ)))))
var pop17_rural_TCD= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'TCD'))).multiply((1+(pop_gr_17_TCD/100)*(((pop_rur17_TCD/pop_rur16_TCD)))))
var pop17_rural_TGO= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'TGO'))).multiply((1+(pop_gr_17_TGO/100)*(((pop_rur17_TGO/pop_rur16_TGO)))))
var pop17_rural_TZA= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'TZA'))).multiply((1+(pop_gr_17_TZA/100)*(((pop_rur17_TZA/pop_rur16_TZA)))))
var pop17_rural_UGA= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'UGA'))).multiply((1+(pop_gr_17_UGA/100)*(((pop_rur17_UGA/pop_rur16_UGA)))))
var pop17_rural_ZAF= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZAF'))).multiply((1+(pop_gr_17_ZAF/100)*(((pop_rur17_ZAF/pop_rur16_ZAF)))))
var pop17_rural_ZMB= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZMB'))).multiply((1+(pop_gr_17_ZMB/100)*(((pop_rur17_ZMB/pop_rur16_ZMB)))))
var pop17_rural_ZWE= pop16_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZWE'))).multiply((1+(pop_gr_17_ZWE/100)*(((pop_rur17_ZWE/pop_rur16_ZWE)))))

var pop17 = ee.ImageCollection([pop17_urban_AGO,pop17_rural_AGO,pop17_urban_BDI,pop17_rural_BDI,pop17_urban_BEN,pop17_rural_BEN,pop17_urban_BFA,pop17_rural_BFA,pop17_urban_BWA,pop17_rural_BWA,pop17_urban_CAF,pop17_rural_CAF,pop17_urban_CIV,pop17_rural_CIV,pop17_urban_CMR,pop17_rural_CMR,pop17_urban_COD,pop17_rural_COD,pop17_urban_COG,pop17_rural_COG,pop17_urban_ERI,pop17_rural_ERI,pop17_urban_ETH,pop17_rural_ETH,pop17_urban_GAB,pop17_rural_GAB,pop17_urban_GHA,pop17_rural_GHA,pop17_urban_GIN,pop17_rural_GIN,pop17_urban_GMB,pop17_rural_GMB,pop17_urban_GNB,pop17_rural_GNB,pop17_urban_GNQ,pop17_rural_GNQ,pop17_urban_KEN,pop17_rural_KEN,pop17_urban_LBR,pop17_rural_LBR,pop17_urban_LSO,pop17_rural_LSO,pop17_urban_MDG,pop17_rural_MDG,pop17_urban_MLI,pop17_rural_MLI,pop17_urban_MOZ,pop17_rural_MOZ,pop17_urban_MRT,pop17_rural_MRT,pop17_urban_MWI,pop17_rural_MWI,pop17_urban_NAM,pop17_rural_NAM,pop17_urban_NER,pop17_rural_NER,pop17_urban_NGA,pop17_rural_NGA,pop17_urban_RWA,pop17_rural_RWA,pop17_urban_SDN,pop17_rural_SDN,pop17_urban_SEN,pop17_rural_SEN,pop17_urban_SLE,pop17_rural_SLE,pop17_urban_SOM,pop17_rural_SOM,pop17_urban_SSD,pop17_rural_SSD,pop17_urban_SWZ,pop17_rural_SWZ,pop17_urban_TCD,pop17_rural_TCD,pop17_urban_TGO,pop17_rural_TGO,pop17_urban_TZA,pop17_rural_TZA,pop17_urban_UGA,pop17_rural_UGA,pop17_urban_ZAF,pop17_rural_ZAF,pop17_urban_ZMB,pop17_rural_ZMB,pop17_urban_ZWE,pop17_rural_ZWE]).mosaic()
var pop17_urban = pop17.mask(GHSSMOD2015.gte(2).and(pop17.gt(0)))
var pop17_rural = pop17.mask(GHSSMOD2015.lte(1).and(pop17.gt(0)))

var pop18_urban_AGO= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'AGO'))).multiply((1+(pop_gr_18_AGO/100)*(((pop_urb18_AGO/pop_urb17_AGO)))))
var pop18_urban_BDI= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BDI'))).multiply((1+(pop_gr_18_BDI/100)*(((pop_urb18_BDI/pop_urb17_BDI)))))
var pop18_urban_BEN= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BEN'))).multiply((1+(pop_gr_18_BEN/100)*(((pop_urb18_BEN/pop_urb17_BEN)))))
var pop18_urban_BFA= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BFA'))).multiply((1+(pop_gr_18_BFA/100)*(((pop_urb18_BFA/pop_urb17_BFA)))))
var pop18_urban_BWA= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BWA'))).multiply((1+(pop_gr_18_BWA/100)*(((pop_urb18_BWA/pop_urb17_BWA)))))
var pop18_urban_CAF= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'CAF'))).multiply((1+(pop_gr_18_CAF/100)*(((pop_urb18_CAF/pop_urb17_CAF)))))
var pop18_urban_CIV= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'CIV'))).multiply((1+(pop_gr_18_CIV/100)*(((pop_urb18_CIV/pop_urb17_CIV)))))
var pop18_urban_CMR= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'CMR'))).multiply((1+(pop_gr_18_CMR/100)*(((pop_urb18_CMR/pop_urb17_CMR)))))
var pop18_urban_COD= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'COD'))).multiply((1+(pop_gr_18_COD/100)*(((pop_urb18_COD/pop_urb17_COD)))))
var pop18_urban_COG= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'COG'))).multiply((1+(pop_gr_18_COG/100)*(((pop_urb18_COG/pop_urb17_COG)))))
var pop18_urban_ERI= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ERI'))).multiply((1+(pop_gr_18_ERI/100)*(((pop_urb18_ERI/pop_urb17_ERI)))))
var pop18_urban_ETH= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ETH'))).multiply((1+(pop_gr_18_ETH/100)*(((pop_urb18_ETH/pop_urb17_ETH)))))
var pop18_urban_GAB= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GAB'))).multiply((1+(pop_gr_18_GAB/100)*(((pop_urb18_GAB/pop_urb17_GAB)))))
var pop18_urban_GHA= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GHA'))).multiply((1+(pop_gr_18_GHA/100)*(((pop_urb18_GHA/pop_urb17_GHA)))))
var pop18_urban_GIN= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GIN'))).multiply((1+(pop_gr_18_GIN/100)*(((pop_urb18_GIN/pop_urb17_GIN)))))
var pop18_urban_GMB= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GMB'))).multiply((1+(pop_gr_18_GMB/100)*(((pop_urb18_GMB/pop_urb17_GMB)))))
var pop18_urban_GNB= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNB'))).multiply((1+(pop_gr_18_GNB/100)*(((pop_urb18_GNB/pop_urb17_GNB)))))
var pop18_urban_GNQ= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNQ'))).multiply((1+(pop_gr_18_GNQ/100)*(((pop_urb18_GNQ/pop_urb17_GNQ)))))
var pop18_urban_KEN= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'KEN'))).multiply((1+(pop_gr_18_KEN/100)*(((pop_urb18_KEN/pop_urb17_KEN)))))
var pop18_urban_LBR= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'LBR'))).multiply((1+(pop_gr_18_LBR/100)*(((pop_urb18_LBR/pop_urb17_LBR)))))
var pop18_urban_LSO= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'LSO'))).multiply((1+(pop_gr_18_LSO/100)*(((pop_urb18_LSO/pop_urb17_LSO)))))
var pop18_urban_MDG= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MDG'))).multiply((1+(pop_gr_18_MDG/100)*(((pop_urb18_MDG/pop_urb17_MDG)))))
var pop18_urban_MLI= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MLI'))).multiply((1+(pop_gr_18_MLI/100)*(((pop_urb18_MLI/pop_urb17_MLI)))))
var pop18_urban_MOZ= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MOZ'))).multiply((1+(pop_gr_18_MOZ/100)*(((pop_urb18_MOZ/pop_urb17_MOZ)))))
var pop18_urban_MRT= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MRT'))).multiply((1+(pop_gr_18_MRT/100)*(((pop_urb18_MRT/pop_urb17_MRT)))))
var pop18_urban_MWI= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MWI'))).multiply((1+(pop_gr_18_MWI/100)*(((pop_urb18_MWI/pop_urb17_MWI)))))
var pop18_urban_NAM= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'NAM'))).multiply((1+(pop_gr_18_NAM/100)*(((pop_urb18_NAM/pop_urb17_NAM)))))
var pop18_urban_NER= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'NER'))).multiply((1+(pop_gr_18_NER/100)*(((pop_urb18_NER/pop_urb17_NER)))))
var pop18_urban_NGA= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'NGA'))).multiply((1+(pop_gr_18_NGA/100)*(((pop_urb18_NGA/pop_urb17_NGA)))))
var pop18_urban_RWA= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'RWA'))).multiply((1+(pop_gr_18_RWA/100)*(((pop_urb18_RWA/pop_urb17_RWA)))))
var pop18_urban_SDN= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SDN'))).multiply((1+(pop_gr_18_SDN/100)*(((pop_urb18_SDN/pop_urb17_SDN)))))
var pop18_urban_SEN= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SEN'))).multiply((1+(pop_gr_18_SEN/100)*(((pop_urb18_SEN/pop_urb17_SEN)))))
var pop18_urban_SLE= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SLE'))).multiply((1+(pop_gr_18_SLE/100)*(((pop_urb18_SLE/pop_urb17_SLE)))))
var pop18_urban_SOM= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SOM'))).multiply((1+(pop_gr_18_SOM/100)*(((pop_urb18_SOM/pop_urb17_SOM)))))
var pop18_urban_SSD= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SSD'))).multiply((1+(pop_gr_18_SSD/100)*(((pop_urb18_SSD/pop_urb17_SSD)))))
var pop18_urban_SWZ= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SWZ'))).multiply((1+(pop_gr_18_SWZ/100)*(((pop_urb18_SWZ/pop_urb17_SWZ)))))
var pop18_urban_TCD= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'TCD'))).multiply((1+(pop_gr_18_TCD/100)*(((pop_urb18_TCD/pop_urb17_TCD)))))
var pop18_urban_TGO= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'TGO'))).multiply((1+(pop_gr_18_TGO/100)*(((pop_urb18_TGO/pop_urb17_TGO)))))
var pop18_urban_TZA= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'TZA'))).multiply((1+(pop_gr_18_TZA/100)*(((pop_urb18_TZA/pop_urb17_TZA)))))
var pop18_urban_UGA= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'UGA'))).multiply((1+(pop_gr_18_UGA/100)*(((pop_urb18_UGA/pop_urb17_UGA)))))
var pop18_urban_ZAF= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZAF'))).multiply((1+(pop_gr_18_ZAF/100)*(((pop_urb18_ZAF/pop_urb17_ZAF)))))
var pop18_urban_ZMB= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZMB'))).multiply((1+(pop_gr_18_ZMB/100)*(((pop_urb18_ZMB/pop_urb17_ZMB)))))
var pop18_urban_ZWE= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZWE'))).multiply((1+(pop_gr_18_ZWE/100)*(((pop_urb18_ZWE/pop_urb17_ZWE)))))

var pop18_rural_AGO= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'AGO'))).multiply((1+(pop_gr_18_AGO/100)*(((pop_rur18_AGO/pop_rur17_AGO)))))
var pop18_rural_BDI= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BDI'))).multiply((1+(pop_gr_18_BDI/100)*(((pop_rur18_BDI/pop_rur17_BDI)))))
var pop18_rural_BEN= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BEN'))).multiply((1+(pop_gr_18_BEN/100)*(((pop_rur18_BEN/pop_rur17_BEN)))))
var pop18_rural_BFA= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BFA'))).multiply((1+(pop_gr_18_BFA/100)*(((pop_rur18_BFA/pop_rur17_BFA)))))
var pop18_rural_BWA= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BWA'))).multiply((1+(pop_gr_18_BWA/100)*(((pop_rur18_BWA/pop_rur17_BWA)))))
var pop18_rural_CAF= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'CAF'))).multiply((1+(pop_gr_18_CAF/100)*(((pop_rur18_CAF/pop_rur17_CAF)))))
var pop18_rural_CIV= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'CIV'))).multiply((1+(pop_gr_18_CIV/100)*(((pop_rur18_CIV/pop_rur17_CIV)))))
var pop18_rural_CMR= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'CMR'))).multiply((1+(pop_gr_18_CMR/100)*(((pop_rur18_CMR/pop_rur17_CMR)))))
var pop18_rural_COD= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'COD'))).multiply((1+(pop_gr_18_COD/100)*(((pop_rur18_COD/pop_rur17_COD)))))
var pop18_rural_COG= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'COG'))).multiply((1+(pop_gr_18_COG/100)*(((pop_rur18_COG/pop_rur17_COG)))))
var pop18_rural_ERI= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ERI'))).multiply((1+(pop_gr_18_ERI/100)*(((pop_rur18_ERI/pop_rur17_ERI)))))
var pop18_rural_ETH= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ETH'))).multiply((1+(pop_gr_18_ETH/100)*(((pop_rur18_ETH/pop_rur17_ETH)))))
var pop18_rural_GAB= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GAB'))).multiply((1+(pop_gr_18_GAB/100)*(((pop_rur18_GAB/pop_rur17_GAB)))))
var pop18_rural_GHA= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GHA'))).multiply((1+(pop_gr_18_GHA/100)*(((pop_rur18_GHA/pop_rur17_GHA)))))
var pop18_rural_GIN= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GIN'))).multiply((1+(pop_gr_18_GIN/100)*(((pop_rur18_GIN/pop_rur17_GIN)))))
var pop18_rural_GMB= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GMB'))).multiply((1+(pop_gr_18_GMB/100)*(((pop_rur18_GMB/pop_rur17_GMB)))))
var pop18_rural_GNB= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNB'))).multiply((1+(pop_gr_18_GNB/100)*(((pop_rur18_GNB/pop_rur17_GNB)))))
var pop18_rural_GNQ= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNQ'))).multiply((1+(pop_gr_18_GNQ/100)*(((pop_rur18_GNQ/pop_rur17_GNQ)))))
var pop18_rural_KEN= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'KEN'))).multiply((1+(pop_gr_18_KEN/100)*(((pop_rur18_KEN/pop_rur17_KEN)))))
var pop18_rural_LBR= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'LBR'))).multiply((1+(pop_gr_18_LBR/100)*(((pop_rur18_LBR/pop_rur17_LBR)))))
var pop18_rural_LSO= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'LSO'))).multiply((1+(pop_gr_18_LSO/100)*(((pop_rur18_LSO/pop_rur17_LSO)))))
var pop18_rural_MDG= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MDG'))).multiply((1+(pop_gr_18_MDG/100)*(((pop_rur18_MDG/pop_rur17_MDG)))))
var pop18_rural_MLI= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MLI'))).multiply((1+(pop_gr_18_MLI/100)*(((pop_rur18_MLI/pop_rur17_MLI)))))
var pop18_rural_MOZ= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MOZ'))).multiply((1+(pop_gr_18_MOZ/100)*(((pop_rur18_MOZ/pop_rur17_MOZ)))))
var pop18_rural_MRT= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MRT'))).multiply((1+(pop_gr_18_MRT/100)*(((pop_rur18_MRT/pop_rur17_MRT)))))
var pop18_rural_MWI= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MWI'))).multiply((1+(pop_gr_18_MWI/100)*(((pop_rur18_MWI/pop_rur17_MWI)))))
var pop18_rural_NAM= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'NAM'))).multiply((1+(pop_gr_18_NAM/100)*(((pop_rur18_NAM/pop_rur17_NAM)))))
var pop18_rural_NER= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'NER'))).multiply((1+(pop_gr_18_NER/100)*(((pop_rur18_NER/pop_rur17_NER)))))
var pop18_rural_NGA= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'NGA'))).multiply((1+(pop_gr_18_NGA/100)*(((pop_rur18_NGA/pop_rur17_NGA)))))
var pop18_rural_RWA= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'RWA'))).multiply((1+(pop_gr_18_RWA/100)*(((pop_rur18_RWA/pop_rur17_RWA)))))
var pop18_rural_SDN= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SDN'))).multiply((1+(pop_gr_18_SDN/100)*(((pop_rur18_SDN/pop_rur17_SDN)))))
var pop18_rural_SEN= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SEN'))).multiply((1+(pop_gr_18_SEN/100)*(((pop_rur18_SEN/pop_rur17_SEN)))))
var pop18_rural_SLE= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SLE'))).multiply((1+(pop_gr_18_SLE/100)*(((pop_rur18_SLE/pop_rur17_SLE)))))
var pop18_rural_SOM= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SOM'))).multiply((1+(pop_gr_18_SOM/100)*(((pop_rur18_SOM/pop_rur17_SOM)))))
var pop18_rural_SSD= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SSD'))).multiply((1+(pop_gr_18_SSD/100)*(((pop_rur18_SSD/pop_rur17_SSD)))))
var pop18_rural_SWZ= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SWZ'))).multiply((1+(pop_gr_18_SWZ/100)*(((pop_rur18_SWZ/pop_rur17_SWZ)))))
var pop18_rural_TCD= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'TCD'))).multiply((1+(pop_gr_18_TCD/100)*(((pop_rur18_TCD/pop_rur17_TCD)))))
var pop18_rural_TGO= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'TGO'))).multiply((1+(pop_gr_18_TGO/100)*(((pop_rur18_TGO/pop_rur17_TGO)))))
var pop18_rural_TZA= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'TZA'))).multiply((1+(pop_gr_18_TZA/100)*(((pop_rur18_TZA/pop_rur17_TZA)))))
var pop18_rural_UGA= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'UGA'))).multiply((1+(pop_gr_18_UGA/100)*(((pop_rur18_UGA/pop_rur17_UGA)))))
var pop18_rural_ZAF= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZAF'))).multiply((1+(pop_gr_18_ZAF/100)*(((pop_rur18_ZAF/pop_rur17_ZAF)))))
var pop18_rural_ZMB= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZMB'))).multiply((1+(pop_gr_18_ZMB/100)*(((pop_rur18_ZMB/pop_rur17_ZMB)))))
var pop18_rural_ZWE= pop17_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZWE'))).multiply((1+(pop_gr_18_ZWE/100)*(((pop_rur18_ZWE/pop_rur17_ZWE)))))

var pop18 = ee.ImageCollection([pop18_urban_AGO,pop18_rural_AGO,pop18_urban_BDI,pop18_rural_BDI,pop18_urban_BEN,pop18_rural_BEN,pop18_urban_BFA,pop18_rural_BFA,pop18_urban_BWA,pop18_rural_BWA,pop18_urban_CAF,pop18_rural_CAF,pop18_urban_CIV,pop18_rural_CIV,pop18_urban_CMR,pop18_rural_CMR,pop18_urban_COD,pop18_rural_COD,pop18_urban_COG,pop18_rural_COG,pop18_urban_ERI,pop18_rural_ERI,pop18_urban_ETH,pop18_rural_ETH,pop18_urban_GAB,pop18_rural_GAB,pop18_urban_GHA,pop18_rural_GHA,pop18_urban_GIN,pop18_rural_GIN,pop18_urban_GMB,pop18_rural_GMB,pop18_urban_GNB,pop18_rural_GNB,pop18_urban_GNQ,pop18_rural_GNQ,pop18_urban_KEN,pop18_rural_KEN,pop18_urban_LBR,pop18_rural_LBR,pop18_urban_LSO,pop18_rural_LSO,pop18_urban_MDG,pop18_rural_MDG,pop18_urban_MLI,pop18_rural_MLI,pop18_urban_MOZ,pop18_rural_MOZ,pop18_urban_MRT,pop18_rural_MRT,pop18_urban_MWI,pop18_rural_MWI,pop18_urban_NAM,pop18_rural_NAM,pop18_urban_NER,pop18_rural_NER,pop18_urban_NGA,pop18_rural_NGA,pop18_urban_RWA,pop18_rural_RWA,pop18_urban_SDN,pop18_rural_SDN,pop18_urban_SEN,pop18_rural_SEN,pop18_urban_SLE,pop18_rural_SLE,pop18_urban_SOM,pop18_rural_SOM,pop18_urban_SSD,pop18_rural_SSD,pop18_urban_SWZ,pop18_rural_SWZ,pop18_urban_TCD,pop18_rural_TCD,pop18_urban_TGO,pop18_rural_TGO,pop18_urban_TZA,pop18_rural_TZA,pop18_urban_UGA,pop18_rural_UGA,pop18_urban_ZAF,pop18_rural_ZAF,pop18_urban_ZMB,pop18_rural_ZMB,pop18_urban_ZWE,pop18_rural_ZWE]).mosaic()
var pop18_urban = pop18.mask(GHSSMOD2015.gte(2).and(pop18.gt(0)))
var pop18_rural = pop18.mask(GHSSMOD2015.lte(1).and(pop18.gt(0)))

var pop19_urban_AGO= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'AGO'))).multiply((1+(pop_gr_18_AGO/100)*(((pop_urb18_AGO/pop_urb17_AGO)))))
var pop19_urban_BDI= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BDI'))).multiply((1+(pop_gr_18_BDI/100)*(((pop_urb18_BDI/pop_urb17_BDI)))))
var pop19_urban_BEN= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BEN'))).multiply((1+(pop_gr_18_BEN/100)*(((pop_urb18_BEN/pop_urb17_BEN)))))
var pop19_urban_BFA= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BFA'))).multiply((1+(pop_gr_18_BFA/100)*(((pop_urb18_BFA/pop_urb17_BFA)))))
var pop19_urban_BWA= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'BWA'))).multiply((1+(pop_gr_18_BWA/100)*(((pop_urb18_BWA/pop_urb17_BWA)))))
var pop19_urban_CAF= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'CAF'))).multiply((1+(pop_gr_18_CAF/100)*(((pop_urb18_CAF/pop_urb17_CAF)))))
var pop19_urban_CIV= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'CIV'))).multiply((1+(pop_gr_18_CIV/100)*(((pop_urb18_CIV/pop_urb17_CIV)))))
var pop19_urban_CMR= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'CMR'))).multiply((1+(pop_gr_18_CMR/100)*(((pop_urb18_CMR/pop_urb17_CMR)))))
var pop19_urban_COD= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'COD'))).multiply((1+(pop_gr_18_COD/100)*(((pop_urb18_COD/pop_urb17_COD)))))
var pop19_urban_COG= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'COG'))).multiply((1+(pop_gr_18_COG/100)*(((pop_urb18_COG/pop_urb17_COG)))))
var pop19_urban_ERI= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ERI'))).multiply((1+(pop_gr_18_ERI/100)*(((pop_urb18_ERI/pop_urb17_ERI)))))
var pop19_urban_ETH= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ETH'))).multiply((1+(pop_gr_18_ETH/100)*(((pop_urb18_ETH/pop_urb17_ETH)))))
var pop19_urban_GAB= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GAB'))).multiply((1+(pop_gr_18_GAB/100)*(((pop_urb18_GAB/pop_urb17_GAB)))))
var pop19_urban_GHA= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GHA'))).multiply((1+(pop_gr_18_GHA/100)*(((pop_urb18_GHA/pop_urb17_GHA)))))
var pop19_urban_GIN= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GIN'))).multiply((1+(pop_gr_18_GIN/100)*(((pop_urb18_GIN/pop_urb17_GIN)))))
var pop19_urban_GMB= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GMB'))).multiply((1+(pop_gr_18_GMB/100)*(((pop_urb18_GMB/pop_urb17_GMB)))))
var pop19_urban_GNB= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNB'))).multiply((1+(pop_gr_18_GNB/100)*(((pop_urb18_GNB/pop_urb17_GNB)))))
var pop19_urban_GNQ= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNQ'))).multiply((1+(pop_gr_18_GNQ/100)*(((pop_urb18_GNQ/pop_urb17_GNQ)))))
var pop19_urban_KEN= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'KEN'))).multiply((1+(pop_gr_18_KEN/100)*(((pop_urb18_KEN/pop_urb17_KEN)))))
var pop19_urban_LBR= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'LBR'))).multiply((1+(pop_gr_18_LBR/100)*(((pop_urb18_LBR/pop_urb17_LBR)))))
var pop19_urban_LSO= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'LSO'))).multiply((1+(pop_gr_18_LSO/100)*(((pop_urb18_LSO/pop_urb17_LSO)))))
var pop19_urban_MDG= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MDG'))).multiply((1+(pop_gr_18_MDG/100)*(((pop_urb18_MDG/pop_urb17_MDG)))))
var pop19_urban_MLI= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MLI'))).multiply((1+(pop_gr_18_MLI/100)*(((pop_urb18_MLI/pop_urb17_MLI)))))
var pop19_urban_MOZ= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MOZ'))).multiply((1+(pop_gr_18_MOZ/100)*(((pop_urb18_MOZ/pop_urb17_MOZ)))))
var pop19_urban_MRT= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MRT'))).multiply((1+(pop_gr_18_MRT/100)*(((pop_urb18_MRT/pop_urb17_MRT)))))
var pop19_urban_MWI= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'MWI'))).multiply((1+(pop_gr_18_MWI/100)*(((pop_urb18_MWI/pop_urb17_MWI)))))
var pop19_urban_NAM= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'NAM'))).multiply((1+(pop_gr_18_NAM/100)*(((pop_urb18_NAM/pop_urb17_NAM)))))
var pop19_urban_NER= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'NER'))).multiply((1+(pop_gr_18_NER/100)*(((pop_urb18_NER/pop_urb17_NER)))))
var pop19_urban_NGA= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'NGA'))).multiply((1+(pop_gr_18_NGA/100)*(((pop_urb18_NGA/pop_urb17_NGA)))))
var pop19_urban_RWA= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'RWA'))).multiply((1+(pop_gr_18_RWA/100)*(((pop_urb18_RWA/pop_urb17_RWA)))))
var pop19_urban_SDN= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SDN'))).multiply((1+(pop_gr_18_SDN/100)*(((pop_urb18_SDN/pop_urb17_SDN)))))
var pop19_urban_SEN= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SEN'))).multiply((1+(pop_gr_18_SEN/100)*(((pop_urb18_SEN/pop_urb17_SEN)))))
var pop19_urban_SLE= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SLE'))).multiply((1+(pop_gr_18_SLE/100)*(((pop_urb18_SLE/pop_urb17_SLE)))))
var pop19_urban_SOM= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SOM'))).multiply((1+(pop_gr_18_SOM/100)*(((pop_urb18_SOM/pop_urb17_SOM)))))
var pop19_urban_SSD= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SSD'))).multiply((1+(pop_gr_18_SSD/100)*(((pop_urb18_SSD/pop_urb17_SSD)))))
var pop19_urban_SWZ= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'SWZ'))).multiply((1+(pop_gr_18_SWZ/100)*(((pop_urb18_SWZ/pop_urb17_SWZ)))))
var pop19_urban_TCD= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'TCD'))).multiply((1+(pop_gr_18_TCD/100)*(((pop_urb18_TCD/pop_urb17_TCD)))))
var pop19_urban_TGO= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'TGO'))).multiply((1+(pop_gr_18_TGO/100)*(((pop_urb18_TGO/pop_urb17_TGO)))))
var pop19_urban_TZA= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'TZA'))).multiply((1+(pop_gr_18_TZA/100)*(((pop_urb18_TZA/pop_urb17_TZA)))))
var pop19_urban_UGA= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'UGA'))).multiply((1+(pop_gr_18_UGA/100)*(((pop_urb18_UGA/pop_urb17_UGA)))))
var pop19_urban_ZAF= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZAF'))).multiply((1+(pop_gr_18_ZAF/100)*(((pop_urb18_ZAF/pop_urb17_ZAF)))))
var pop19_urban_ZMB= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZMB'))).multiply((1+(pop_gr_18_ZMB/100)*(((pop_urb18_ZMB/pop_urb17_ZMB)))))
var pop19_urban_ZWE= pop18_urban.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZWE'))).multiply((1+(pop_gr_18_ZWE/100)*(((pop_urb18_ZWE/pop_urb17_ZWE)))))

var pop19_rural_AGO= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'AGO'))).multiply((1+(pop_gr_18_AGO/100)*(((pop_rur18_AGO/pop_rur17_AGO)))))
var pop19_rural_BDI= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BDI'))).multiply((1+(pop_gr_18_BDI/100)*(((pop_rur18_BDI/pop_rur17_BDI)))))
var pop19_rural_BEN= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BEN'))).multiply((1+(pop_gr_18_BEN/100)*(((pop_rur18_BEN/pop_rur17_BEN)))))
var pop19_rural_BFA= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BFA'))).multiply((1+(pop_gr_18_BFA/100)*(((pop_rur18_BFA/pop_rur17_BFA)))))
var pop19_rural_BWA= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'BWA'))).multiply((1+(pop_gr_18_BWA/100)*(((pop_rur18_BWA/pop_rur17_BWA)))))
var pop19_rural_CAF= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'CAF'))).multiply((1+(pop_gr_18_CAF/100)*(((pop_rur18_CAF/pop_rur17_CAF)))))
var pop19_rural_CIV= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'CIV'))).multiply((1+(pop_gr_18_CIV/100)*(((pop_rur18_CIV/pop_rur17_CIV)))))
var pop19_rural_CMR= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'CMR'))).multiply((1+(pop_gr_18_CMR/100)*(((pop_rur18_CMR/pop_rur17_CMR)))))
var pop19_rural_COD= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'COD'))).multiply((1+(pop_gr_18_COD/100)*(((pop_rur18_COD/pop_rur17_COD)))))
var pop19_rural_COG= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'COG'))).multiply((1+(pop_gr_18_COG/100)*(((pop_rur18_COG/pop_rur17_COG)))))
var pop19_rural_ERI= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ERI'))).multiply((1+(pop_gr_18_ERI/100)*(((pop_rur18_ERI/pop_rur17_ERI)))))
var pop19_rural_ETH= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ETH'))).multiply((1+(pop_gr_18_ETH/100)*(((pop_rur18_ETH/pop_rur17_ETH)))))
var pop19_rural_GAB= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GAB'))).multiply((1+(pop_gr_18_GAB/100)*(((pop_rur18_GAB/pop_rur17_GAB)))))
var pop19_rural_GHA= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GHA'))).multiply((1+(pop_gr_18_GHA/100)*(((pop_rur18_GHA/pop_rur17_GHA)))))
var pop19_rural_GIN= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GIN'))).multiply((1+(pop_gr_18_GIN/100)*(((pop_rur18_GIN/pop_rur17_GIN)))))
var pop19_rural_GMB= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GMB'))).multiply((1+(pop_gr_18_GMB/100)*(((pop_rur18_GMB/pop_rur17_GMB)))))
var pop19_rural_GNB= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNB'))).multiply((1+(pop_gr_18_GNB/100)*(((pop_rur18_GNB/pop_rur17_GNB)))))
var pop19_rural_GNQ= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'GNQ'))).multiply((1+(pop_gr_18_GNQ/100)*(((pop_rur18_GNQ/pop_rur17_GNQ)))))
var pop19_rural_KEN= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'KEN'))).multiply((1+(pop_gr_18_KEN/100)*(((pop_rur18_KEN/pop_rur17_KEN)))))
var pop19_rural_LBR= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'LBR'))).multiply((1+(pop_gr_18_LBR/100)*(((pop_rur18_LBR/pop_rur17_LBR)))))
var pop19_rural_LSO= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'LSO'))).multiply((1+(pop_gr_18_LSO/100)*(((pop_rur18_LSO/pop_rur17_LSO)))))
var pop19_rural_MDG= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MDG'))).multiply((1+(pop_gr_18_MDG/100)*(((pop_rur18_MDG/pop_rur17_MDG)))))
var pop19_rural_MLI= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MLI'))).multiply((1+(pop_gr_18_MLI/100)*(((pop_rur18_MLI/pop_rur17_MLI)))))
var pop19_rural_MOZ= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MOZ'))).multiply((1+(pop_gr_18_MOZ/100)*(((pop_rur18_MOZ/pop_rur17_MOZ)))))
var pop19_rural_MRT= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MRT'))).multiply((1+(pop_gr_18_MRT/100)*(((pop_rur18_MRT/pop_rur17_MRT)))))
var pop19_rural_MWI= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'MWI'))).multiply((1+(pop_gr_18_MWI/100)*(((pop_rur18_MWI/pop_rur17_MWI)))))
var pop19_rural_NAM= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'NAM'))).multiply((1+(pop_gr_18_NAM/100)*(((pop_rur18_NAM/pop_rur17_NAM)))))
var pop19_rural_NER= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'NER'))).multiply((1+(pop_gr_18_NER/100)*(((pop_rur18_NER/pop_rur17_NER)))))
var pop19_rural_NGA= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'NGA'))).multiply((1+(pop_gr_18_NGA/100)*(((pop_rur18_NGA/pop_rur17_NGA)))))
var pop19_rural_RWA= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'RWA'))).multiply((1+(pop_gr_18_RWA/100)*(((pop_rur18_RWA/pop_rur17_RWA)))))
var pop19_rural_SDN= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SDN'))).multiply((1+(pop_gr_18_SDN/100)*(((pop_rur18_SDN/pop_rur17_SDN)))))
var pop19_rural_SEN= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SEN'))).multiply((1+(pop_gr_18_SEN/100)*(((pop_rur18_SEN/pop_rur17_SEN)))))
var pop19_rural_SLE= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SLE'))).multiply((1+(pop_gr_18_SLE/100)*(((pop_rur18_SLE/pop_rur17_SLE)))))
var pop19_rural_SOM= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SOM'))).multiply((1+(pop_gr_18_SOM/100)*(((pop_rur18_SOM/pop_rur17_SOM)))))
var pop19_rural_SSD= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SSD'))).multiply((1+(pop_gr_18_SSD/100)*(((pop_rur18_SSD/pop_rur17_SSD)))))
var pop19_rural_SWZ= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'SWZ'))).multiply((1+(pop_gr_18_SWZ/100)*(((pop_rur18_SWZ/pop_rur17_SWZ)))))
var pop19_rural_TCD= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'TCD'))).multiply((1+(pop_gr_18_TCD/100)*(((pop_rur18_TCD/pop_rur17_TCD)))))
var pop19_rural_TGO= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'TGO'))).multiply((1+(pop_gr_18_TGO/100)*(((pop_rur18_TGO/pop_rur17_TGO)))))
var pop19_rural_TZA= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'TZA'))).multiply((1+(pop_gr_18_TZA/100)*(((pop_rur18_TZA/pop_rur17_TZA)))))
var pop19_rural_UGA= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'UGA'))).multiply((1+(pop_gr_18_UGA/100)*(((pop_rur18_UGA/pop_rur17_UGA)))))
var pop19_rural_ZAF= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZAF'))).multiply((1+(pop_gr_18_ZAF/100)*(((pop_rur18_ZAF/pop_rur17_ZAF)))))
var pop19_rural_ZMB= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZMB'))).multiply((1+(pop_gr_18_ZMB/100)*(((pop_rur18_ZMB/pop_rur17_ZMB)))))
var pop19_rural_ZWE= pop18_rural.clip(Countries.filter(ee.Filter.eq('GID_0', 'ZWE'))).multiply((1+(pop_gr_18_ZWE/100)*(((pop_rur18_ZWE/pop_rur17_ZWE)))))

var pop19 = ee.ImageCollection([pop19_urban_AGO,pop19_rural_AGO,pop19_urban_BDI,pop19_rural_BDI,pop19_urban_BEN,pop19_rural_BEN,pop19_urban_BFA,pop19_rural_BFA,pop19_urban_BWA,pop19_rural_BWA,pop19_urban_CAF,pop19_rural_CAF,pop19_urban_CIV,pop19_rural_CIV,pop19_urban_CMR,pop19_rural_CMR,pop19_urban_COD,pop19_rural_COD,pop19_urban_COG,pop19_rural_COG,pop19_urban_ERI,pop19_rural_ERI,pop19_urban_ETH,pop19_rural_ETH,pop19_urban_GAB,pop19_rural_GAB,pop19_urban_GHA,pop19_rural_GHA,pop19_urban_GIN,pop19_rural_GIN,pop19_urban_GMB,pop19_rural_GMB,pop19_urban_GNB,pop19_rural_GNB,pop19_urban_GNQ,pop19_rural_GNQ,pop19_urban_KEN,pop19_rural_KEN,pop19_urban_LBR,pop19_rural_LBR,pop19_urban_LSO,pop19_rural_LSO,pop19_urban_MDG,pop19_rural_MDG,pop19_urban_MLI,pop19_rural_MLI,pop19_urban_MOZ,pop19_rural_MOZ,pop19_urban_MRT,pop19_rural_MRT,pop19_urban_MWI,pop19_rural_MWI,pop19_urban_NAM,pop19_rural_NAM,pop19_urban_NER,pop19_rural_NER,pop19_urban_NGA,pop19_rural_NGA,pop19_urban_RWA,pop19_rural_RWA,pop19_urban_SDN,pop19_rural_SDN,pop19_urban_SEN,pop19_rural_SEN,pop19_urban_SLE,pop19_rural_SLE,pop19_urban_SOM,pop19_rural_SOM,pop19_urban_SSD,pop19_rural_SSD,pop19_urban_SWZ,pop19_rural_SWZ,pop19_urban_TCD,pop19_rural_TCD,pop19_urban_TGO,pop19_rural_TGO,pop19_urban_TZA,pop19_rural_TZA,pop19_urban_UGA,pop19_rural_UGA,pop19_urban_ZAF,pop19_rural_ZAF,pop19_urban_ZMB,pop19_rural_ZMB,pop19_urban_ZWE,pop19_rural_ZWE]).mosaic()
var pop19_urban = pop19.mask(GHSSMOD2015.gte(2).and(pop19.gt(0)))
var pop19_rural = pop19.mask(GHSSMOD2015.lte(1).and(pop19.gt(0)))

var replacement = ee.Image(0);
    
var nl14 = nl14.where(nl14.lt(0.2), replacement);
var nl15 = nl15.where(nl15.lt(0.2), replacement);
var nl16 = nl16.where(nl16.lt(0.2), replacement);
var nl17 = nl17.where(nl17.lt(0.2), replacement);
var nl18 = nl18.where(nl18.lt(0.2), replacement);
var nl19 = nl19.where(nl18.lt(0.2), replacement);

// Generate data for population without access for both years
var pop14_noaccess = pop14.mask(pop14.gt(0).and(nl14.eq(0)))
var pop15_noaccess = pop15.mask(pop15.gt(0).and(nl15.eq(0)))
var pop16_noaccess = pop16.mask(pop16.gt(0).and(nl16.eq(0)))
var pop17_noaccess = pop17.mask(pop17.gt(0).and(nl17.eq(0)))
var pop18_noaccess = pop18.mask(pop18.gt(0).and(nl18.eq(0)))
var pop19_noaccess = pop19.mask(pop19.gt(0).and(nl19.eq(0)))

var pop_noaccess = pop14_noaccess.rename("noacc14")
                .addBands(pop15_noaccess.rename("noacc15"))
                .addBands(pop16_noaccess.rename("noacc16"))
                .addBands(pop17_noaccess.rename("noacc17"))
                .addBands(pop18_noaccess.rename("noacc18"))
                .addBands(pop19_noaccess.rename("noacc19"))

var pop = pop14.rename("pop14")
                .addBands(pop15.rename("pop15"))
                .addBands(pop16.rename("pop16"))
                .addBands(pop17.rename("pop17"))
                .addBands(pop18.rename("pop18"))
                .addBands(pop19.rename("pop19"))


//Calculate sum of people without access by province
var no_acc = pop_noaccess.reduceRegions({
    reducer: ee.Reducer.sum(),
    collection: Countries,
    scale:30,
  })

var pop = pop.reduceRegions({
    reducer: ee.Reducer.sum(),
    collection: Countries,
    scale:30,
})

//Export to Google Drive
var no_acc = no_acc.select(['.*'],null,false);

Export.table.toDrive({
  collection: no_acc,
  description: 'no_acc',
  fileFormat: 'CSV',
});   


var pop = pop.select(['.*'],null,false);

Export.table.toDrive({
  collection: pop,
  description: 'pop',
  fileFormat: 'CSV',
});   


//2) Urban / rural distinction
///Identify urban and rural areas and define tiers of consumption

//Import GHS-SMOD 2015 
var GHSSMOD2015 = ee.ImageCollection("JRC/GHSL/P2016/SMOD_POP_GLOBE_V1").filterDate('2014-01-01', '2016-01-01').median()

var urbpop = pop18.mask(GHSSMOD2015.gte(2).and(pop18.gt(0)))
var rurpop = pop18.mask(GHSSMOD2015.lte(1).and(pop18.gt(0)))

// Export for comparison with World Bank statistics
var urbpop_exp = urbpop.reduceRegions({
  collection: Countries,
  reducer: ee.Reducer.sum(),
  scale: 30
});

var urbpop_exp = urbpop_exp.select(['.*'],null,false);

Export.table.toDrive({
  collection: urbpop_exp,
  description: 'urbpop_exp',
  fileFormat: 'CSV'
});   

//Rural
//Import population for both years (change these two line to change the population dataset)
var pop14_r = pop14_rural
var pop15_r = pop15_rural
var pop16_r = pop16_rural
var pop17_r = pop17_rural
var pop18_r = pop18_rural
var pop19_r = pop19_rural

// Generate data for population without access for both years
var pop14_noaccess = pop14_r.mask(pop14_r.gt(0).and(nl14.eq(0)))
var pop15_noaccess = pop15_r.mask(pop15_r.gt(0).and(nl15.eq(0)))
var pop16_noaccess = pop16_r.mask(pop16_r.gt(0).and(nl16.eq(0)))
var pop17_noaccess = pop17_r.mask(pop17_r.gt(0).and(nl17.eq(0)))
var pop18_noaccess = pop18_r.mask(pop18_r.gt(0).and(nl18.eq(0)))
var pop19_noaccess = pop19_r.mask(pop19_r.gt(0).and(nl19.eq(0)))

//print(pop15_noaccess.reduceRegion(ee.Reducer.sum(), geometry, 30))
//print(pop15_r.reduceRegion(ee.Reducer.sum(), geometry, 30))

// Import provinces shapefile
var Countries = ee.FeatureCollection('users/giacomofalchetta/gadm36_1');

var pop_noaccess = pop14_noaccess.rename("noacc14")
//                .addBands(pop15_noaccess.rename("noacc15"))
//                .addBands(pop16_noaccess.rename("noacc16"))
//                .addBands(pop17_noaccess.rename("noacc17"))
//                .addBands(pop18_noaccess.rename("noacc18"))
                .addBands(pop19_noaccess.rename("noacc19"))

var pop_r = pop14_r.rename("pop14")
//                .addBands(pop15_r.rename("pop15"))
//                .addBands(pop16_r.rename("pop16"))
//                .addBands(pop17_r.rename("pop17"))
//                .addBands(pop18_r.rename("pop18"))
                .addBands(pop19_r.rename("pop19"))


//Calculate sum of people without access by province
var no_acc = pop_noaccess.reduceRegions({
    reducer: ee.Reducer.sum(),
    collection: Countries,
    scale:30,
  })

var pop = pop_r.reduceRegions({
    reducer: ee.Reducer.sum(),
    collection: Countries,
    scale:30,
})

//Export to Google Drive
var no_acc = no_acc.select(['.*'],null,false);

Export.table.toDrive({
  collection: no_acc,
  description: 'no_acc_rural',
  fileFormat: 'CSV',
});   


var pop = pop.select(['.*'],null,false);

Export.table.toDrive({
  collection: pop,
  description: 'pop_rural',
  fileFormat: 'CSV',
});  


//Urban
//Import population for both years (change these two line to change the population dataset)
var pop14_u = pop14_urban
var pop15_u = pop15_urban
var pop16_u = pop16_urban
var pop17_u = pop17_urban
var pop18_u = pop18_urban
var pop19_u = pop19_urban

// Generate data for population without access for both years
var pop14_noaccess = pop14_u.mask(pop14_u.gt(0).and(nl14.eq(0)))
var pop15_noaccess = pop15_u.mask(pop15_u.gt(0).and(nl15.eq(0)))
var pop16_noaccess = pop16_u.mask(pop16_u.gt(0).and(nl16.eq(0)))
var pop17_noaccess = pop17_u.mask(pop17_u.gt(0).and(nl17.eq(0)))
var pop18_noaccess = pop18_u.mask(pop18_u.gt(0).and(nl18.eq(0)))
var pop19_noaccess = pop19_u.mask(pop19_u.gt(0).and(nl19.eq(0)))

// Import provinces shapefile
var Countries = ee.FeatureCollection('users/giacomofalchetta/gadm36_1');

var pop_noaccess = pop14_noaccess.rename("noacc14")
//                .addBands(pop15_noaccess.rename("noacc15"))
//                .addBands(pop16_noaccess.rename("noacc16"))
//                .addBands(pop17_noaccess.rename("noacc17"))
//                .addBands(pop18_noaccess.rename("noacc18"))
                .addBands(pop19_noaccess.rename("noacc19"))

var pop_u = pop14_u.rename("pop14")
//                .addBands(pop15_u.rename("pop15"))
//                .addBands(pop16_u.rename("pop16"))
//                .addBands(pop17_u.rename("pop17"))
//                .addBands(pop18_u.rename("pop18"))
                .addBands(pop19_u.rename("pop19"))


//Calculate sum of people without access by province
var no_acc = pop_noaccess.reduceRegions({
    reducer: ee.Reducer.sum(),
    collection: Countries,
    scale:30,
  })

var pop = pop_u.reduceRegions({
    reducer: ee.Reducer.sum(),
    collection: Countries,
    scale:30,
})

//Export to Google Drive
var no_acc = no_acc.select(['.*'],null,false);

Export.table.toDrive({
  collection: no_acc,
  description: 'no_acc_urban',
  fileFormat: 'CSV',
});   


var pop = pop.select(['.*'],null,false);

Export.table.toDrive({
  collection: pop,
  description: 'pop_urban',
  fileFormat: 'CSV',
});  


//3) extract quartiles of light for urban and rural areas to determine thresholds for tiers of consumption
// apply lights noise floor
var Countries = ee.FeatureCollection('users/giacomofalchetta/gadm').filter(ee.Filter.and(ee.Filter.neq('SUBREGION', 15), ee.Filter.eq('REGION', 2)))

var lightcapita18 = nl18
var lightcapita18_rur = lightcapita18.mask(rurpop.gt(0).and(lightcapita18.gt(0)))

var lightsum = lightcapita18_rur.reduceRegions({
  collection: Countries,
  reducer: ee.Reducer.percentile([25, 50, 75]),
  scale: 450
});

Export.table.toDrive({
  collection: lightsum,
  description:'pctiles_pc_rural',
  fileFormat: 'CSV',
  selectors : ['p25', 'p50', 'p75','ISO3']
});

var lightcapita18_urb = lightcapita18.mask(urbpop.gt(0).and(lightcapita18.gt(0)))

var lightsum = lightcapita18_urb.reduceRegions({
  collection: Countries,
  reducer: ee.Reducer.percentile([25, 50, 75]),
  scale: 450
});

Export.table.toDrive({
  collection: lightsum,
  description:'pctiles_pc_urban',
  fileFormat: 'CSV',
  selectors : ['p25', 'p50', 'p75','ISO3']
});


var lightcapita18_nat = lightcapita18.mask(pop18.gt(0).and(lightcapita18.gt(0)))

var lightsum = lightcapita18_nat.reduceRegions({
  collection: Countries,
  reducer: ee.Reducer.percentile([25, 50, 75]),
  scale: 450
});

Export.table.toDrive({
  collection: lightsum,
  description:'pctiles_pc_national',
  fileFormat: 'CSV',
  selectors : ['p25', 'p50', 'p75','ISO3']
});


//4) Produce counts of tiers of consumption 
//Rural areas
var Countries = ee.FeatureCollection('users/giacomofalchetta/gadm36_1');

var lightcapita18 = nl18
var lightcapita18 = lightcapita18.mask(rurpop.gt(0))

//Input values defined in R as quartiles 
var pop18_tier_0 = rurpop.mask(rurpop.gt(0).and(lightcapita18.eq(0)))
var pop18_tier_1 = rurpop.mask(rurpop.gt(0).and(lightcapita18.gt(0)).and(lightcapita18.lt(0.314)))
var pop18_tier_2 = rurpop.mask(rurpop.gt(0).and(lightcapita18.gte(0.314)).and(lightcapita18.lt(0.3907)))
var pop18_tier_3 = rurpop.mask(rurpop.gt(0).and(lightcapita18.gte(0.390)).and(lightcapita18.lt(0.8453)))
var pop18_tier_4 = rurpop.mask(rurpop.gt(0).and(lightcapita18.gte(0.8453)))

var tiers_rural = pop18_tier_0.rename("tier0_rural")
                .addBands(pop18_tier_1.rename("tier1_rural"))
                .addBands(pop18_tier_2.rename("tier2_rural"))
                .addBands(pop18_tier_3.rename("tier3_rural"))
                .addBands(pop18_tier_4.rename("tier4_rural"))


// number of people 'with access' in each tier
var tiers_rural = tiers_rural.reduceRegions({
    reducer: ee.Reducer.sum(),
    collection: Countries, scale: 30,
})

var tiers_rural = tiers_rural.select(['.*'],null,false);

// Table to Drive Export Example
Export.table.toDrive({
  collection: tiers_rural,
  description: 'tiers_rural',
  fileFormat: 'CSV'
}); 


//Urban areas
var Countries = ee.FeatureCollection('users/giacomofalchetta/gadm36_1');

var lightcapita18 = nl18

var lightcapita18 = lightcapita18.mask(urbpop.gt(0))

//Input values defined in R as quartiles 
var pop18_tier_0 = urbpop.mask(urbpop.gt(0).and(lightcapita18.eq(0)))
var pop18_tier_1 = urbpop.mask(urbpop.gt(0).and(lightcapita18.gt(0)).and(lightcapita18.lt(0.7207)))
var pop18_tier_2 = urbpop.mask(urbpop.gt(0).and(lightcapita18.gte(0.7207)).and(lightcapita18.lt(1.742)))
var pop18_tier_3 = urbpop.mask(urbpop.gt(0).and(lightcapita18.gte(1.742)).and(lightcapita18.lt(4.714)))
var pop18_tier_4 = urbpop.mask(urbpop.gt(0).and(lightcapita18.gte(4.714)))

var tiers_urban = pop18_tier_0.rename("tier0_urban")
                .addBands(pop18_tier_1.rename("tier1_urban"))
                .addBands(pop18_tier_2.rename("tier2_urban"))
                .addBands(pop18_tier_3.rename("tier3_urban"))
                .addBands(pop18_tier_4.rename("tier4_urban"))


// number of people 'with access' in each tier
var tiers_urban = tiers_urban.reduceRegions({
    reducer: ee.Reducer.sum(),
    collection: Countries, scale: 30,
})

var tiers_urban = tiers_urban.select(['.*'],null,false);

// Table to Drive Export Example
Export.table.toDrive({
  collection: tiers_urban,
  description: 'tiers_urban',
  fileFormat: 'CSV'
}); 


//National
var Countries = ee.FeatureCollection('users/giacomofalchetta/gadm36_1');

var lightcapita18 = nl18

var lightcapita18 = lightcapita18.mask(pop18.gt(0))

//Input values defined in R as quartiles 
var pop18_tier_0 = pop18.mask(pop18.gt(0).and(lightcapita18.eq(0)))
var pop18_tier_1 = pop18.mask(pop18.gt(0).and(lightcapita18.gt(0)).and(lightcapita18.lt(0.325)))
var pop18_tier_2 = pop18.mask(pop18.gt(0).and(lightcapita18.gte(0.325)).and(lightcapita18.lt(0.7085)))
var pop18_tier_3 = pop18.mask(pop18.gt(0).and(lightcapita18.gte(0.7085)).and(lightcapita18.lt(2.414)))
var pop18_tier_4 = pop18.mask(pop18.gt(0).and(lightcapita18.gte(2.414)))

var tiers_national = pop18_tier_0.rename("tier0_national")
                .addBands(pop18_tier_1.rename("tier1_national"))
                .addBands(pop18_tier_2.rename("tier2_national"))
                .addBands(pop18_tier_3.rename("tier3_national"))
                .addBands(pop18_tier_4.rename("tier4_national"))


// number of people 'with access' in each tier
var tiers_national = tiers_national.reduceRegions({
    reducer: ee.Reducer.sum(),
    collection: Countries, scale: 30,
})

var tiers_national = tiers_national.select(['.*'],null,false);

// Table to Drive Export Example
Export.table.toDrive({
  collection: tiers_national,
  description: 'tiers_national',
  fileFormat: 'CSV'
}); 
