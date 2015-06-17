from snake import *
import time

abbrev("curtime", time.ctime)


@key_map("<leader>sa")
def select_all():
    keys("ggVG")


@key_map("<leader>yaa")
def yank_all_a():
    """ Yanks all text in buffer into register a. """
    yank_all("a")

@key_map("<leader>cvv")
def replace_current_word():
    """ Replaces the current word with register contents. """
    replace_word(get_register(0))


def yank_all(register):
    """ Yanks all text in buffer into the given register. """
    command("%y" + register)


@key_map("<leader>tsc")
def toggle_snake_case_camel_case():
    """ toggles a word between snake case (some_function) and camelcase
    (someFunction) """
    word = get_word()

    # it's snake case
    if "_" in word:
        chunks = word.split("_")
        camel_case = chunks[0] + "".join([chunk.capitalize() for chunk in
                                          chunks[1:]])
        replace_word(camel_case)

    # it's camel case
    else:
        # split our word on capital letters followed by non-capital letters
        chunks = filter(None, re.split("([A-Z][^A-Z]*)", word))
        snake_case = "_".join([chunk.lower() for chunk in chunks])
        replace_word(snake_case)


def uppercase_second_word():
    """ Example function from snake site."""
    keys("gg")  # go to top of file, first character
    keys("w")  # next word
    keys("viw")  # select inner word
    keys("~")  # uppercase it
