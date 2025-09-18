install_plugins: setup_plugins
	echo done
clone: clean
	git clone https://github.com/BlaiseBaptist/VimConfig.git --depth 1 temp
	cd temp
	break
setup_plugins: clone
	mkdir -p pack/sources
clean:
	rm -rf temp
