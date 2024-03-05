# dotfiles

Just trying to have my config in one single place.
Also these notes are supposed to help me remember my setup.

## vimrc

Things to know about vim's builtin functions and my commands to it...

### Fuzzy Finding

Main idea here is to be able to fuzzy find files, their contents, tags and buffers.

#### Tags:

<Space>ts lists all tags from a project where ctags has been executed
you can <Tab>complete the tag name.

Also g] is a command to search for all occurrences of the current word.
Excellent to make jumps between files.

#### Buffers:

<Space>b lists all buffers and their id number and leaves you at the cmdline ready to type in a number.
If too many buffers appear but you kinda remind what you're looking for, you can always wildcard the name.
If you type *pat<Tab> then the bufferlist will try to autocomplete to pattern.

#### Files:

In a similar fashion. <Space>f is now mapped to the find command already wildcarded.
This means you can open the menu and start writing what you're looking for and tabComplete it.

Also <Space>F allows you to see the most recent files (100 of them).
with a number you can jump to any of those too.

Also, I've mapped a grep function to populate the quickfix list after a search pattern
You can call this function from the º key (left of 1 in my kb).
This way a list of results will open.
Mappings for the Qfix Window:

* vs --> opens in a vsplit
* 'q --> opens previous result (this mapping is due to my spanish kb)
* ¡q --> opens next result (this mapping is due to my spanish kb)
* pe --> opens file in preview window

Also remember there's the command :cdo to perfm actions in every occurrence of the Qfix list.
Finally, doing <space><space> will Toggle the qfix window.

#### Other interesting listings:

<Space>/ will use the il command to make a list with the search results for easier jumping.
As with any jumps performed, <C-o> and <C-i> allows you to move forward and backward.
Calling the jumplist (:jumps) with <Space>io allows you to count, 
in case you want to go to many previous jumps.

Similar can be done with tags, but I don't find it that much useful having g] already.

For a more expansive File Explorer, I've mapped Netrw to <Space>nt and tweaked its config a bit.

### Searching, Replacing and Editing generals

I've mapped Tab to be able to indent selections in visual mode.
Also I've mapped these mnemonic uses of the unnamed clipboard:

* <Space>pr (path relative) yanks relative path to clipboard
* <Space>pf (path file) yanks file name to clipboard
* <Space>pa (path absolute) yanks absolute path to clipboard
* <Space>pF (path folder) yanks (abs)directory name to clipboard

* <Space>rn (rename) asks for a new file name and does the saving part.
* <Space>rp (replace) is a visual mode shortcut to replace in the whole file the selected text.
* <Space>rw (replace word) is a normal mode shortcut to replace in the whole file current word.
* <Space>rw (replace WORD) is a normal mode shortcut to replace in the whole file current WORD.

Last three can be combined with the <C-A> mapping for the cmdline
to apply it to the whole arglist.
It is specifically useful if we've populated the arglist before.

<Space>tw (trailing-whitespace) is a shortcut to execute a whitespace cleanup.

<Space><Tab>= calls up Tabularize plugin and tabs with '=' the selection or line.
<Space><Tab> is the Tabularize mapping, I've added : and = to tabularize, but maybe there will be expansions of this.

Finally, I've also added a vimtips.txt file which includes many many regex patterns very useful.
Must thank http://www.zzapper.co.uk


## TODO:
- Add Bash rc guide
- Add explanation for other config files such as xsession, xresources
- Add installation guide and/or script. Maybe use GNU Stow for this.
- Also include installation for .vim/color and potential ftplugin, syntax...
- Add an installation script to take care of fzf/ripgrep/ctags and other dependencies.
- Consider adding a specific vim documentation file. Include coc.nvim as it's not going anywhere it seems.
- Update all vimrc stuff
