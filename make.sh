#/bin/bash
ln -s ~/VimConfig/.vimrc ~/.vimrc
rm -rf ~/.vim
mkdir -p ~/.vim/pack/sources
INPUT_FILE="plugins_list.txt"
while IFS=, read repo folder
do
    # trim spaces
    repo=$(echo "$repo" | xargs)
    folder=$(echo "$folder" | xargs)

    echo "Cloning $repo into $folder ..."
    git clone "https://github.com/$repo" "start/$folder"
done < "$INPUT_FILE"
mv start ~/.vim/pack/sources
