ls ../snps R -j8 'comm -3 <(bcftools view ../map/AJ749949.2_{.}_bwa_mem/mpileup |grep -v "^#"|grep -P "\tDP"|cut -f2) <(seq 1892775) >{.}.uncov.pos'
