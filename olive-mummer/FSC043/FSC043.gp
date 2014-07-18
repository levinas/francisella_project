set terminal png tiny size 800,800
set output "FSC043.png"
set ytics ( \
 "7000000218714946" 1, \
 "7000000218714945" 3195, \
 "" 1893557 \
)
set size 1,1
set grid
unset key
set border 10
set ticscale 0 0
set xlabel "NC_006570"
set ylabel "QRY"
set format "%.0f"
set mouse format "%.0f"
set mouse mouseformat "[%.0f, %.0f]"
set mouse clipboardformat "[%.0f, %.0f]"
set xrange [1:1892775]
set yrange [1:1893557]
set style line 1  lt 1 lw 3 pt 6 ps 1
set style line 2  lt 3 lw 3 pt 6 ps 1
set style line 3  lt 2 lw 3 pt 6 ps 1
plot \
 "FSC043.fplot" title "FWD" w lp ls 1, \
 "FSC043.rplot" title "REV" w lp ls 2
