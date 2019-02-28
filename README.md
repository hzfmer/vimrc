# Personal VIM configuration

```
VIM_DIR=$PWD
cd
if [ -f ~/.vim/.vimrc ]; then
  rm ~/.vim/.vimrc
fi
ln -s $VIM_DIR/vimrc ~/.vim/.vimrc
```

