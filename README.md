# 1PassEl | 1Password integration in Emacs (Work in Progress)

1passel is a very simple tool to integrate 1password into emacs. I find this useful to be used within the EXWM desktop environment. With this I can get my password anywhere with a few keystrokes.

## Installation

The main prerequisite for this package is the `op` command-line utility provided by [1password](https://1password.com/downloads/command-line/). One this is installed, you can download the 1passel.el file and load it from your init file.

You also need to have gpg-agent running as the tool is going to use your master password stored in an encrypted gpg file (see this [line](https://github.com/vinid/1passel/blob/master/1passel.el) of code).


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