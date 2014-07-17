set terminal png tiny size 800,800
set output "SRR1061349.png"
set ytics ( \
 "NODE_61_length_4289_cov_130.84_ID_121" 1, \
 "NODE_3_length_93491_cov_175.266_ID_5" 4289, \
 "*NODE_11_length_39761_cov_159.362_ID_21" 97779, \
 "*NODE_9_length_41643_cov_173.464_ID_17" 137539, \
 "NODE_21_length_32210_cov_164.906_ID_41" 179181, \
 "*NODE_43_length_14893_cov_208.421_ID_85" 211390, \
 "*NODE_55_length_7638_cov_170.117_ID_109" 226282, \
 "NODE_41_length_16049_cov_149.627_ID_81" 233919, \
 "NODE_53_length_9054_cov_166.963_ID_105" 249967, \
 "NODE_39_length_17320_cov_157.994_ID_77" 259020, \
 "*NODE_17_length_35586_cov_173.319_ID_33" 276339, \
 "NODE_28_length_26854_cov_201.613_ID_55" 311924, \
 "*NODE_67_length_1682_cov_372.916_ID_133" 338777, \
 "*NODE_64_length_2344_cov_203.551_ID_127" 340458, \
 "*NODE_57_length_5372_cov_138.924_ID_113" 342801, \
 "NODE_46_length_14580_cov_153.434_ID_91" 348172, \
 "NODE_65_length_2274_cov_450.985_ID_129" 362751, \
 "NODE_6_length_68942_cov_155.788_ID_11" 365024, \
 "NODE_4_length_80296_cov_148.733_ID_7" 433965, \
 "*NODE_66_length_2121_cov_175.47_ID_131" 514260, \
 "*NODE_10_length_40671_cov_144.098_ID_19" 516380, \
 "NODE_63_length_3386_cov_181.954_ID_125" 557050, \
 "NODE_29_length_24045_cov_177.673_ID_57" 560435, \
 "NODE_2_length_103383_cov_154.572_ID_3" 584479, \
 "NODE_19_length_32740_cov_160.832_ID_37" 687861, \
 "*NODE_54_length_8517_cov_227.01_ID_107" 720600, \
 "*NODE_23_length_31064_cov_151.388_ID_45" 729116, \
 "*NODE_47_length_13421_cov_153.599_ID_93" 760179, \
 "*NODE_12_length_39170_cov_151.405_ID_23" 773599, \
 "*NODE_15_length_37059_cov_163.779_ID_29" 812768, \
 "*NODE_7_length_53497_cov_155.424_ID_13" 849826, \
 "NODE_1_length_131934_cov_139.225_ID_1" 903322, \
 "NODE_72_length_738_cov_351.132_ID_143" 1035255, \
 "NODE_52_length_9070_cov_156.218_ID_103" 1035992, \
 "NODE_50_length_11243_cov_150.009_ID_99" 1045061, \
 "NODE_16_length_35592_cov_163.677_ID_31" 1056303, \
 "*NODE_22_length_31679_cov_152.557_ID_43" 1091893, \
 "NODE_5_length_75226_cov_148.52_ID_9" 1123571, \
 "*NODE_34_length_19790_cov_150.681_ID_67" 1198796, \
 "*NODE_20_length_32564_cov_148.382_ID_39" 1218585, \
 "NODE_35_length_19731_cov_149.822_ID_69" 1251148, \
 "*NODE_58_length_5358_cov_404.051_ID_115" 1270878, \
 "*NODE_36_length_19622_cov_181.074_ID_71" 1276235, \
 "*NODE_14_length_37821_cov_148.986_ID_27" 1295856, \
 "NODE_62_length_3734_cov_321.239_ID_123" 1333676, \
 "*NODE_32_length_21782_cov_166.739_ID_63" 1337409, \
 "*NODE_27_length_27276_cov_146.241_ID_53" 1359190, \
 "NODE_38_length_17608_cov_147.264_ID_75" 1386465, \
 "*NODE_56_length_6704_cov_246.513_ID_111" 1404072, \
 "NODE_45_length_14658_cov_211.068_ID_89" 1410775, \
 "*NODE_37_length_17693_cov_156.493_ID_73" 1425432, \
 "NODE_44_length_14762_cov_194.859_ID_87" 1443124, \
 "*NODE_8_length_43788_cov_157.329_ID_15" 1457885, \
 "NODE_18_length_33146_cov_175.11_ID_35" 1501672, \
 "*NODE_13_length_38202_cov_156.79_ID_25" 1534817, \
 "*NODE_42_length_15478_cov_157.395_ID_83" 1573018, \
 "*NODE_48_length_12323_cov_172.089_ID_95" 1588495, \
 "*NODE_59_length_4437_cov_192.552_ID_117" 1600817, \
 "NODE_30_length_23442_cov_159.087_ID_59" 1605253, \
 "NODE_25_length_30219_cov_156.57_ID_49" 1628694, \
 "NODE_33_length_21385_cov_155.381_ID_65" 1658912, \
 "*NODE_60_length_4349_cov_205.822_ID_119" 1680296, \
 "NODE_26_length_27521_cov_133.713_ID_51" 1684644, \
 "NODE_24_length_30307_cov_176.311_ID_47" 1712164, \
 "*NODE_49_length_12086_cov_174.652_ID_97" 1742470, \
 "*NODE_31_length_23261_cov_159.934_ID_61" 1754555, \
 "NODE_51_length_9490_cov_159.923_ID_101" 1777815, \
 "NODE_40_length_16212_cov_143.582_ID_79" 1787304, \
 "" 1803582 \
)
set size 1,1
set grid
unset key
set border 10
set ticscale 0 0
set xlabel "gi|240248234|emb|AJ749949.2|"
set ylabel "QRY"
set format "%.0f"
set mouse format "%.0f"
set mouse mouseformat "[%.0f, %.0f]"
set mouse clipboardformat "[%.0f, %.0f]"
set xrange [1:1892775]
set yrange [1:1803582]
set style line 1  lt 1 lw 3 pt 6 ps 1
set style line 2  lt 3 lw 3 pt 6 ps 1
set style line 3  lt 2 lw 3 pt 6 ps 1
plot \
 "SRR1061349.fplot" title "FWD" w lp ls 1, \
 "SRR1061349.rplot" title "REV" w lp ls 2
