#!/bin/bash -l
#SBATCH --job-name=assembly
#SBATCH --account=project_2001503
#SBATCH --output=errout/outputr%j.txt
#SBATCH --error=errout/errors_%j.txt
#SBATCH --partition=small
#SBATCH --time=02:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=1000


# load job configuration
cd $SLURM_SUBMIT_DIR
source config/config.sh

# load environment
source $CONDA/etc/profile.d/conda.sh
conda activate annotate

# echo for log
echo "job started"; hostname; date

# Get sample ID 
export SMPLE=`head -n +${SLURM_ARRAY_TASK_ID} $IN_LIST | tail -n 1`
echo $SMPLE
SAMPLE_ID=${SMPLE%%.fa}

# create output directories
PROT_DIR="$IN_DIR/Prodigal"
if [[ ! -d "$PROT_DIR" ]]
then
        mkdir $PROT_DIR
fi

HMM_DIR="$IN_DIR/HMM"
if [[ ! -d "$HMM_DIR" ]]
then
        mkdir $HMM_DIR
fi

# run prodigal
prodigal_OUT="$PROT_DIR/${SAMPLE_ID}.gff"
prodigal_FAA="$PROT_DIR/${SAMPLE_ID}.faa"
prodigal_FNA="$PROT_DIR/${SAMPLE_ID}.fna"
prodigal_IN="$IN_DIR/$SMPLE"
#prodigal -a $prodigal_FAA -d $prodigal_FNA -i $prodigal_IN -o $prodigal_OUT -p meta

# run HMM KEGG
KEGG_OUT="$HMM_DIR/${SAMPLE_ID}_KEGG.txt"
hmmscan --tblout $KEGG_OUT $KEGG_DB $prodigal_FAA

# run HMM Pfam-A
PFAM_OUT="$HMM_DIR/${SAMPLE_ID}_PFAM.txt"
hmmscan --tblout $PFAM_OUT $PFAM_DB $prodigal_FAA

# echo for log
echo "job done"; date

