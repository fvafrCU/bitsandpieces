#!/bin/dash
# based on https://cran.r-project.org/bin/linux/debian/#installing-r-devel-or-a-release-branch-from-svn
export RTOP=~/svn/R
export REPOS=https://svn.r-project.org/R
cd $RTOP

# get/update source
if [ -d r-devel ]; then 
    cd $RTOP/r-devel/source
    svn up
else 
    svn co $REPOS/trunk r-devel/source
    mkdir $RTOP/r-devel/build
fi

# update recommended
if [ $(hostname) == "fvafrdebianCU" ]; then
    cd $RTOP/r-devel/source/src/library/Recommended
    version=$(cut -f1 -d' ' ../../../VERSION)
    rm *tgz
    rm *tar.gz
    rm index.html
    wget https://cran.r-project.org/src/contrib/${version}/Recommended/
    files=$(grep tar.gz index.html | cut -d'>' -f7 | cut -d'<' -f1)
    for file in $files
    do
      wget https://cran.r-project.org/src/contrib/${version}/Recommended/$file
    done
    echo "Creating links"
    rm -f *.tgz
    PKGS=$(ls  *tar.gz | cut -f1 -d"_")
    for i in ${PKGS} ; do
      ln -s $i*.tar.gz ${i}.tgz
    done
else
    cd $RTOP/r-devel/source
    ./tools/rsync-recommended
fi

cd $RTOP/r-devel/build 
../source/configure
make

ln -s $RTOP/r-devel/build/bin/R ~/bin/R-devel
ln -s $RTOP/r-devel/build/bin/Rscript ~/bin/Rscript-devel