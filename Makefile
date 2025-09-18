install_plugins: setup_plugins
	echo done
clone: clean
	git clone https://github.com/BlaiseBaptist/VimConfig.git --depth 1 ~/vim
setup_plugins: clone
	mkdir -p ~/vim/pack/sources
clean:
	rm -rf ~/vim
