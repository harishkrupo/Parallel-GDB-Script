#!/bin/bash
# Author: KPS Harish Krupo
# GPL v3 license. See attached LICENSE file for more details

function usage()
{
	echo -e "\t Usage: sh pargdb.sh \"Name of the executing process\" "
}

if [ "$#" -lt 1 ]; then
	usage;
	exit;
fi

SESSION=$USER


tmux new-window -n 'ParGdb'

read -r -a execs <<< $(pidof $1)
arrlen=${#execs[*]}

for i in $(seq 0 $(($arrlen-1)));
do
if [ $i -ne $(($arrlen-1)) ];
then
   tmux split-window -h;
fi
tmux select-pane -t $i
tmux send-keys "gdb $1 ${execs[$(($arrlen-$i-1))]}" C-m  
done;

tmux select-layout even-horizontal
tmux setw synchronize-panes on
