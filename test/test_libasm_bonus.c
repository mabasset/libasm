/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_libasm_bonus.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mabasset <mabasset@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/16 12:17:49 by mabasset          #+#    #+#             */
/*   Updated: 2025/04/13 22:50:05 by mabasset         ###   ########.fr       */
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
    return *n1 != *n2;
}

void    ft_freeint(int *ptr) {
    free(ptr);
}

void    test_list_functions() {
    int     ret;
    t_list* head = NULL;
    t_list* current;
    
    size_t  i;
    size_t size = 4;
    int *ar[size];

    for (i = 0; i < size; i++) {
        ar[i] = malloc(sizeof(int));
        *ar[i] = i;
    }

    printf("---FT_LIST_PUSH_FRONT---\n");

    for (i = 0; i < size; i++)
        ft_list_push_front(&head, ar[i]);
    for (i = 0, current = head; current != NULL; i++, current = current->next)
        printf("[%ld]: %d\n", i, *((int*)current->data));
    printf("errno: %d\n", errno);
    errno = 0;

    printf("---FT_LIST_SIZE---\n");

    ret = ft_list_size(head);
    printf("[%d, %d]\n", ret, errno);

    printf("---FT_LIST_REMOVE_IF---\n");

    ft_list_remove_if(&head, ar[2], ft_intcmp, free);
    printf("errno: %d\n", errno);
    errno = 0;
}

void ft_list_remove_if(t_list** head, int nbr) {
    t_list* prev = *head;
    t_list* curr = prev->next;
    while (curr != NULL) {
        if (curr->data == nbr)
            prev->next = curr->next;
        else
            prev = curr;
        curr = prev->next;
    }
    curr = *head;
    if (curr->data == nbr)
        *head = curr->next;
}