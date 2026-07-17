function guix-fix-hash --description "Fix hash mismatch in Guix package definition"
    set -l scm_file
    if test (count $argv) -ge 1
        set scm_file $argv[1]
    else
        set scm_file (ls *.scm 2>/dev/null | head -1)
    end

    if not test -f "$scm_file"
        echo "Usage: guix-fix-hash [package.scm]"
        return 1
    end

    set -l output (guix build -L. (basename $scm_file .scm) 2>&1)
    set -l rc $status

    if test $rc -eq 0
        echo "Build succeeded, no hash fix needed"
        return 0
    end

    # Extract the expected hash (the fake/temp one to replace)
    set -l expected_hash (echo $output | grep -oP 'expected hash:\s+\K\S+')
    set -l actual_hash (echo $output | grep -oP 'actual hash:\s+\K\S+')

    if test -z "$expected_hash" -o -z "$actual_hash"
        echo "No hash mismatch found in output"
        echo $output
        return 1
    end

    echo "Expected (fake): $expected_hash"
    echo "Actual (correct): $actual_hash"

    # Replace the specific expected hash in the file
    if grep -q "$expected_hash" $scm_file
        sed -i "s|$expected_hash|$actual_hash|g" $scm_file
        echo "Replaced expected hash with actual hash in $scm_file"
    else
        echo "Expected hash not found in $scm_file"
        echo "You may need to manually update: $actual_hash"
    end
end
