/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: antho <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/01/13 21:35:31 by antho             #+#    #+#             */
/*   Updated: 2022/02/03 14:48:01 by abarrier         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "get_next_line/get_next_line.h"
#include <unistd.h>
#include <fcntl.h>
#include <string.h>

#define SEP_S "###################"

/*
static int	bonus(char *filename)
{
	int	fd[10];
	char	*str[10];
	int	start;
	int	i;
	int	j;
	int	isEOFall;

	start = 3;
	i = start;
	while (i < 10)
	{
		fd[i] = open(filename, O_RDONLY);
		if (fd[i] < 0)
		{
			printf("open file[%d] failed\n", i);
			return (1);
		}
		i++;
	}
	i = start;
	j = start;
	isEOFall = 0;
	while (isEOFall == 0)
	{
		while (i < 10)
		{
			str[i] = get_next_line(fd[i]);
			if (!str[i])
				break;
			else
				printf("%s", str[i]);
			free(str[i]);
			i++;
		}
		j = start;
		isEOFall = 1;
		while (j < 10)
		{
			if (str[j])
			{
				isEOFall = 0;
				break;
			}
			j++;
		}
		i = start;
	}
	i = start;
	while (i < 10)
		close(fd[i]);
	return (0);
}
*/

static int	mandatory(char *filename)
{
	int	fd;
	char	*str1;

	fd = open(filename, O_RDONLY);
	if (fd < 0)
	{
		printf("open file failed\n");
		return (1);
	}

	while (1)
	{
		str1 = get_next_line(fd);
		if (!str1)
			break;
		else
			printf("%s", str1);
		free(str1);
	}
	close(fd);
	return (0);
}

int	main(int argc, char **argv)
{
	int	isBonus;
	char	*filename;

	if (argc == 1)
	{
		printf("no file argument\n");
		return (0);
	}
	isBonus = 0;
	filename = argv[1];
	if (!isBonus)
		mandatory(filename);
//	else
//		bonus(filename);

//	system("leaks a.out");
	return (0);
}
