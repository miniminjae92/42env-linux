/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   parser.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: minjkang <miniminjae92@gmail.com>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/08/22 13:08:48 by minjkang          #+#    #+#             */
/*   Updated: 2025/08/22 13:08:56 by minjkang         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "fdf.h"

static void	free_gsl_exit(char **splited, char *line, char *msg)
{
	get_next_line(-1);
	free_split(splited);
	free(line);
	if (msg)
		print_error(msg);
}

static void	get_map_size(char *filename, t_map *map)
{
	int		col;
	int		fd;
	char	*line;
	char	**splited;

	fd = open(filename, O_RDONLY);
	if (fd < 0)
		msg_strerror("file open error");
	map->rows = 0;
	while ((line = get_next_line(fd)))
	{
		splited = ft_split(line, ' ');
		if (!splited)
			free_gsl_exit(NULL, line, "splited fail");
		col = 0;
		while (splited[col])
			col++;
		if (map->rows == 0)
			map->cols = col;
		else if (col != map->cols)
			free_gsl_exit(splited, line, "map is not rectangular");
		map->rows++;
		free_split(splited);
		free(line);
	}
	get_next_line(-1);
	close(fd);
}

static int	check_color(char *z_value)
{
	int		res;
	char	*tmp;

	res = (int)0xFFFFFF;
	tmp = ft_strchr(z_value, ',');
	if (tmp == NULL)
		return (res);
	tmp++;
	res = (int)strtol(tmp, NULL, 16);
	return (res);
}

static void	fill_map(char *filename, t_map *map)
{
	char	**splited;
	char	*line;
	int		fd;
	int		col;
	int		row;

	fd = open(filename, O_RDONLY);
	if (fd < 0)
		print_error("file open error");
	row = 0;
	while ((line = get_next_line(fd)))
	{
		splited = ft_split(line, ' ');
		if (!splited)
			free_gsl_exit(NULL, line, "splited fail");
		col = 0;
		while (splited[col])
		{
			map->original[row][col].x = col;
			map->original[row][col].y = row;
			map->original[row][col].z = ft_atoi(splited[col]);
			if (map->z_min > map->original[row][col].z)
				map->z_min = map->original[row][col].z;
			if (map->z_max < map->original[row][col].z)
				map->z_max = map->original[row][col].z;
			map->original[row][col].color = check_color(splited[col]);
			col++;
		}
		row++;
		free_split(splited);
		free(line);
	}
	get_next_line(-1);
	close(fd);
}

t_map	*parse_map(char *filename)
{
	int		y;
	t_map	*map;

	map = malloc(sizeof(t_map));
	if (!map)
		print_error("map struct malloc failed");
	map->z_min = 2147483647;
	map->z_max = -2147483648;
	get_map_size(filename, map);
	map->original = malloc(sizeof(t_point3 *) * map->rows);
	if (!map->original)
	{
		free_map(map);
		print_error("malloc failed");
	}
	y = 0;
	while (y < map->rows)
	{
		map->original[y] = malloc(sizeof(t_point3) * map->cols);
		if (!map->original[y])
		{
			free_map(map);
			print_error("malloc failed");
		}
		y++;
	}
	fill_map(filename, map);
	return (map);
}
