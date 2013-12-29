VimAw - Awesome Vim-bindings
============================
Control your Awesome desktop with Vim shortcuts!

Have you ever thought about controlling whole window manager with Vim-like shortcuts? Now it's possible.

For now VimAw is only a prototype.

Installation
------------
1. Clone the repository and replace your `~/.config/awesome/rc.lua` file with `rc.lua` from the repo.
2. Restart Awesome with `Mod + Control + r`


NORMAL MODE
-----------
### Simple commands:
```
j - go to win down
k - go to win up
h - go to win on the left
H - go to previous window
l - go to win on the right
L - go to next widnow (same as Tab)
f - change to fullscreen
i - switch to INSERT mode
m - maximize window
n - minimize window (TODO - restoring window)
t - run terminal
```


### Multi commands:
```
dd - close current window
cl - change to next layout
Cl - change to previous layout
ct - change to next tag
Ct - change to previous tag
cs - change to next screen
Cs - change to previous screen
Mod4 + Esc or Control + Mod1 + ] - switch to NORMAL mode
```


TESTING
-------
* [Debugging rc.lua on ArchWiki](https://wiki.archlinux.org/index.php/awesome#Debugging_rc.lua)

```
Xephyr :1 -ac -br -noreset -screen 1152x720 & DISPLAY=:1.0 awesome -c ~/.config/awesome/rc.lua.test

$ awmtt start --config=~/.config/awesome/rc.lua.new
$ awmtt stop
$ awmtt restart
```


WANT CONTRIBUTE?
----------------
VimAw is only something like protoype and there is a lot of work. Some of the TODOs you can find at the end of this document or directly in rc.lua file. 

What is the most important thing at the moment is to create list of shortcuts and their actions. Test them and optimize the list. After it will be necessary some code beautification and clarification.

Favoured method of contribution is via pull requests. E-mail patches are accepted too (seberm[at]seberm[dot]com).


Author
------
* Otto Sabart - Seberm
* www.seberm.com
* seberm[at]seberm[dot]com


LINKS
-----
* [Awesome API](http://awesome.naquadah.org/doc/api/index.html)
* [Lua reference manual](http://www.lua.org/manual/5.1/manual.html)
* [Awesome on ArchWiki] (https://wiki.archlinux.org/index.php/awesome)



TODOS
-----
```
- Support VISUAL mode
- Which shortcut is the best for returning from insert mode? (MOD4 + ESC | CTRL + MOD1 + [)
- 'u' - open last closed window/application
- Control + w - manage current window
        - control + w - switch between two windows
        - j or k or l or h - change to window in given direction
```
