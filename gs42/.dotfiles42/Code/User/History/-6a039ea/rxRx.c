/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   fdf.c                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: minjkang <miniminjae92@gmail.com>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/08/21 19:49:18 by minjkang          #+#    #+#             */
/*   Updated: 2025/08/22 14:06:53 by minjkang         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "fdf.h"

void	clear_image(t_img *img)
{
	ft_bzero(img->data, WIN_W * WIN_H * (img->bpp / 8));
}

void	put_pixel_img(t_img *img, int x, int y, int color)
{
	char	*dst;

	if (x < 0 || x >= WIN_W || y < 0 || y >= WIN_H)
		return ;
	dst = img->data + (y * img->line_size + x * (img->bpp / 8));
	*(unsigned int *)dst = color;
}

void	draw_line(t_point a, t_point b, t_img *img)
{
	int	dx;
	int	dy;
	int	sx;
	int	sy;
	int	err;
	int	e2;

	dx = abs(b.x - a.x);
	dy = abs(b.y - a.y);
	sx = (a.x < b.x) ? 1 : -1;
	sy = (a.y < b.y) ? 1 : -1;
	err = dx - dy;
	/* printf("dx: %d dy: %d sx: %d sy %d err %d\n", dx, dy, sx, sy, err); */
	while (1)
	{
		/* printf("여기는 나올겨ax %d bx %d ay %d by %d\n", a.x, b.x, a.y, b.y); */
		put_pixel_img(img, a.x, a.y, a.color);
		if (a.x == b.x && a.y == b.y)
			break ;
		e2 = 2 * err;
		if (e2 > -dy)
		{
			err -= dy;
			a.x += sx;
		}
		if (e2 < dx)
		{
			err += dx;
			a.y += sy;
		}
	}
}

void	draw_map(t_mlx *mlx)
{
	t_point	p1;
	t_point	p2;
	int		col;
	int		row;

	row = 0;
	while (row < mlx->map->cols)
	{
		col = 0;
		while (col < mlx->map->rows)
		{
			// 현재 점 (x, y)의 화면 좌표 계산
			p1.x = mlx->map->points_m[row][col].x;
			p1.y = mlx->map->points_m[row][col].y;
			p1.color = mlx->map->points_m[row][col].color;
			/* p1.x = mlx->map->points_m[row][col].x * mlx->cam.zoom + mlx->cam.offset_x; */
			/* p1.y = mlx->map->points_m[row][col].y * mlx->cam.zoom + mlx->cam.offset_y ; */
			// 오른쪽 점과 선으로 연결
			if (col < mlx->map->rows - 1)
			{
				p2.x = mlx->map->points_m[row][col + 1].x;
				p2.y = mlx->map->points_m[row][col + 1].y;
				p2.color = mlx->map->points_m[row][col + 1].color;
				/* p2.x = mlx->map->points_m[row][col + 1].x * mlx->cam.zoom; */
				/* p2.y = mlx->map->points_m[row][col + 1].y * mlx->cam.zoom; */
				/* p2.x += mlx->cam.offset_x; */
				/* p2.y += mlx->cam.offset_y; */
				draw_line(p1, p2, mlx->img_front);
			}
			// 아래쪽 점과 선으로 연결
			if (row < mlx->map->cols - 1)
			{
				p2.x = mlx->map->points_m[row + 1][col].x;
				p2.y = mlx->map->points_m[row + 1][col].y;
				p2.color = mlx->map->points_m[row + 1][col].color;
				/* p2.x = mlx->map->points_m[row + 1][col].x * mlx->cam.zoom; */
				/* p2.y = mlx->map->points_m[row + 1][col].y * mlx->cam.zoom; */
				/* p2.x += mlx->cam.offset_x; */
				/* p2.y += mlx->cam.offset_y; */
				draw_line(p1, p2, mlx->img_front);
			}
			col++;
		}
		row++;
	}
}

int	handle_key(int keycode, t_mlx *mlx)
{
	if (keycode == KEY_ESC)
	{
		mlx_destroy_window(mlx->mlx, mlx->win);
		exit(0);
	}
	return (0);
}

/* void init_fdf(t_fdf *fdf) */
/* { */
/*     fdf->cam.zoom = 20; */
/*     fdf->cam.offset_x = WIN_WIDTH / 3; */
/*     fdf->cam.offset_y = WIN_HEIGHT / 3; */
/*      */
/* 	fdf->mlx = mlx_init(); */
/* 	fdf->win = mlx_new_window(fdf->mlx, WIN_WIDTH, WIN_HEIGHT, "FdF"); */
/* 	fdf->img.img = mlx_new_image(fdf->mlx, WIN_WIDTH, WIN_HEIGHT); */
/* 	fdf->img.addr = mlx_get_data_addr(fdf->img.img, &fdf->img.bpp, */
/* 			&fdf->img.line_len, &fdf->img.endian); */
/* } */

/* static double deg_to_rad(double degree) */
/* { */
/* 	return (degree * (M_PI / 180.0)); */
/* } */

t_matrix compose_initial_matrix(t_map *map)
{
    t_matrix to_origin = matrix_translate(-map->rows/2.0, -map->cols/2.0, 0);
    t_matrix scale     = matrix_scale(20, 20, 20);
    t_matrix rot_x     = matrix_rotate_x(-M_PI/6);
    t_matrix rot_y     = matrix_rotate_y(M_PI/6);
    t_matrix iso       = matrix_iso();
    // 초기 transform: Scale + Rotate + Iso
    return (matrix_multiply(iso, matrix_multiply(rot_y, matrix_multiply(rot_x, matrix_multiply(scale, to_origin)))));
}

int	main_loop(t_mlx *mlx)
{
	clear_image(mlx->img_front);
	draw_map(mlx);
	mlx_put_image_to_window(mlx->mlx, mlx->win, mlx->img_front->img_ptr,
		0, 0);
	return (0);
}

int	main(int ac, char **av)
{
	t_vars	vars;

	if (ac != 2)
		print_error("Usage: ./fdf map.fdf\n");
	vars.mlx = mlx_init();
	vars.win = mlx_new_window(vars.mlx, WIN_W, WIN_H, "FDF");
	vars.map = init_map(av[1]);
	printf("rows: %d, cols: %d\n", vars.map->rows, vars.map->cols);
	init_camera();
	init_mtx = compose_initial_matrix(vars.map);
	apply_initial_transform(vars.map, init_mtx);
	/* // 초기 Screen Space offset (화면 중앙) */
	/* mlx.cam.offset_x = WIN_W / 2.0; */
	/* mlx.cam.offset_y = WIN_H / 2.0; */
	/* mlx.cam.zoom = 1.0; */
	vars.img_front = malloc(sizeof(t_img));
	vars.img_front->img_ptr = mlx_new_image(vars.mlx, WIN_W, WIN_H);
	vars.img_front->data = mlx_get_data_addr(vars.img_front->img_ptr,
			&vars.img_front->bpp, &vars.img_front->line_size,
			&vars.img_front->endian);
	printf("data1: %p\n", vars.img_front->data);
	mlx_key_hook(vars.win, handle_key, &vars);
	/* mlx_mouse_hook(mlx.win, handle_mouse, &mlx); */
	printf("before %p \n", vars.map);
	mlx_loop_hook(vars.mlx, main_loop, &vars);
	mlx_loop(vars.mlx);
	free_map(vars.map);
	return (0);
}
