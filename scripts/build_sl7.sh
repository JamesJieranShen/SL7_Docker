#!/bin/bash
docker build -t sl7 $WORK/hep/sl7
echo "Entering Docker... run 'source setup_lar' to setup all environment variables"
docker run -it --rm --name sl7 \
    -v $WORK/hep:/work \
    -v /cvmfs:/cvmfs \
    --user="1000:1000"\
    sl7 bash
