#!/bin/bash
# This script must be called from the directory where it is located
# to get the repository path right.
REPO=../fileMavenRepository
echo "Installing files into the file repository $REPO"
for i in *.jar; do
  # The file names are required to have the form
  # artifactId-majorversion.minorversion.jar
  # Thus, we remove everything after the artifactId here
  # to actually get the artifactId.
  artifactId=`echo $i | sed -E 's/-[0-9]+\.[0-9]+.*//'`;
  # Here, we match the whole file name but use a capture group
  # (the parenthesis) to get the version number.
  version=`echo $i | sed -E 's/.*-([0-9]+\.[0-9]+.*).jar/\1/'`;
  mvn org.apache.maven.plugins:maven-install-plugin:2.3.1:install-file -Dfile=$i -DgroupId=de.aquadiva -DartifactId=$artifactId -Dversion=$version -Dpackaging=jar -DlocalRepositoryPath=$REPO
done
