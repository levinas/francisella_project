set terminal png tiny size 800,800
set output "NR-28534.png"
set ytics ( \
 "7000000218710702" 1, \
 "7000000218710701" 3195, \
 "" 1892972 \
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
set yrange [1:1892972]
set style line 1  lt 1 lw 3 pt 6 ps 1
set style line 2  lt 3 lw 3 pt 6 ps 1
set style line 3  lt 2 lw 3 pt 6 ps 1
plot \
 "NR-28534.fplot" title "FWD" w lp ls 1, \
 "NR-28534.rplot" title "REV" w lp ls 2
