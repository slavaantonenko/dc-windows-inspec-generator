#!/bin/bash 
echo "Caching Chef binaries"
mkdir chef
cp -rf /c/opscode/chef/* chef/
#mkdir librarian
#echo "Caching Librarian-Chef binaries"
#cp -rf /c/opt/librarian-chef/* librarian/