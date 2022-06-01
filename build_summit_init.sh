#!/bin/bash

# Load modules
#--------------------- 
 module load python cuda gcc cmake

#Create environment 
#--------------------- 
#conda create -n galgo 

#Activate environment
 source ~/.bashrc
 conda activate galgo 
 
#Install conan 
#--------------------- 
 conda install -c conda-forge conan 

#Setup conan profile 
#--------------------- 
 conan profile new default --detect 
 conan profile update settings.compiler.libcxx=libstdc++11 default 
 conan profile update settings.compiler.version=9.1 default
 conan profile update env.CC=$(which gcc) default 
 conan profile update env.CXX=$(which g++) default 

#Install dependencies  
#--------------------- 
 conan create conan/waf-generator user/stable 
 conda --version 
 conan create conan/trng 4.24@user/stable 
 conan create conan/nvidia-cub user/stable

 conan install . --build fmt
 conan install . --build spdlog 

#Configure and build
#--------------------- 
 ./waf configure --enable-cuda build_relese
