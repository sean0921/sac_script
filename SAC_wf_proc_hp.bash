#!/usr/bin/env bash
# -*- encoding: utf-8 -*-

# show commands we are runnning, and if there's any error, abort this script.
set -eux

filt_type='hp'   # type of filter
f_min="1"        # low bound
nc="2"           # number of poles
tape_rate="0.02" #apply taper 0.02%
name_tail='.hp'  # appended text

work_path="$HOME/data/14241254.P19_2"

printf "working on: $work_path \n"

for i in $(ls $work_path/*.sac)
do sac <<END
r $i
rmean;rtr;taper width $tape_rate
$filt_type n $nc c $f_min
w append $name_tail q
END

