install: setup
	chmod +x ~/.vim/clone_from_file.sh
	~/.vim/clone_from_file.sh  ~/.vim/pack/sources
clone: 
	git clone https://github.com/BlaiseBaptist/VimConfig.git --depth 1 ~/.vim
setup: 
	mv ~/.vimrc ~/.vimrc.old
	ln -s ~/.vim/.vimrc ~/.vimrc
	mkdir -p ~/.vim/pack/sources
clean:
	rm -rf ~/.vim
	rm ~/.vimrc
	echo restoring old conf
	mv ~/.vimrc.old ~/.vimrc
