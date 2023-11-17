#!/bin/bash
#SBATCH --job-name=heavy
#SBATCH --output=bert_eval.out
#SBATCH --error=bert_eval.err
#SBATCH --partition=babel-shared-long
#SBATCH --gres=gpu:2
#SBATCH --cpus-per-task=8
#SBATCH --mem=100G
#SBATCH --time=2-00:00:00

# Your job commands go here
python -m bert_classifier --data_dir ./data --vocab_file ./bert/cased_L-12_H-768_A-12/vocab.txt --bert_config_file ./bert/cased_L-12_H-768_A-12/bert_config.json --output_dir /data/user_data/gonilude/lab_3