set terminal png tiny size 800,800
set output "SRR1061346.png"
set ytics ( \
 "NODE_60_length_4289_cov_128.727_ID_119" 1, \
 "NODE_3_length_93491_cov_186.056_ID_5" 4289, \
 "*NODE_11_length_39761_cov_165.948_ID_21" 97779, \
 "*NODE_9_length_41643_cov_182.016_ID_17" 137539, \
 "NODE_21_length_32210_cov_157.237_ID_41" 179181, \
 "*NODE_42_length_14893_cov_215.86_ID_83" 211390, \
 "*NODE_54_length_7638_cov_181.47_ID_107" 226282, \
 "NODE_40_length_16049_cov_151.944_ID_79" 233919, \
 "NODE_52_length_9054_cov_177.428_ID_103" 249967, \
 "NODE_39_length_17320_cov_151.594_ID_77" 259020, \
 "*NODE_17_length_35505_cov_166.283_ID_33" 276339, \
 "NODE_28_length_26854_cov_214.405_ID_55" 311843, \
 "*NODE_66_length_1682_cov_329.245_ID_131" 338696, \
 "*NODE_63_length_2344_cov_198.3_ID_125" 340377, \
 "*NODE_56_length_5372_cov_158.59_ID_111" 342720, \
 "NODE_45_length_14580_cov_148.38_ID_89" 348091, \
 "NODE_64_length_2274_cov_439.011_ID_127" 362670, \
 "NODE_6_length_68941_cov_149.738_ID_11" 364943, \
 "NODE_4_length_80296_cov_141.416_ID_7" 433883, \
 "*NODE_65_length_2121_cov_158.732_ID_129" 514178, \
 "*NODE_10_length_40660_cov_129.701_ID_19" 516298, \
 "NODE_62_length_3386_cov_175.72_ID_123" 556957, \
 "NODE_29_length_24045_cov_159.3_ID_57" 560342, \
 "NODE_2_length_103385_cov_137.65_ID_3" 584386, \
 "NODE_19_length_32740_cov_154.201_ID_37" 687770, \
 "NODE_53_length_8517_cov_214.179_ID_105" 720509, \
 "*NODE_23_length_31064_cov_136.018_ID_45" 729025, \
 "*NODE_46_length_13421_cov_147.767_ID_91" 760088, \
 "*NODE_12_length_39170_cov_143.386_ID_23" 773508, \
 "*NODE_15_length_37059_cov_164.335_ID_29" 812677, \
 "*NODE_7_length_53497_cov_170.473_ID_13" 849735, \
 "NODE_1_length_148774_cov_111.131_ID_1" 903231, \
 "NODE_51_length_9070_cov_135.858_ID_101" 1052004, \
 "NODE_49_length_11243_cov_112.515_ID_97" 1061073, \
 "NODE_16_length_35592_cov_148.448_ID_31" 1072315, \
 "*NODE_22_length_31679_cov_148.146_ID_43" 1107906, \
 "NODE_5_length_75226_cov_142.232_ID_9" 1139584, \
 "*NODE_34_length_19790_cov_143.318_ID_67" 1214809, \
 "*NODE_20_length_32564_cov_134.578_ID_39" 1234598, \
 "NODE_35_length_19731_cov_130.606_ID_69" 1267161, \
 "*NODE_57_length_5358_cov_817.285_ID_113" 1286891, \
 "*NODE_36_length_19622_cov_170.512_ID_71" 1292248, \
 "*NODE_14_length_37821_cov_149.477_ID_27" 1311869, \
 "NODE_61_length_3734_cov_311.419_ID_121" 1349689, \
 "NODE_32_length_21782_cov_179.395_ID_63" 1353422, \
 "*NODE_27_length_27276_cov_131.107_ID_53" 1375203, \
 "NODE_38_length_17608_cov_147.487_ID_75" 1402478, \
 "*NODE_55_length_6704_cov_239.469_ID_109" 1420085, \
 "NODE_44_length_14658_cov_213.591_ID_87" 1426788, \
 "*NODE_37_length_17693_cov_141.076_ID_73" 1441445, \
 "NODE_43_length_14762_cov_193.111_ID_85" 1459137, \
 "*NODE_8_length_43789_cov_161.563_ID_15" 1473898, \
 "NODE_18_length_33146_cov_175.05_ID_35" 1517686, \
 "*NODE_13_length_38202_cov_143.291_ID_25" 1550831, \
 "*NODE_41_length_15478_cov_146.606_ID_81" 1589032, \
 "*NODE_47_length_12323_cov_171.571_ID_93" 1604509, \
 "*NODE_58_length_4437_cov_189.763_ID_115" 1616831, \
 "NODE_30_length_23442_cov_156.71_ID_59" 1621267, \
 "NODE_25_length_30219_cov_149.947_ID_49" 1644708, \
 "NODE_33_length_21385_cov_152.995_ID_65" 1674926, \
 "*NODE_59_length_4349_cov_215.493_ID_117" 1696310, \
 "NODE_68_length_1038_cov_276.214_ID_135" 1700658, \
 "NODE_26_length_27521_cov_196.975_ID_51" 1701695, \
 "NODE_24_length_30307_cov_190.631_ID_47" 1729215, \
 "*NODE_48_length_12086_cov_188.717_ID_95" 1759521, \
 "*NODE_31_length_23261_cov_159.29_ID_61" 1771606, \
 "NODE_50_length_10173_cov_142.643_ID_99" 1794866, \
 "" 1805104 \
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
set yrange [1:1805104]
set style line 1  lt 1 lw 3 pt 6 ps 1
set style line 2  lt 3 lw 3 pt 6 ps 1
set style line 3  lt 2 lw 3 pt 6 ps 1
plot \
 "SRR1061346.fplot" title "FWD" w lp ls 1, \
 "SRR1061346.rplot" title "REV" w lp ls 2
