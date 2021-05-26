#!/bin/bash

# rm -rf testdata/2del/*

# create the output directory (and parents):
mkdir -p testdata/2del/blog


# get help on the following parameters: «python ./lazyblorg.py --help»

# when setting up your own system, you might want to:
# 1. have separate directories for generating your blog and staging/publishing your blog
# 2. rename everything with «2del» to an appropriate name
# 3. copy generated blog data to staging/publishing directory
# 4. point --previous-metadata to the corresponding pk-file in your staging/publishing directory
# 5. modify --orgfiles so that your org-mode files are parsed
#    don't forget to include your version of «about-placeholder.org» and «blog-format.org»

DIR=~/git/kephale/lazyblorg
TARGET_DIR=~/git/kephale/computational.life

source ~/anaconda3/etc/profile.d/conda.sh
conda activate lazyblorg

# PYTHONPATH="~/src/lazyblorg:"
~/git/kephale/lazyblorg/lazyblorg.py \
    --orgfiles ~/org/*.org ~/git/kephale/lazyblorg/templates/blog-format.org \
    --targetdir $TARGET_DIR \
    --new-metadata ~/git/kephale/lazyblorg/new_metadata.pk \
    --previous-metadata ~/git/kephale/lazyblorg/old_metadata.pk \
    --logfile $DIR/logfile.org && cp new_metadata.pk old_metadata.pk 

# $DIR/lazyblorg.py \
#     --targetdir testdata/2del/blog \
#     --previous-metadata $DIR/NONEXISTING_-_REPLACE_WITH_YOUR_PREVIOUS_METADATA_FILE.pk \
#     --new-metadata $DIR/2del-metadata.pk \
#     --logfile $DIR/2del-logfile.org \
#     --orgfiles testdata/end_to_end_test/orgfiles/test.org \
#                testdata/end_to_end_test/orgfiles/about-placeholder.org \
#                templates/blog-format.org $@

DATE=$(date --iso-8601='seconds')
COMMIT_MSG="Update on $DATE"
cd $TARGET_DIR
git add *
git commit -m "$COMMIT_MSG"
git push

#END
