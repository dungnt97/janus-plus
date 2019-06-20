" Customization
"
" This loads after the janus plugins so that janus-specific plugin mappings can
" be overwritten.

source ~/.vim/janus/vim/vimrc.after_plugin
if filereadable(expand("~/.vimrc.after"))
  source ~/.vimrc.after
endif
