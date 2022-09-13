SEP_P		=	"------------------------------"
SEP_SP		=	"******************************"

ifndef (${b})
 BUFFER_SIZE=1
else
 BUFFER_SIZE=${b}
endif

DIR_S		= 	gnl

SOURCES		=	get_next_line.c\
			get_next_line_utils.c

SRCS		=	${addprefix ${DIR_S}/, ${SOURCES}}

OBJS		=	${SRCS:.c=.o}

INCLUDES	=	${DIR_S}
CC		=	gcc
CFLAGS		=	-Werror -Wall -Wextra 
#CFLAGS		=	-Werror -Wall -Wextra -g3 -fsanitize=address
#CFLAGS		=	-Werror -Wall -Wextra -Wconversion -g3 -fsanitize=address

COMPILE		=	${CC} ${CFLAGS} -o ${NAME} -I ${INCLUDES}

RM		=	rm -rf

NAME	=	gnl.out

copy:
			mkdir -p ${DIR_S}
			cp ../get_next_line*.c ${DIR_S}
			cp ../get_next_line*.h ${DIR_S}
			make all

all:		${NAME}

${NAME}:	${OBJS}
			${COMPILE} -D BUFFER_SIZE=${BUFFER_SIZE} main.c ${SRCS}

%.o: %.c
			${CC} ${CFLAGS} -I ${INCLUDES} -c $< -o $@

clean:
			${RM} ${OBJS}

fclean:			clean
			${RM} ${NAME}
			${RM} *dSYM*

re:			fclean copy

norme:
			@echo ${SEP_P}
			norminette ${DIR_S}

check:
			@echo ${SEP_P}
			@echo "Check forbidden function"
			grep --color=always -RiEn 'main' . 
			@echo ${SEP_SP}
			grep --color=always -RiEn '[^_]printf' .
			@echo ${SEP_SP}
			grep --color=always -RiEn '[^_]strlen' .
			@echo ${SEP_SP}
			grep --color=always -RiEn '[^_]atoi' .
			@echo ${SEP_SP}
			grep --color=always -RiEn '[^_]putchar' .
			@echo ${SEP_SP}
			grep --color=always -RiEn '[^_]putstr' .
			@echo ${SEP_P}
			@echo "Check exec (a.out)"
			@find ${DIR_S} -type f -name "a.out" -print
			@echo ${SEP_P}
			@echo "Check *.gch"
			@find ${DIR_S} -type f -name "*.gch" -print
			@echo ${SEP_P}
			@echo "Check *.gch*"
			@find ${DIR_S} -name "*.gch*" -print
			@echo ${SEP_P}
			@echo "Check *.swp"
			@find ${DIR_S} -type f -name "*.swp" -print
			@echo ${SEP_P}
			@echo "Check *.o"
			@find ${DIR_S} -type f -name "*.o" -print

test:
			${COMPILE} -D BUFFER_SIZE=${BUFFER_SIZE} main.c ${SRCS}
			@echo ${SEP_P}
			./${NAME} test/file/gnl_000.txt

run:
			./run_test.sh

.PHONY:		copy all clean fclean re norme check test run 
