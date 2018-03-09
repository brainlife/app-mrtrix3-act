#!/bin/bash

## version
tag=3.0_RC2

## build and push online
docker build -t brainlife/mrtrix3:$tag . && docker push brainlife/mrtrix3:$tag
