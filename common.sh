STAT(){
  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[32mFAILURE\e[0m"
    echo Check the error in $LOG file
    exit
  fi
}

PRINT(){
  echo -e "\e[33m$1\e[0m"
}

LOG=/tmp/$COMPONENT.log
rm -rf $LOG