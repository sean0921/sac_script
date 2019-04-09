#!/usr/bin/env bash
# encoding: utf-8

# show commands we are runnning, and if there's any error, abort this script.
set -eux

filt_type='hp'   # type of filter
f_min="1"        # low bound
nc="2"           # number of poles
tape_rate="0.02" #apply taper 0.02%
name_tail='.hp_sh'  # appended text

event_path="$HOME/data/week05_events"

cd $event_path
for j in $(ls -d */)
do cd $j
    for i in $(ls *.sac)
    do
    echo "sac <<END" >> run.bash
    echo "r $i" >> run.bash
    echo "rmean;rtr;taper width $tape_rate" >> run.bash
    echo "$filt_type n $nc c $f_min" >> run.bash
    echo "w append $name_tail" >> run.bash
    echo "quit" >> run.bash
    echo "END" >> run.bash
    /usr/bin/env bash run.bash
    rm run.bash
    done
    cd -
done

