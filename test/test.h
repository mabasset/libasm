#ifndef TEST_H

# define TEST_H

# include <stdio.h>

void    test_write(char *buf);
void    test_strlen(char *buf);
void    test_strdup(char *src);
void    test_strcpy(char *src);
void    test_strcmp(char *s1, char *s2);
void    test_read(char *str);

void    test_atoi(char *str, char *base);
void    test_list_functions();

#endif