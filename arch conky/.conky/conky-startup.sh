sleep 20s
killall conky
cd "/home/h4x3d/.conky/conkyrings"
conky -c "/home/h4x3d/.conky/conkyrings/cpu" &
cd "/home/h4x3d/.conky/conkyrings"
conky -c "/home/h4x3d/.conky/conkyrings/mem" &
cd "/home/h4x3d/.conky/conkyrings"
conky -c "/home/h4x3d/.conky/conkyrings/rings" &
cd "/home/h4x3d/.conky"
conky -c "/home/h4x3d/.conky/first_conky" &
