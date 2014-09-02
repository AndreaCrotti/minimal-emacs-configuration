minimal-emacs-configuration
===========================

A minimal emacs configuration for Python.

To get everything working correctly,

1. `pip install jedi epc pylint`
1. clone this repository
1. start emacs with `emacs -Q` (to *not* load your local initializations)
1. visit the file `init.el`
1. `M-x eval-buffer`

If everything works as expected (as during this [EuroPython 2013 presentation](https://www.youtube.com/watch?v=0cZ7szFuz18) of an earlier version of this repo's code), you'll get

- all the needed packages installed (via the [default emacs package management](http://www.emacswiki.org/emacs/ELPA) functionality)
- a productive configuration for Python and git
