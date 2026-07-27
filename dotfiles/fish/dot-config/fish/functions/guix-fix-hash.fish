function guix-fix-hash --description "Fix hash mismatch in Guix package definitions"
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

    set -l pkg_names (grep -oP '\(name\s+"?\K[^")\s]+' $scm_file)
    if test (count $pkg_names) -eq 0
        echo "Could not determine package name from $scm_file"
        return 1
    end

    set -l fixed 0
    for pkg_name in $pkg_names
        echo "=== Building: $pkg_name ==="
        set -l output (guix build -L. $pkg_name 2>&1)
        set -l rc $status

        if test $rc -eq 0
            echo "$pkg_name: build succeeded, no hash fix needed"
            continue
        end

        set -l expected_hash (echo $output | grep -oP 'expected hash:\s+\K\S+')
        set -l actual_hash (echo $output | grep -oP 'actual hash:\s+\K\S+')

        if test -z "$expected_hash" -o -z "$actual_hash"
            echo "$pkg_name: no hash mismatch found in output"
            echo $output
            continue
        end

        echo "$pkg_name expected (fake): $expected_hash"
        echo "$pkg_name actual (correct): $actual_hash"

        if grep -q "$expected_hash" $scm_file
            sed -i "s|$expected_hash|$actual_hash|g" $scm_file
            echo "$pkg_name: replaced expected hash with actual hash"
            set fixed (math $fixed + 1)
        else
            echo "$pkg_name: expected hash not found in $scm_file"
            echo "You may need to manually update: $actual_hash"
        end
    end

    echo "=== Done: $fixed hash(es) fixed ==="
end
