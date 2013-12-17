VimAw - Awesome Vim-bindings
============================
Control your Awesome desktop with Vim shortcuts!

Have you ever thought about controlling whole window manager with Vim-like shortcuts? Now it's possible.

For now VimAw is only a prototype.

Installation
------------
1. Clone the repository and replace your `~/.config/awesome/rc.lua` file with `rc.lua` from the repo.
2. Restart awesome (Mod + Control + r)


NORMAL MODE
-----------
### Simple commands:
    j - go to win down
    k - go to win up
    h - go to win on the left
    H - go to previous window
    l - go to win on the right
    L - go to next widnow (same as Tab for now)
    f - change to fullscreen
    i - switch to INSERT mode
    m - maximize window
    n - minimize window (TODO - restoring window)
    t - run terminal


### Multi commands:
    dd - close current window
    cl - change to next layout
    Cl - change to previous layout
    ct - change to next tag
    Ct - change to previous tag
    cs - change to next screen
    Cs - change to previous screen


Author
------
* Otto Sabart - Seberm
* www.seberm.com
* seberm[at]gmail[dot]com


LINKS
-----
* [Awesome API](http://awesome.naquadah.org/doc/api/index.html)
* [Lua reference manual](http://www.lua.org/manual/5.1/manual.html)
* [Awesome on ArchWiki] (https://wiki.archlinux.org/index.php/awesome)


TODOS
-----
* Support VISUAL mode
* Which shortcut is the best for returning from insert mode? (MOD1 + ESC | CTRL + MOD1 + [)

* 'u' - open last closed window/application

* control + w - manage current window
            - control + w - switch between two windows
            - j or k or l or h - change to window in given direction
