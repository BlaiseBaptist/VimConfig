#/bin/bash
mv ~/.vimrc ~/.vimrc.old
ln -s ~/.vim/.vimrc ~/.vimrc
mkdir -p ~/.vim/pack/sources
INPUT_FILE="plugins_list.txt"

while IFS=, read repo folder
do
    # trim spaces
    repo=$(echo "$repo" | xargs)
    folder=$(echo "$folder" | xargs)

    echo "Cloning $repo into $folder ..."
    git clone "https://github.com/$repo" "$1/$folder"
done < "$INPUT_FILE"
