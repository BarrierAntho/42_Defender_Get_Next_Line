#!/bin/bash

function mandatory()
{
	for i in ${FILE_P}/*.txt
	do
		echo "Progress on : ${i}"
		DIR_N=$(basename -a -s ".txt" ${i})
		mkdir ${RES_P}/${DIR_N}
		for j in ${BUFS[@]}
		do
			echo "BUFFER_SIZE = ${j}"
			cc ${CFLAGS} -D BUFFER_SIZE=${j} main.c ${SRCS} ${INCLUDES}/get_next_line.h
			./a.out ${i} > "${RES_P}/${DIR_N}/res_${DIR_N}_b${j}.txt"
			echo ${SEP_SP}
		done

		echo "diff process"
		rm -rf ${RES_P}/${DIR_N}/${DIFF_N}
		echo "" > ${RES_P}/${DIR_N}/${DIFF_N}

		for k in ${RES_P}/${DIR_N}/*
		do
			if [ ${k} != ${RES_P}/${DIR_N}/${DIFF_N} ]
			then
				echo "compare file $(basename -a -s ".txt" ${i}) vs $(basename -a -s ".txt" ${k})" >> ${RES_P}/${DIR_N}/${DIFF_N}
				diff ${i} ${k} >> ${RES_P}/${DIR_N}/${DIFF_N}
				echo "${SEP_SP}" >> ${RES_P}/${DIR_N}/${DIFF_N}
			fi
		done
		echo ${SEP_P}
	done
}

SEP_P="#########################"
SEP_SP="------------------------"

ORI_P=$(pwd)
TEST_P=${ORI_P}/test
FILE_P=${TEST_P}/file
RES_P=${TEST_P}/result
RES_P_BNS=${TEST_P}/result_bonus
DIFF_N="diff.log"
IS_BNS=0

#CFLAGS="-Wall -Werror -Wextra -Wconversion"
#CFLAGS="-Werror -Wall -Wextra -g3 -fsanitize=address"
CFLAGS="-Werror -Wall -Wextra -Wconversion -g3 -fsanitize=address"
SRCS=$(find get_next_line -type f \( -iname "*.c" ! -iname "*bonus.c" \))
SRCSBNS=$(find get_next_line -type f \( -iname "*bonus.c" \))
INCLUDES=get_next_line
#cc ${CFLAGS} -D BUFFER_SIZE=${BUFS} main.c ${SRCS} ${INCLUDES}/get_next_line.h
#cc ${CFLAGS} -D BUFFER_SIZE=${BUFS} main.c ${SRCS} ${INCLUDES}/get_next_line_bonus.h

clear && echo "Terminal cleared"

echo "check flag bonus = ${1}"
if [ -z ${1} ]
then
	IS_BNS=0
else
	IS_BNS=1
fi
echo "bonus flag = ${IS_BNS}"

echo "delete result files in: ${RES_P}"
rm -rf ${RES_P}/*
echo ${SEP_P}

BUFS=(-1 1 2 3 4 5 6 7 8 9 10 11 12 13 42 100 1000 10000 2147483647)

mandatory

cat -e ${RES_P}/*/${DIFF_N}

echo "Program end"
