A minimal emacs configuration for Python
========================================

To get everything working correctly,

1. Install emacs, git, and Python.
1. `pip install jedi epc pylint`
1. `git clone` this repository
1. Start emacs with `emacs -Q` (to *not* load your emacs' local initializations)
1. In emacs,
    1. Visit the file `init.el`
    1. In that file, run `M-x eval-buffer`

If everything works as expected (as during this [EuroPython 2013 presentation](https://www.youtube.com/watch?v=0cZ7szFuz18) of an earlier version of this repo's code), you'll get

- all the needed packages installed (via the [default emacs package management](http://www.emacswiki.org/emacs/ELPA) functionality)
- a productive configuration for Python and git
