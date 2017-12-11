"=============================================================================
" FILE: autoload/echodoc/util.vim
" AUTHOR:  Shougo Matsushita <Shougo.Matsu at gmail.com>
"          Tommy Allen <tommy@esdf.io>
" License: MIT license
"=============================================================================

" Return the next column and character at the column position in text.  Keep
" scanning until a usable character is found.  This should be safe for
" multi-byte characters.
function! s:mbprevchar(text, col) abort
  if a:col < 0
    return [a:col, '']
  endif
  let c = matchstr(a:text, '\%'.a:col.'c.')
  let c1 = a:col - 1
  while c1 > 0 && c == ''
    let c = matchstr(a:text, '\%'.c1.'c.')
    let c1 -= 1
  endwhile
  return [c1, c]
endfunction

" Try to find a function at the current position.
" Stops if `echodoc_max_blank_lines` is encountered. (max 50)
" @vimlint(EVL102, 1, l:_)
function! echodoc#util#get_func_text() abort
  let l2 = line('.')
  let c2 = col('.') - 1
  let l1 = l2
  let c1 = c2

  let skip = 0
  let last_quote = ''
  let text = getline(l1)[: c2-1]
  let found = 0
  let line_guard = 0
  let blank = 0
  let max_blank = max([1, get(b:, 'echodoc_max_blank_lines',
        \ get(g:, 'echodoc_max_blank_lines', 1))])

  while l1 > 0 && line_guard < 5 && blank < max_blank
    if c1 <= 0
      let l1 -= 1
      let c1 = col([l1, '$'])
      let text = getline(l1)
      if len(text) == 0
        let blank += 1
      else
        let blank = 0
      endif
      let line_guard += 1
      continue
    endif

    let [c1, c] = s:mbprevchar(text, c1)
    let p = ''

    if c1 > 0
      let [_, p] = s:mbprevchar(text, c1)
      if p == '\'
        continue
      endif
    endif

    if last_quote == '' && (c == "'" || c == '"' || c == '`')
      let last_quote = c
      continue
    elseif last_quote != ''
      if last_quote == c
        let last_quote = ''
      endif
      continue
    endif

    if c == '('
      if skip == 0
        if p =~# '\k'
          let found = 1
          break
        endif
      else
        let skip -= 1
      endif
    elseif c == ')'
      let skip += 1
    endif
  endwhile

  if (found || last_quote != '') && l1 > 0 && c1 > 0
    let lines = getline(l1, l2)
    let lines[-1] = c2 == 0 ? '' : lines[-1][:c2 - 1]
    let lines[0] = c1 == 0 ? '' : matchstr(lines[0], '\k\+\%>'.(c1 - 1).'c.*')
    return join(lines, "\n")
  endif

  return ''
endfunction
" @vimlint(EVL102, 0, l:_)

" Returns a parsed stack of functions found in the text.  Each item in the
" stack contains a dict:
" - name: Function name.
" - start: Argument start position.
" - end: Argument end position.  -1 if the function is unclosed.
" - pos: The argument position.  1-indexed, 0 = no args, -1 = closed.
" - ppos: The function's position in the previous function in the stack.
" - args: A list of arguments.
function! echodoc#util#parse_funcs(text) abort
  if a:text == ''
    return []
  endif

  " Function pointer pattern.
  " Example: int32_t get(void *const, const size_t)
  let text = a:text
  let text = substitute(text, '\s*(\*)\s*', '', 'g')
  let text = substitute(text, '^(\(.*\))$', '\1', '')

  let quote_i = -1
  let stack = []
  let open_stack = []
  let comma = 0

  " Matching pairs will count as a single argument entry so that commas can be
  " skipped within them.  The open depth is tracked in each open stack item.
  " Parenthesis is an exception since it's used for functions and can have a
  " depth of 1.
  let pairs = '({[)}]'
  let l = len(text) - 1
  let i = -1

  while i < l
    let i += 1
    let c = text[i]

    if i > 0 && text[i - 1] == '\'
      continue
    endif

    if quote_i != -1
      " For languages that allow '''' ?
      " if c == "'" && text[i - 1] == c && i - quote_i > 1
      "   continue
      " endif
      if c == text[quote_i]
        let quote_i = -1
      endif
      continue
    endif

    if quote_i == -1 && (c == "'" || c == '"' || c == '`')
      " backtick (`) is not used alone in languages that I know of.
      let quote_i = i
      continue
    endif

    let prev = len(open_stack) ? open_stack[-1] : {'opens': [0, 0, 0]}
    let opened = prev.opens[0] + prev.opens[1] + prev.opens[2]

    let p = stridx(pairs, c)
    if p != -1
      let ci = p % 3
      if p == 3 && opened == 1 && prev.opens[0] == 1
        " Closing the function parenthesis
        if len(open_stack)
          let item = remove(open_stack, -1)
          let item.end = i - 1
          let item.pos = -1
          let item.opens[0] -= 1
          if comma <= i
            call add(item.args, text[comma :i - 1])
          endif
          let comma = item.i
        endif
      elseif p == 0
        " Opening parenthesis
        let func_i = match(text[:i - 1], '\S', comma)
        let func_name = matchstr(text[func_i :i - 1], '\k\+$')

        if func_i != -1 && func_i < i - 1 && func_name != ''
          let ppos = 0
          if len(open_stack)
            let ppos = open_stack[-1].pos
          endif

          if func_name != ''
            " Opening parenthesis that's preceded by a non-empty string.
            call add(stack, {
                  \ 'name': func_name,
                  \ 'i': func_i,
                  \ 'start': i + 1,
                  \ 'end': -1,
                  \ 'pos': 0,
                  \ 'ppos': ppos,
                  \ 'args': [],
                  \ 'opens': [1, 0, 0]
                  \ })
            call add(open_stack, stack[-1])

            " Function opening parenthesis marks the beginning of arguments.
            " let comma = i + 1
            let comma = i + 1
          endif
        else
          let prev.opens[0] += 1
        endif
      else
        let prev.opens[ci] += p > 2 ? -1 : 1
      endif
    elseif opened == 1 && prev.opens[0] == 1 && c == ','
      " Not nested in a pair.
      if len(open_stack) && comma <= i
        let open_stack[-1].pos += 1
        call add(open_stack[-1].args, text[comma :i - 1])
      endif
      let comma = i + 1
    endif
  endwhile

  if len(open_stack)
    let item = open_stack[-1]
    call add(item.args, text[comma :l])
    let item.pos += 1
  endif

  if len(stack) && stack[-1].opens[0] == 0
    let item = stack[-1]
    let item.trailing = matchstr(text, '\s*\zs\p*', item.end + 2)
  endif

  return stack
endfunction


function! echodoc#util#completion_signature(completion, maxlen, filetype) abort
  if empty(a:completion)
    return {}
  endif

  let info = ''

  if a:completion.info =~# '^.\+('
    let info = matchstr(a:completion.info, '^\_s*\zs.*')
  elseif a:completion.abbr =~# '^.\+('
    let info = a:completion.abbr
  elseif a:completion.menu =~# '^.\+('
    let info = a:completion.menu
  elseif a:completion.word =~# '^.\+(' || a:completion.kind == 'f'
    let info = a:completion.word
  endif

  let info = info[:a:maxlen]
  let stack = echodoc#util#parse_funcs(info)

  if empty(stack)
    return {}
  endif

  let comp = stack[0]
  let word = matchstr(a:completion.word, '\k\+')
  if comp.name != word
    " Completion 'word' is what actually completed, if the parsed name is
    " different, it's probably because 'info' is an abstract function
    " signature.  .e.g in Go:
    " completed: BoolVar(p *bool, name string, value bool, usage string)
    " info:      func(p *bool, name string, value bool, usage string)
    let comp.name = word
  endif
  return comp
endfunction
