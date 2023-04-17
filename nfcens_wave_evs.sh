#!/bin/bash

#------------------------------------------------
# Run the NFCENS EVS prep, stats, plots and      
# transfer the plots to emcrzdm                  
#                                                
# Deanna Spindler                                
# 15 February 2023                               
#------------------------------------------------

srcDir='/path/to/cron/scripts'
EVShome='/path/to/EVS'
NFCENSecf="${EVShome}/ecf/nfcens"

job1=$(qsub ${NFCENSecf}/prep/jevs_nfcens_wave_grid2obs_prep.ecf)
job2=$(qsub -W depend=afterok:${job1} ${NFCENSecf}/stats/jevs_nfcens_wave_grid2obs_stats.ecf)
job3=$(qsub -W depend=afterok:${job2} ${NFCENSecf}/plots/jevs_nfcens_wave_grid2obs_plots.ecf)
qsub -W depend=afterok:${job3} ${srcDir}/transfer_nfcens_evs.pbs

