function create_cd_aliases
    set target_dir $argv[1]

    # Check if the directory exists
    if not test -d $target_dir
        echo "Directory $target_dir does not exist"
        return 1
    end

    # Loop through subdirectories and create aliases
    for dir in $target_dir/*
        if test -d $dir
            # Extract folder name
            set folder_name (basename $dir)

            # Create an alias
            alias "cd$folder_name" "cd $dir"
        end
    end
end
