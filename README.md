# vim-gdb-break

Adds the current buffer line to a file which can be parsed by gdb to set breakpoints.  Fits well with my workflow. Your
mileage may vary...

## Installation


## Config

To specify the buffer for break points:

```vim
g:break_file = '.gdb-breaks'
```

To specify the mark shown.  Characters are limited to what your environment supports and Vim's restrictions on the
gutter.

```vim
g:vgb_mark = ❎
```

## Bindings

```vim
nmap ba <Plug>(vgb-add-brreak)
nmap br <Plug>(vgb-rem-break)
```

## TODO

* Add toggle function/map
* Add wrap setting to navigate
* Don't require break file to be open in buffer
* Parse the file on start up to place marks
* Add configuration for file types: c, cpp, python...
* Add reverse recursive search for g:break_file
* Update the break file when positions change.
