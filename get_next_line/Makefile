SEP_P		=	"------------------------------"
SEP_SP		=	"******************************"

DIR_S		= 	get_next_line

SOURCES		=	get_next_line.c\
				get_next_line_utils.c
BONUS		=	get_next_line_bonus.c\
				get_next_line_utils_bonus.c

SRCS		=	${addprefix ${DIR_S}/, ${SOURCES}}
BNS			=	${addprefix ${DIR_S}/, ${BONUS}}

OBJS		=	${SRCS:.c=.o}
OBJS_BNS	=	${BNS:.c=.o}

INCLUDES	=	${DIR_S}
CC			=	gcc
#CFLAGS		=	-Werror -Wall -Wextra 
CFLAGS		=	-Werror -Wall -Wextra -Wconversion -g3 -fsanitize=address
#CFLAGS		=	-Werror -Wall -Wextra -g3 -fsanitize=address

RM			=	rm -rf

NAME		=	libgnl.a

%.o : %.c
				${CC} ${CFLAGS} -I ${INCLUDES} -c $< -o $@

${NAME}:		${OBJS}
				ar rc ${NAME} ${OBJS}

bonus:			${BNS}
				ar rc ${NAME} ${BNS}

all:			${NAME}

clean:
				${RM} ${OBJS} ${OBJS_BNS}

fclean:			clean
				${RM} ${NAME}

re:				fclean all

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

run:
				cc ${CFLAGS} -D BUFFER_SIZE=$(b) main.c ${SRCS} ${INCLUDES}/get_next_line.h
#				valgrind --leak-check=yes ./a.out test/file/gnl_004.txt
				@echo ${SEP_P}

run_b:
				cc ${CFLAGS} -D BUFFER_SIZE=$(b) main.c ${BNS} ${INCLUDES}/get_next_line_bonus.h
				@echo ${SEP_P}

test:
				./run_test.sh

test_b:
				./run_test.sh bonus

.PHONY:		all clean fclean re bonus norme check run run_b test test_b
