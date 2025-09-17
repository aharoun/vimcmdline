" Ensure that plugin/vimcmdline.vim was sourced
if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif

function! MatlabSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines_for_vimcmdline.m")
    "avoid calling lines.m from absolute path, othewise matlab path changes. When run matlab, add `/tmp/` to the path
    call VimCmdLineSendCmd('clc; type lines_for_vimcmdline.m; run(''lines_for_vimcmdline.m'');')
endfunction

let b:cmdline_nl = "\n"
" let cmdline_app['matlab'] = 'matlab -nosplash -nodesktop -r addpath(''/tmp/'')' is added to .vimrc with double quote
" around addpath...
let b:cmdline_app = "matlab"
let b:cmdline_quit_cmd = "exit"
let b:cmdline_source_fun = function("MatlabSourceLines")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "matlab"

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

exe 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines_for_vimcmdline.m")'

call VimCmdLineSetApp("matlab")
