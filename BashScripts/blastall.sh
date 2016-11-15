#!/bin/bash

#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=2-00:00:00
#SBATCH --mem=16GB

# Notification configuration                                                                    
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=lu.zeng@adelaide.edu.au


# load software need to use          
module load BLAST+/2.2.27-foss-2015b                         
module load BLAST/2.2.26-Linux_x86_64

# Run the executable, compare unknown seqs between two seqs
formatdb -i long.L2.repdenovo.fa -p F -o T -n long.L2.hits
blastall -p blastn -d long.L2.hits -i long.L2.repdenovo.fa -r 2 -F F -m 8 -e 1e-10 -a 16 -o L2_Repdenovo_blastall.out
