" Configuration specific for Arduino

let g:arduino_cmd = '/Applications/Arduino.app/Contents/MacOS/Arduino'
let g:arduino_dir = '/Applications/Arduino.app/Contents/Java'

function! b:MyStatusLine()
  return '%f [' . g:arduino_board . ']'
endfunction
setl statusline=%!b:MyStatusLine()
