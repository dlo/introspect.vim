
function! FilterFile()
python << EOF
import vim
import re

buffer = vim.current.buffer

for line in buffer:
    # Check if matches a function line
    r=re.compile(".*def ([a-z_]+)\((.*)\)")
    match = r.match(line)
    if match:
        groups = match.groups()
        name = groups[0]
        arguments = ", ".join(map(lambda l: "<{%s}>" % l, groups[1].split(", ")))
        vim.command('''exec "Snippet %s %s(%s)<{}>"''' % (name, name, arguments))
EOF
endfunction

