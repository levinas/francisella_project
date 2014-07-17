set terminal png tiny size 800,800
set output "SRR1061347.png"
set ytics ( \
 "NODE_59_length_4289_cov_135.022_ID_117" 1, \
 "*NODE_3_length_93491_cov_174.046_ID_5" 4289, \
 "*NODE_12_length_39761_cov_159.793_ID_23" 97779, \
 "*NODE_10_length_41617_cov_165.492_ID_19" 137539, \
 "NODE_22_length_32210_cov_152.463_ID_43" 179155, \
 "*NODE_42_length_14880_cov_193.741_ID_83" 211364, \
 "*NODE_53_length_7638_cov_165.074_ID_105" 226243, \
 "NODE_40_length_16023_cov_139.429_ID_79" 233880, \
 "NODE_51_length_9054_cov_166.601_ID_101" 249902, \
 "NODE_39_length_17294_cov_134.567_ID_77" 258955, \
 "*NODE_18_length_35505_cov_161.781_ID_35" 276248, \
 "NODE_28_length_26841_cov_193.821_ID_55" 311752, \
 "*NODE_62_length_2331_cov_161.982_ID_123" 338592, \
 "*NODE_56_length_5346_cov_122.835_ID_111" 340922, \
 "NODE_45_length_14567_cov_144.176_ID_89" 346267, \
 "NODE_63_length_2274_cov_424.358_ID_125" 360833, \
 "NODE_6_length_68942_cov_138.218_ID_11" 363106, \
 "NODE_4_length_80283_cov_128.066_ID_7" 432047, \
 "*NODE_64_length_2108_cov_119.866_ID_127" 512329, \
 "*NODE_11_length_40658_cov_121.101_ID_21" 514436, \
 "NODE_61_length_3496_cov_342.556_ID_121" 555093, \
 "NODE_30_length_24045_cov_150.577_ID_59" 558588, \
 "NODE_2_length_103385_cov_130.814_ID_3" 582632, \
 "NODE_20_length_32727_cov_134.844_ID_39" 686016, \
 "NODE_52_length_8504_cov_196.648_ID_103" 718742, \
 "*NODE_24_length_31051_cov_121.305_ID_47" 727245, \
 "*NODE_46_length_13408_cov_126.631_ID_91" 758295, \
 "NODE_13_length_39157_cov_122.479_ID_25" 771702, \
 "*NODE_16_length_37059_cov_139.023_ID_31" 810858, \
 "*NODE_7_length_53484_cov_137.829_ID_13" 847916, \
 "NODE_1_length_132617_cov_108.04_ID_1" 901399, \
 "NODE_50_length_9070_cov_128.272_ID_99" 1034015, \
 "NODE_49_length_11217_cov_110.523_ID_97" 1043084, \
 "NODE_17_length_35592_cov_136.791_ID_33" 1054300, \
 "*NODE_23_length_31679_cov_133.798_ID_45" 1089891, \
 "NODE_5_length_75213_cov_127.582_ID_9" 1121569, \
 "*NODE_35_length_19764_cov_127.134_ID_69" 1196781, \
 "*NODE_21_length_32624_cov_134.349_ID_41" 1216544, \
 "NODE_65_length_1682_cov_309.837_ID_129" 1249167, \
 "NODE_36_length_19718_cov_133.755_ID_71" 1250848, \
 "*NODE_37_length_19622_cov_164.283_ID_73" 1270565, \
 "*NODE_15_length_37808_cov_140.246_ID_29" 1290186, \
 "NODE_60_length_3734_cov_284.781_ID_119" 1327993, \
 "NODE_27_length_27521_cov_222.386_ID_53" 1331726, \
 "NODE_33_length_21756_cov_152.194_ID_65" 1359246, \
 "NODE_8_length_45217_cov_132.415_ID_15" 1381001, \
 "*NODE_54_length_6704_cov_237.068_ID_107" 1426217, \
 "NODE_44_length_14658_cov_191.055_ID_87" 1432920, \
 "*NODE_38_length_17680_cov_136.463_ID_75" 1447577, \
 "NODE_43_length_14762_cov_187.735_ID_85" 1465256, \
 "*NODE_9_length_43775_cov_147.251_ID_17" 1480017, \
 "NODE_19_length_33133_cov_168.986_ID_37" 1523791, \
 "*NODE_14_length_38202_cov_145.926_ID_27" 1556923, \
 "*NODE_41_length_15522_cov_166.591_ID_81" 1595124, \
 "*NODE_47_length_12310_cov_158.442_ID_93" 1610645, \
 "*NODE_57_length_4424_cov_166.356_ID_113" 1622954, \
 "NODE_31_length_23429_cov_151.688_ID_61" 1627377, \
 "NODE_26_length_30206_cov_147.629_ID_51" 1650805, \
 "NODE_34_length_21372_cov_149.584_ID_67" 1681010, \
 "*NODE_58_length_4349_cov_190.148_ID_115" 1702381, \
 "NODE_67_length_1025_cov_170.631_ID_133" 1706729, \
 "*NODE_55_length_5358_cov_673.616_ID_109" 1707753, \
 "NODE_25_length_30294_cov_172.602_ID_49" 1713110, \
 "*NODE_48_length_12073_cov_167.187_ID_95" 1743403, \
 "*NODE_32_length_23292_cov_168.36_ID_63" 1755475, \
 "NODE_29_length_26330_cov_130.841_ID_57" 1778766, \
 "" 1805160 \
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
set yrange [1:1805160]
set style line 1  lt 1 lw 3 pt 6 ps 1
set style line 2  lt 3 lw 3 pt 6 ps 1
set style line 3  lt 2 lw 3 pt 6 ps 1
plot \
 "SRR1061347.fplot" title "FWD" w lp ls 1, \
 "SRR1061347.rplot" title "REV" w lp ls 2
