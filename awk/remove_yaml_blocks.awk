# Removes blocks from yaml files that begin with "indexes:".
# Relies on consistent indentation to identify the start of the next block.

BEGIN {
    indexes = 0 # when this is 1, then we are in the `indexes` block
    indent = 0
}

indexes==1 && /:/ && match($0, "[^ \t]")==indent {indexes = 0}
indexes==0 && /indexes:/ {indexes = 1; indent = match($0, "[^ \t]")}

indexes==0 {print $0}

# Usage:
# for f in $(git grep indexes jobs/vertica/ | cut -d : -f 1); do
#   awk -f remove_yaml_blocks.awk $f > tmp && mv tmp $f
# done

# Modeled on http://ferd.ca/awk-in-20-minutes.html
