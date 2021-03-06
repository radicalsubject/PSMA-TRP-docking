import curses
from curses import wrapper
from curses.textpad import Textbox, rectangle
stdscr = curses.initscr()
curses.noecho()
curses.cbreak()
stdscr.keypad(True)


def main(stdscr):
    stdscr.addstr(0, 0, "Enter IM message: (hit Ctrl-G to send)")

    editwin = curses.newwin(5,30, 2,1)
    rectangle(stdscr, 1,0, 1+1+1, 1+40+1)
    stdscr.refresh()

    box = Textbox(editwin)

    # Let the user edit until Ctrl-G is struck.
    box.edit()

    # Get resulting contents
    message = box.gather()
    print(message)
    return message

if __name__ == "__main__":
    wrapper(main)
    