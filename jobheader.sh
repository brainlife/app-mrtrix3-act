#!/bin/bash

##figure out amount of wall time we really need by parsing config.json with jq
if [ "$(jq .num_fibers -r config.json)" -gt 30000 ]; then
    walltime=48:00:00
else
    walltime=36:00:00
fi

echo "#PBS -l nodes=1:ppn=8,vmem=28gb"
echo "#PBS -l walltime=$walltime"
