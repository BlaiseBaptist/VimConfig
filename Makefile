install:
	-mv ~/.vimrc ~/.vimrc.old
	chmod +x make.sh
	./make.sh
clean: 
	rm -rf pack
uninstall:
	rm -rf ~/VimConfig
	rm ~/.vimrc
	-mv ~/.vimrc.old ~/.vimrc
