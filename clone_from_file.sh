#/bin/bash
INPUT_FILE="plugins_list.txt"

while IFS=, read repo folder
do
    # trim spaces
    repo=$(echo "$repo" | xargs)
    folder=$(echo "$folder" | xargs)

    echo "Cloning $repo into $folder ..."
done < "$INPUT_FILE"
