/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   fdf.h                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: minjkang <miniminjae92@gmail.com>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/08/21 19:49:26 by minjkang          #+#    #+#             */
/*   Updated: 2025/08/22 13:09:55 by minjkang         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef FDF_H
# define FDF_H

# define WIN_W 800
# define WIN_H 600
# define KEY_ESC 65307

# include "./minilibx-linux/mlx.h"
# include "get_next_line.h"
# include "libft.h"
# include <errno.h>
# include <fcntl.h>
# include <math.h>
# include <stdio.h>
# include <stdlib.h>
# include <string.h>
# include <unistd.h>

typedef struct s_point3
{
	float	x;
	float	y;
	float	z;
	int		color;
}			t_point3;

typedef struct s_point2
{
	int	x;
	int	y;
	int		color;
}			t_point2;


typedef struct s_map
{
	int		cols;
	int		rows;
	t_point3	**original;
	t_point2	**projected;
	float z_min;
	float z_max;
}			t_map;

typedef struct s_cam 
{
    int zoom;
    int offset_x;
    int offset_y;
    double angle_x;
    double angle_y;
    double angle_z;
} t_cam;

typedef struct s_img
{
	void	*img_ptr;
	char	*addr;
	int		bpp;
	int		line_size;
	int		endian;
}			t_img;

typedef struct s_vars
{
	void	*mlx;
	void	*win;
	t_img imgs[2];
	t_map	*map;
	t_cam	cam;
	int current_img;
}			t_vars;

typedef struct s_matrix
{
	float	m[4][4];
}			t_matrix;

void		draw_line(t_point a, t_point b, t_img *img);
int			handle_key(int keycode, t_mlx *mlx);
int			main_loop(t_mlx *mlx);
// parser.c
t_map		*init_map(char *filename);
// error.c
void		putstr_fd(const char *s, int fd);
void		print_error(const char *msg);
void		msg_strerror(const char *msg);
// utils.c
void		free_split(char **split);
void		free_map(t_map *map);
void		print_map(t_map *map);
#endif
