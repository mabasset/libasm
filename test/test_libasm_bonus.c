/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_libasm_bonus.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mabasset <mabasset@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/16 12:17:49 by mabasset          #+#    #+#             */
/*   Updated: 2025/05/02 17:43:38 by mabasset         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

# include "../libasm_bonus.h"

# include <stdio.h>
# include <errno.h>
# include <unistd.h>
# include <stdlib.h>
# include <string.h>

void    test_atoi(char *str, char *base) {
    int ret;

    printf("---FT_ATOI_BASE---\n");

    ret = ft_atoi_base(str, base);
    printf("[%d, %d]\n", ret, errno);
    errno = 0;
}

int     ft_intcmp(int *n1, int *n2) {
    return *n1 - *n2;
}

void    ft_print_list(t_list* head) {
    for (int i = 0; head != NULL; i++, head = head->next)
        printf("[%d]: %d\n", i, *((int*)head->data));
}

void    ft_free_list(t_list* head) {
    t_list* tmp;
    while (head != NULL) {
        tmp = head->next;
        free(head->data);
        free(head);
        head = tmp;
    }
}

void    test_list_functions() {
    int     ret;
    t_list* head = NULL;
    
    size_t  i;
    size_t  size = 10;
    int *ar[size];

    for (i = 0; i < size; i++) {
        ar[i] = malloc(sizeof(int*));
        *ar[i] = rand() % 100;
    }

    *ar[2] = 0;

    printf("---FT_LIST_PUSH_FRONT---\n");

    for (i = 0; i < size; i++)
        ft_list_push_front(&head, ar[i]);
    printf("errno: %d\n", errno);
    ft_print_list(head);
    errno = 0;

    printf("---FT_LIST_SIZE---\n");

    ret = ft_list_size(head);
    printf("[%d, %d]\n", ret, errno);

    printf("---FT_LIST_REMOVE_IF---\n");

    int x = *((int*)head->next->data);
    ft_list_remove_if(&head, &x, ft_intcmp, free);
    printf("errno: %d\n", errno);
    printf("removed: %d\n", x);
    ft_print_list(head);
    errno = 0;

    printf("---FT_LIST_SORT---\n");
    
    ft_list_sort(&head, ft_intcmp);
    printf("errno: %d\n", errno);
    ft_print_list(head);
    errno = 0;

    ft_free_list(head);
}
