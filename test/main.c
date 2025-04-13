/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mabasset <mabasset@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/05 22:34:05 by mabasset          #+#    #+#             */
/*   Updated: 2025/04/12 11:48:47 by mabasset         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test.h"

int main(int argc, char *argv[]) {
    char    *s1 = NULL;
    char    *s2 = NULL;

    printf("[return, errno]\n");
    if (argc > 1)
        s1 = argv[1];
    if (argc > 2)
        s2 = argv[2];
    printf("S1=%s\nS2=%s\n", s1, s2);

    test_read(s1);
    test_strcmp(s1, s2);
    test_strcpy(s1);
    test_strdup(s1);
    test_strlen(s1);
    test_write(s1);

    test_atoi(s1, s2);
    test_list_functions();
    return 0;
}