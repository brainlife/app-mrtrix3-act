FROM brainlife/fsl:5.0.9 

MAINTAINER Brent McPherson <bcmcpher@iu.edu> 

RUN apt-get update

## install ants / fsl / other requirements
RUN apt-get install -y ants 

## add N4BiasFieldCorrection to path
ENV export ANTSPATH=/usr/lib/ants
ENV PATH=$PATH:/usr/lib/ants

## run distributed script to set up fsl
#RUN . /etc/fsl/fsl.sh

## install mrtrix3 requirements
RUN apt-get install -y git g++ python python-numpy libeigen3-dev zlib1g-dev libqt4-opengl-dev libgl1-mesa-dev libfftw3-dev libtiff5-dev

## install and compile mrtrix
RUN git clone https://github.com/MRtrix3/mrtrix3.git
RUN cd mrtrix3 && ./configure -nogui && ./build

## manually add to path
ENV PATH=$PATH:/mrtrix3/bin

#make it work under singularity 
RUN ldconfig && mkdir -p /N/u /N/home /N/dc2 /N/soft

#https://wiki.ubuntu.com/DashAsBinSh 
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
