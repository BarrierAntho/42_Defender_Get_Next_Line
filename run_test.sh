#!/bin/bash

SEP_P="#########################"
SEP_SP="------------------------"

BK_RD='\033[31;7m'
BK_GN='\033[32;7m'
BK_YE='\033[33;7m'
RD='\033[0;31m'
GN='\033[0;32m'
YE='\033[0;33m'
BU='\033[0;34m'
MG='\033[0;35m'
NC='\033[0m'

ORI_P=$(pwd)
TEST_P=${ORI_P}/test
FILE_P=${TEST_P}/file
RES_P=${TEST_P}/result
DIFF_N="diff.log"
DIFF_N_TMP="diff_tmp.log"

CC=gcc
#CFLAGS="-Werror -Wall -Wextra -g3 -fsanitize=address"
#CFLAGS="-Werror -Wall -Wextra -Wconversion -g3 -fsanitize=address"
CFLAGS="-Werror -Wall -Wextra -Wconversion -g3"
SRCS=$(find gnl -type f \( -iname "*.c" ! -iname "*bonus.c" \))
INCLUDES=gnl
PROG_N=a.out
BUFS=(-1 1 2 3 4 5 6 7 8 9 10 11 12 13 42 100 1000 10000 2147483647)

function	put_msg()
{
	if [ -z ${1} ]
	then
		MSGFUNC=""
	else
		MSGFUNC=${1}
	fi

	case "${2}" in
		1)
			MSGTYPE="error | "
			MSGCOLOR=${RD}
			;;
		2)
			MSGTYPE="error | "
			MSGCOLOR=${YE}
			;;
		3)
			MSGTYPE="error | "
			MSGCOLOR=${GN}
			;;
		11)
			MSGTYPE="important | "
			MSGCOLOR=${RD}
			;;
		12)
			MSGTYPE="important | "
			MSGCOLOR=${YE}
			;;
		13)
			MSGTYPE="important | "
			MSGCOLOR=${GN}
			;;
		21)
			MSGTYPE="avertissement | "
			MSGCOLOR=${RD}
			;;
		22)
			MSGTYPE="avertissement | "
			MSGCOLOR=${YE}
			;;
		23)
			MSGTYPE="avertissement | "
			MSGCOLOR=${GN}
			;;
		31)
			MSGTYPE="info | "
			MSGCOLOR=${RD}
			;;
		32)
			MSGTYPE="info | "
			MSGCOLOR=${YE}
			;;
		33)
			MSGTYPE="info | "
			MSGCOLOR=${GN}
			;;
		1001)
			MSGTYPE="/!\\ "
			MSGCOLOR=${BK_RD}
			;;
		1002)
			MSGTYPE="/!\\ "
			MSGCOLOR=${BK_YE}
			;;
		1003)
			MSGTYPE="/!\\ "
			MSGCOLOR=${BK_GN}
			;;
		*)
			MSGTYPE=""
			MSGCOLOR=${NC}
			;;
	esac

	echo -e "${MSGCOLOR}[${MSGFUNC}] ${MSGTYPE} ${3}${NC}"
	return 0
}

function	mandatory()
{
	local FUNC_N="mandatory"
	for i in ${FILE_P}/*.txt
	do
		put_msg ${FUNC_N} 0 "Progress on : ${i}"
		DIR_N=$(basename -a -s ".txt" ${i})
		mkdir -p ${RES_P}/${DIR_N}
		for j in ${BUFS[@]}
		do
			put_msg ${FUNC_N} 32 "Test with BUFFER_SIZE = ${j}"
			${CC} ${CFLAGS} -D BUFFER_SIZE=${j} main.c ${SRCS} ${INCLUDES}/get_next_line.h 
			./${PROG_N} ${i} > "${RES_P}/${DIR_N}/res_${DIR_N}_b${j}.txt"
			rm -rf ${PROG_N}_${j}
		done

		put_msg ${FUNC_N} 0 "diff process"
		rm -rf ${RES_P}/${DIR_N}/${DIFF_N}
		echo "" > ${RES_P}/${DIR_N}/${DIFF_N}

		for k in ${RES_P}/${DIR_N}/*
		do
			if [ ${k} != ${RES_P}/${DIR_N}/${DIFF_N} ]
			then
				echo "compare file $(basename -a -s ".txt" ${i}) vs $(basename -a -s ".txt" ${k})" >> ${RES_P}/${DIR_N}/${DIFF_N}
				diff ${i} ${k} >> ${RES_P}/${DIR_N}/${DIFF_N_TMP}
				if [ -s ${RES_P}/${DIR_N}/${DIFF_N_TMP} ]
				then
					put_msg ${FUNC_N} 21 "result $(basename -a -s ".txt" ${k}): KO"
				else
					put_msg ${FUNC_N} 23 "result $(basename -a -s ".txt" ${k}): OK"
				fi
				cat ${RES_P}/${DIR_N}/${DIFF_N_TMP} >> ${RES_P}/${DIR_N}/${DIFF_N}
				rm -rf ${RES_P}/${DIR_N}/${DIFF_N_TMP}
				echo "${SEP_SP}" >> ${RES_P}/${DIR_N}/${DIFF_N}
			fi
		done
		put_msg ${FUNC_N} 0 ${SEP_P}
	done
	rm -rf ${PROG_N}
	return 0
}

function	checkfiles()
{
	local FUNC_N="checkfiles"
	if [ ! -e ${1} ]
	then
		put_msg ${FUNC_N} 1 "path does not exist: ${1}"
		exit 1
	else
		put_msg ${FUNC_N} 33 "path does exist: ${1}"
	fi
	return 0
}

function	main()
{
	local FUNC_N="main"

	put_msg ${FUNC_N} 32 "check files"
	checkfiles ${TEST_P}
	checkfiles ${FILE_P}

	put_msg ${FUNC_N} 11 "delete result files from: ${RES_P}"
	rm -rf ${RES_P}/*
	
	put_msg ${FUNC_N} 32 "BUFFER_SIZE array: $(IFS=, ; echo "${BUFS[*]}")"

	mandatory
	put_msg ${FUNC_N} 0 "diff.log result have been created. To see the content, run:\ncat -e ${RES_P}/*/${DIFF_N}"
	return 0
}

### PROGRAM START ###
clear && echo "Terminal cleared"
put_msg ${0} 1002 "Program start"
sleep 1
main
put_msg ${0} 1002 "Program end"
exit 0
### PROGRAM END ###
