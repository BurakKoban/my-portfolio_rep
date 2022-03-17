#!/bin/bash

FOLDER="https://raw.githubusercontent.com/BurakKoban/my-portfolio_rep/main/Project-006-kittens-carousel-static-web-s3-cf/static-web/"

aws s3 cp $FOLDER/index.html s3://kittens.kobanweb.link
aws s3 cp $FOLDER/cat0.jpg s3://kittens.kobanweb.link
aws s3 cp $FOLDER/cat1.jpg s3://kittens.kobanweb.link
aws s3 cp $FOLDER/cat2.jpg s3://kittens.kobanweb.link