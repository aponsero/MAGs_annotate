#!/bin/bash -l
#SBATCH --job-name=install
#SBATCH --account=project_2001503
#SBATCH --output=outputr%j.txt
#SBATCH --error=errors_%j.txt
#SBATCH --partition=small
#SBATCH --time=02:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=1000


# load job configuration
cd $SLURM_SUBMIT_DIR
source ../config/config.sh

# load environment
source $CONDA/etc/profile.d/conda.sh
conda activate annotate

#conda install -c bioconda prodigal
#conda install -c bioconda hmmer

# build HMM databases
cd /scratch/project_2001503/alise/my_data/databases/HMM
#wget https://www.genome.jp/ftp/db/kofam/profiles.tar.gz
#wget https://www.genome.jp/ftp/db/kofam/ko_list.gz

#tar -xvf profiles.tar.gz

#wget http://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.dat.gz
#wget http://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz

#gzip -d Pfam-A.hmm.dat.gz
#gzip -d Pfam-A.hmm.gz

#cd KEGG_29.10.21/profiles
#cat *.hmm >> ../KEGG_29.10.21
#cd ..
#hmmpress KEGG_29.10.21

cd /scratch/project_2001503/alise/my_data/databases/HMM/Pfam_29.10.21
hmmpress Pfam-A


