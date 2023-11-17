# Assignment 3
The [Reproduce_Result_11_711_Assignment.ipynb](https://github.com/ANLP-GROUP-38/goemotion_baseline/blob/main/Reproduce_Result_11_711_Assignment.ipynb) 
contains the codes used for reproducing the paper results.


# GoEmotions

**GoEmotions** is a corpus of 58k carefully curated comments extracted from Reddit,
with human annotations to 27 emotion categories or Neutral.

* Number of examples: 58,009.
* Number of labels: 27 + Neutral.
* Maximum sequence length in training and evaluation datasets: 30.

On top of the raw data, we also include a version filtered based on reter-agreement, which contains a train/test/validation split:

* Size of training dataset: 43,410.
* Size of test dataset: 5,427.
* Size of validation dataset: 5,426.

The emotion categories are: _admiration, amusement, anger, annoyance, approval,
caring, confusion, curiosity, desire, disappointment, disapproval, disgust,
embarrassment, excitement, fear, gratitude, grief, joy, love, nervousness,
optimism, pride, realization, relief, remorse, sadness, surprise_.


This directory includes the data and code for data analysis scripts. We also
include code for our baseline model, which involves fine-tuning a pre-trained
[BERT-base model](https://github.com/google-research/bert).


## Requirements

See `requirements.txt`

## Setup

Download the pre-trained BERT model from
[here](https://github.com/google-research/bert) and unzip them inside the
`bert` directory. In the paper, we use the cased base model.

## Data

Our raw dataset can be retrieved by running:

```
wget -P data/full_dataset/ https://storage.googleapis.com/gresearch/goemotions/data/full_dataset/goemotions_1.csv
wget -P data/full_dataset/ https://storage.googleapis.com/gresearch/goemotions/data/full_dataset/goemotions_2.csv
wget -P data/full_dataset/ https://storage.googleapis.com/gresearch/goemotions/data/full_dataset/goemotions_3.csv
```

See the `data` folder for more detailed data information.

### Data Format
Our raw dataset, split into three csv files, includes all annotations as well as metadata on the comments. Each row represents a single rater's annotation for a single example. This file includes the following columns:

* `text`: The text of the comment (with masked tokens, as described in the paper).
* `id`: The unique id of the comment.
* `author`: The Reddit username of the comment's author.
* `subreddit`: The subreddit that the comment belongs to.
* `link_id`: The link id of the comment.
* `parent_id`: The parent id of the comment.
* `created_utc`: The timestamp of the comment.
* `rater_id`: The unique id of the annotator.
* `example_very_unclear`: Whether the annotator marked the example as being very unclear or difficult to label (in this case they did not choose any emotion labels).
* separate columns representing each of the emotion categories, with binary labels (0 or 1)

The data we used for training the models includes examples where there is agreement between at least 2 raters. Our data includes 43,410 training examples (`train.tsv`), 5426 dev examples (`dev.tsv`) and 5427 test examples (`test.tsv`). These files have _no header row_ and have the following columns:

1. text
2. comma-separated list of emotion ids (the ids are indexed based on the order of emotions in `emotions.txt`)
3. id of the comment


### Visualization

[Here](https://nlp.stanford.edu/~ddemszky/goemotions/tsne.html) you can view a TSNE projection showing a random sample of the data. The plot is generated using PPCA (see scripts below). Each point in the plot represents a single example and the text and the labels are shown on mouse-hover. The color of each point is the weighted average of the RGB values of the those emotions.


## Data Analysis

See each script for more documentation and descriptive command line flags.

*   `python3 -m analyze_data`: get high-level statistics of the
    data and correlation among emotion ratings.
*   `python3 -m extract_words`: get the words that are significantly
    associated with each emotion, in contrast to the other emotions, based on
    their log odds ratio.
*   `python3 -m ppca`: run PPCA
    [(Cowen et al., 2019)](https://www.nature.com/articles/s41562-019-0533-6) on
    the data and generate plots.

## Training and Evaluating Models

Run `python -m bert_classifier` to perform fine-tuning on top of
BERT, with added regularization. See the script and the paper for detailed
description of the flags and parameters.
