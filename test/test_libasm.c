/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_libasm.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mabasset <mabasset@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/16 11:40:16 by mabasset          #+#    #+#             */
/*   Updated: 2025/02/16 12:19:38 by mabasset         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

# include "../libasm.h"

# include <stdio.h>
# include <errno.h>
# include <unistd.h>
# include <stdlib.h>
# include <string.h>

void    test_read(char *str) {
    int     fds[2];
    char*   buf;
    size_t  size = 0;
    ssize_t ret;

    if (str)
        size = strlen(str);
    buf = (char *) malloc(size + 1);
    buf[size] = '\0';
    pipe(fds);
    printf("---FT_READ---\n");

    write(fds[1], str, size);
    ret = ft_read(fds[0], buf, size);
    printf("%s", buf);
    printf("[%ld, %d]\n", ret, errno);
    errno = 0;

    write(fds[1], str, size);
    ret = read(fds[0], buf, size);
    printf("%s", buf);
    printf("[%ld, %d]\n", ret, errno);
    errno = 0;

    close(fds[0]);
    close(fds[1]);
    free(buf);
}

void    test_strcmp(char *s1, char *s2) {
    int ret;

    printf("---FT_STRCMP---\n");

    ret = ft_strcmp(s1, s2);
    printf("[%d, %d]\n", ret, errno);
    errno = 0;

    if (s1 && s2) {
        ret = strcmp(s1, s2);
        printf("[%d, %d]\n", ret, errno);
        errno = 0;
    } else
        printf("segmentation fault\n");
}

void    test_strcpy(char *src) {
    char    *dest;
    char    *ret = NULL;
    size_t  size = 0;

    if (src)
        size = strlen(src);
    dest = (char *) malloc(size + 1);
    printf("---FT_STRCPY---\n");

    ret = ft_strcpy(dest, src);
    printf("dest: %s\n", dest);
    printf("[%s, %d]\n", ret, errno);
    errno = 0;

    if (src) {
        ret = strcpy(dest, src);
        printf("dest: %s\n", dest);
        printf("[%s, %d]\n", ret, errno);
        errno = 0;
    } else
        printf("segmentation fault\n");
    free(dest);
}

void    test_strdup(char *src) {
    char    *ret = NULL;

    printf("---FT_STRDUP---\n");

    ret = ft_strdup(src);
    printf("[%s, %d]\n", ret, errno);
    free(ret);
    errno = 0;

    if (src) {
        ret = strdup(src);
        printf("[%s, %d]\n", ret, errno);
        free(ret);
        errno = 0;
    } else
        printf("segmentation fault\n");
}

void    test_strlen(char *buf) {
    size_t  ret;

    printf("---FT_STRLEN---\n");

    ret = ft_strlen(buf);
    printf("[%ld, %d]\n", ret, errno);
    errno = 0;

    if (buf) {
        ret = strlen(buf);
        printf("[%ld, %d]\n", ret, errno);
        errno = 0;
    } else
        printf("segmentation fault\n");
}

void    test_write(char *buf) {
    int     fd = 1;
    size_t  len = 0;
    ssize_t ret;

    if (buf)
        len = strlen(buf);
    printf("---FT_WRITE---\n");

    ret = ft_write(fd, buf, len);
    printf("[%ld, %d]\n", ret, errno);
    errno = 0;

    ret = write(fd, buf, len);
    printf("[%ld, %d]\n", ret, errno);
    errno = 0;
}