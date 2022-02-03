# get_next_line

## file descriptor
|int|name|constant(unistd.h)|flux|
|:---|:---|:---|:---|
|0|standard input|STDIN_FILENO|stdin|
|1|standard output|STDOUT_FILENO|stdout|
|2|standard error|STDERR_FILENO|stderr|


TEST
BUFFER_SIZE + 1
Set tout a \0 apres read
cc -Wall -Wextra -Werror -g3 -fsanitize=adress
Check malloc by using "NULL"
ulimit -a ==> check la limite maximale de file descriptor
ulimit -n 5000 ==> changer la limiete maximale de file descriptor
