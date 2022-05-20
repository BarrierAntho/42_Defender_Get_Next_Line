# 42 Defender get\_next\_line

## Version

|Date(YYYY-MM-DD)|Version|Comment|
|:---|:---|:---|
|2022-05-20|v1.4|update make run description|
|2021-02-21|v1.3|rebuild of Makefile and bash script run\_test.sh|
|2021-02-21|v1.2|moving all files from get\_next\_line directory to top level of git repo|
|2021-02-03|v1.1|update runfile and README, does not include bonus checks|
|2021-02-03|v1.0|init|

---

## Content
- [File descriptor](#file-descriptor)
- [Check part](#check-part-mag)
- [How use the tester](#how-use-the-tester-checkered_flag)

---

## File descriptor

[Content](#content)

|int|name|constant(unistd.h)|flux|
|:---|:---|:---|:---|
|0|standard input|STDIN\_FILENO|stdin|
|1|standard output|STDOUT\_FILENO|stdout|
|2|standard error|STDERRi\_FILENO|stderr|
|x >= 3|other fd|||

## Check part :mag:

[Content](#content)

- Check protection after a malloc. Make sure return 0 will stop the program without crash and leaks.
- Check "BUFFER\_SIZE" when its value is equal/less than 0 or equal/more than INT\_MAX
- For bonus, protect the max number of file descriptor to avoid any crash of the program. You can change the limit of opened fd to test your program.
	```
	ulimit -a ==> check actual max limitation of fd.
	ulimit -n 5000 ==> change actual max liitation of fd.
	```

---

## How use the tester :checkered\_flag:

[Content](#content)

1. Clone repository `git clone https://github.com/BarrierAntho/42_Defender_Get_Next_Line` in your "gext\_next\_line" working directory.
2. Go to the directory "42\_Defender\_Get\_Next\_Line"
3. Run `make` to execute tester Makefile rule to create a test directory "gnl" in tester directory. It will also copy your working files into this new "gnl" directory and build an executable program "gnl.out"
4. Run `make norme` and `make check` to check "norminette" and "forbidden files/functions"
5. Manual check test
	1. Run `make test` or `make test b=xx` where **x represents BUFFERSIZE**. Then it will build an executable program "gnl.out" and execute it by using the file "gnl\_000.txt"
	2. You can also run the program as following `./gnl.out filename` 
6. Automatic check test
	1. Run `make run` that will compile and use the get\_next\_line workfiles and test it with files from "test/file".
	2. Check content of "test/result" directory. :bangbang: *_never delete test/result directory_*
		- The program will generate a file result according to one original file + a BUFFERSIZE.
		- The program will generate a "diff.log" file where comparison is written and described in it"
> You can edit the existing file or create as much as you want in the directory "test/file". The program will be able to use it during "run" process
