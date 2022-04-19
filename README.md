# dotfiles

A cleaned up version of my dotfiles repo. Now organized to use 'stow' for
installation of the files on a new system. Adjusted primarily for FreeBSD
in this iteration.

## makefile

The Makefile is a simple way to install all of the contained dotfiles in this
repo.

```make
all:
    stow --verbose --target=$$HOME --restow */

delete:
    stow --verbose --target=$$HOME --delete */
```

