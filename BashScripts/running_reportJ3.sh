#!/bin/bash

#SBATCH -p batch
#SBATCH -N 1 
#SBATCH -n 32 
#SBATCH --time=2-00:00 
#SBATCH --mem=16GB 

# Notification configuration 
#SBATCH --mail-type=END                                         
#SBATCH --mail-type=FAIL                                        
#SBATCH --mail-user=lu.zeng@adelaide.edu.au  


module load wu-blast/2.0 
module load Python/2.7.11-foss-2015b 

perl reportsJ3.pl
