install_plugins: setup_plugins
	chmod +x ~/.vim/clone_from_file.sh
	~/.vim/clone_from_file.sh
clone: clean
	git clone https://github.com/BlaiseBaptist/VimConfig.git --depth 1 ~/.vim
	mv ~/.vimrc ~/.vimrc.old
	ln -s ~/.vim/.vimrc ~/.vimrc
setup_plugins: clone
	mkdir -p ~/vim/pack/sources
clean:
	rm -rf ~/.vim
