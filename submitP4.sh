#!/bin/sh
# submit code for assignment P3, after doing a few simple sanity checks
ASSIGNMENT=P4
GRADER=cop4610p@cs.fsu.edu
HOSTNAME=`uname -a`
SYSTEMS="Linux SunOS"
OSNAME=`uname -s`
PATH=/bin\:/usr/bin
if [ ${OSNAME} = "Linux" ]; then
  MAIL=mail
elif [ ${OSNAME} = "SunOS" ]; then
  MAIL=mailx
elif [ ${OSNAME} = "Darwin" ]; then
  MAIL=mail
else
  echo unrecognized OS; this script must run on Linux or SunOS
  exit -1;
fi;
for SUFFIX in .tgz .uu; do
  if [ -f ${ASSIGNMENT}${SUFFIX} ]; then
    echo submit aborted: would overwrite file ${ASSIGNMENT}${SUFFIX}
    echo please rename ${ASSIGNMENT}${SUFFIX} or remove it, and then rerun this script
    exit -1;
  fi;
done;
if [ ! -f "multisrv.c" ]; then
  echo submit aborted: missing file "multisrv.c"
  echo please make sure you are in the directory that contains the files 
  echo you want to submit, and then rerun this script
  exit -1;
fi;
SEND="multisrv.c"
tar czpf ${ASSIGNMENT}.tgz ${SEND}
uuencode ${ASSIGNMENT}.tgz ${ASSIGNMENT}.tgz > ${ASSIGNMENT}.uu
${MAIL} -n -s "${ASSIGNMENT} submission" ${GRADER} < ${ASSIGNMENT}.uu
for SUFFIX in .tgz .uu; do
  rm -f ${ASSIGNMENT}${SUFFIX};
done;
echo "sent file(s) [ ${SEND} ] to ${GRADER}"
