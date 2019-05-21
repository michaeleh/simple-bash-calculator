#!/bin/bash

NO_COLOR=`tput sgr0`
GREEN=`tput setaf 2`
RED=`tput setaf 1`
CYAN=`tput setaf 6`

check_for_num(){
	re='^[0-9]+$'
	if ! [[ $1 =~ $re ]] ; then
		FIRST_IDX=$2	
	fi	
}

calc(){
	case "$2" in

"+")  echo $(($1+$3))
    ;;
"-")  echo $(($1-$3))
    ;;
"/") echo $(($1/$3))
   ;;
"^") echo $(($1**$3))
;;
*) echo $(($1*$3))
   ;;
esac
}



parse(){
	for (( i=0; i<${#1}; i++ )); do
  	CHAR="${1:$i:1}"
		check_for_num $CHAR $i		
	done
	SECOND_IDX=($i-$FIRST_IDX)

	FIRST="${1:0:$FIRST_IDX}"
	OP="${1:$FIRST_IDX:1}"
	SECOND="${1:$FIRST_IDX+1:$SECOND_IDX}"
	
	RESULT=$(calc $FIRST $OP $SECOND)
}

echo
echo ${CYAN}
echo "Enter computational expression with 2 operands and 1 operator"
echo "For example:"
echo
echo "  4+5"
echo "  4*5"
echo "  4^5"
echo "  45/5"
echo "  4-5"
echo
echo "write ${RED}exit${CYAN} to ${RED}exit.${NO_COLOR}"
echo

while true; do
	read -p "${CYAN}>> " EXPR
  if [ "$EXPR" = "exit" ];then
    exit 0
  fi
	parse $EXPR
	echo ${CYAN}The answer is ${GREEN}$RESULT${NO_COLOR}
done
