# 1 PassEl (Work in Progress)

1passel is a simple integration for 1password into emacs. I find this useful to be used with EXWM. Depends on a completion package to generate a searchable list of accounts from which to retrieve the accounts. 


## Installation

The main prerequisite for this package is the `op` command-line utility provided by [1password](https://1password.com/downloads/command-line/). One this is installed, you can download the 1passel.el file and load it from your init file.


A part from the usual installation you can install this using [straight](https://github.com/raxod502/straight.el) and [use-package](https://github.com/jwiegley/use-package).

```elisp
(use-package 1passel
	     :straight '(1passel :host github
	     	       :repo "vinid/1passel"
		       :branch "master"))
```

## Commands

1passel exposes two interactive commands

### M-x 1passel-login

Logs to 1password and saves the session token for later use. If you use 2FA the first time you will need to run:

```bash
	op signin
```

On your command line.

### M-x 1passel-get-password

Allows for password search. It simply runs the command to get the accounts and allows for the extraction of a particular password that is then copied to clip-board.


## Useful Links

+ [1password.el](https://github.com/xuchunyang/1password.el) it is a nicely done project to integrate 1password into emacs.
+ [1pass](https://github.com/dcreemer/1pass) provides a very well designed wrapper on top of the 1password command-line tool. It also provides some emacs features.