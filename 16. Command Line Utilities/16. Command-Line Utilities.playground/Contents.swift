import Cocoa

//bignerd@NerdBookPro ~ %
//-> bignerd = user
//-> NerdBookPro = host
//-> ~ = directory
//-> % = prompt

//The username of the computer’s current user.
//The host name of the system. You can set this for your Mac in the Sharing pane of
//System Preferences.
//The current working directory name. The symbol ~ represents the user’s home directory, such as /Users/username/, which is usually the default directory for a new Terminal session.
//The command prompt. The command that you type appears after this symbol. On some systems it might be a different symbol, such as $ or >. Throughout this chapter, we will use the % symbol before text that you should enter at a command prompt.
//The current text insertion point. Yours might look different, but it usually appears as a line or box.

// % cd ~/Desktop -> move to the Desktop folder
// % ls -> list the contents of the directory
//Some commands take options, usually represented by letters or words prefixed with a hyphen (-), that change the way the command will behave. Change back to your home directory, then list the contents of a different directory by passing its path as an argument to the ls command. This time, use the -l option to instruct the ls command to list the directory contents in a detailed list format:
//% cd ..
//% ls -l /usr/share/dict/
//Here, you change to the .. pseudo-directory. This is not truly a directory at all, but a reference to the current directory’s parent directory.
//The /usr/ share/dict/ directory is a location on every Mac where files with common words are stored. You will use these files in the exercise later.

//% xcode-select --help
//Usage: xcode-select [options]
//    Print or change the path to the active developer directory. This directory
//    controls which tools are used for the Xcode command line tools (for example,
//    xcodebuild) as well as the BSD development commands (such as cc and make).

// Mac default command shell => zsh.

// MARK: Building the Word Finder

//The tool you are about to build, wordlasso, is a word-finding application that could be used to help you with crossword puzzles and other word-based games. The user will be able to execute it like so:

//    % wordlasso -i la..o
//    lacto
//    Lanao
//    Lango
//    largo
//    lasso
//    latro

//The . at the beginning of a path is a pseudo-directory, like the .. you saw earlier. Where .. means “parent directory,” . means “this directory.” So ./wordlasso means “execute the wordlasso in this directory.” Without the ./ prefix, Terminal would look for a wordlasso tool in a small list of mostly system-owned directories referred to as your $PATH.
