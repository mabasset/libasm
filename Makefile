NAME =	libasm.a
BONUS =	libasm_bonus.a

DIR =	src/
SRC =	ft_strlen.s \
		ft_write.s \
		ft_read.s \
		ft_strcpy.s \
		ft_strcmp.s \
		ft_strdup.s
OBJ =	$(addprefix $(O_DIR),$(SRC:.s=.o))

O_DIR =	obj/
B_SRC =	ft_atoi_base.s \
		ft_list_push_front.s \
		ft_list_size.s \
		ft_list_sort.s \
		ft_list_remove_if.s
B_OBJ =	$(addprefix $(O_DIR),$(B_SRC:.s=.o))

T_DIR =	test/
T_SRC =	$(addprefix $(T_DIR), main.c \
		test_libasm.c \
		test_libasm_bonus.c)
T_HDR = $(T_DIR)test.h
TEST =	$(T_DIR)test
FLG =	-Wall -Wextra -Werror

#$@ = target
#$^ = list of prerequisite
#$< = first prerequisite
$(NAME): $(OBJ)
	ar rcs $@ $^

bonus: $(BONUS)

$(BONUS): $(B_OBJ)
	ar rcs $@ $^

$(O_DIR)%.o: $(DIR)%.s
	@mkdir -p $(dir $@)
	nasm -f elf64 -o $@ $<

all: $(NAME) $(BONUS)

test: $(TEST)
	./$< $(S1) $(S2)

$(TEST): libasm.h libasm_bonus.h $(T_HDR) $(T_SRC) $(NAME) $(BONUS)
	gcc $(FLG) -o $@ $(T_SRC) $(NAME) $(BONUS)

clean:
	rm -rf $(O_DIR)

fclean: clean
	rm -f $(NAME) $(BONUS) $(TEST)

re: fclean all

.PHONY: bonus test all clean fclean re