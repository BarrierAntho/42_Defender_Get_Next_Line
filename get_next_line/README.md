# get\_next\_line

## Version

|Date(YYYY-MM-DD)|Version|Comment|
|:---|:---|:---|
|2021-02-03|v1.0|init|
|2021-02-03|v1.1|update runfile and README, does not include bonus checks|

---

## Content
- [File descriptor](#file-descriptor)
- [Check part](#check-part)
- [How use the tester](#how-use-the-tester)

---

## File descriptor
|int|name|constant(unistd.h)|flux|
|:---|:---|:---|:---|
|0|standard input|STDIN\_FILENO|stdin|
|1|standard output|STDOUT\_FILENO|stdout|
|2|standard error|STDERRi\_FILENO|stderr|
|x >= 3|other fd|||

:warning: *_Make sure to not have any issue with BUFFER_SIZE = 2147483647. Because there is a memory issue if malloc(char) * (BUFFER_SIZE + 1)._* 

## Check part :mag:
- Check protection after a malloc. Make sure return 0 will stop the program without crash and leaks.
- For bonus, protect the max number of file descriptor to avoid any crash of the program. You can change the limit of opened fd in the same time with ulimit.
	```
	ulimit -a ==> check actual max limitation of fd.
	ulimit -n 5000 ==> change actual max liitation of fd.
	```

---

## How use the tester :checkered\_flag:

1. Clone repository `git clone https://github.com/BarrierAntho/42_Defender.git`  
2. Go to the directory "42\_Defender\\get\_next\_line"
3. Copy-paste workfiles "get\_next\_line" into the directory "./gnl" `cp -R <workfiles_directory>/* gnl/` 
4. Run `make norme` and `make check` to check "norminette" and "forbidden files/functions"
5. Run `make` to build a library file "libgnl.a"
6. Manual check test
	1. Run `make run b=xxx` where **x represents BUFFERSIZE** and build an executable program "a.out"
	2. Execute the program `./a,out filename` where **filename must represents one file from test/file directory**
7. Automatic check test
	1. Run `make test` that will compile and use the get\_next\_line workfiles and test it with files from "test/file".
	2. Check content of "test/result" directory. :bangbang: *_never delete test/result directory_*
		- The program will generate a file result according to one original file + a BUFFERSIZE.
		- The program will generate a "diff.log" file where comparison is written and described in it"

