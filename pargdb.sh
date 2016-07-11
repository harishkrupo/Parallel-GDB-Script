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

tmux -2 new-session -d -s $SESSION

tmux new-window -t $SESSION:1 -n 'ParGdb'

read -r -a execs <<< $(pidof $1)
tmux new-window
tmux split-window -h
tmux select-pane -t 0
tmux send-keys "gdb $1 ${execs[1]}" C-m

tmux select-pane -t 1
tmux send-keys "gdb $1 ${execs[0]}" C-m
tmux setw synchronize-panes on
