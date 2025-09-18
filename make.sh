#/bin/bash
mv ~/.vimrc ~/.vimrc.old
ln -s ~/VimConfig/.vimrc ~/.vimrc
mkdir -p ~/VimConfig/pack/sources
INPUT_FILE="plugins_list.txt"

while IFS=, read repo folder
do
    # trim spaces
    repo=$(echo "$repo" | xargs)
    folder=$(echo "$folder" | xargs)

    echo "Cloning $repo into $folder ..."
    git clone "https://github.com/$repo" "~/VimConfig/pack/sources/$folder"
done < "$INPUT_FILE"
