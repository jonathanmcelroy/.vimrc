try:
    from os import makedirs, listdir
    from os.path import expanduser, exists, join
    from platform import system
    from urllib.request import urlopen
    from shutil import copy, copytree
    platform = system()

    from git import Repo, GitCommandError

    home = expanduser('~')
    worktree = join(home, "configuration")

    def getVimDir():
        if platform == "Windows":
            return join(home, "vimfiles")
        elif platform == "Linux":
            return join(home, ".local", "share", "nvim", "site")
        else:
            raise Exception("Unknown platform {}".format(platform))

    def getVimrc():
        if platform == "Windows":
            return join(home, "_vimrc")
        elif platform == "Linux":
            return join(home, ".vimrc")
        else:
            raise Exception("Unknown platform {}".format(platform))

    print("Creating configuration directory '{}'".format(worktree))
    makedirs(worktree, exist_ok=True)

    print("Cloning configuration git project")
    if exists(join(worktree, ".git")):
        configuration = Repo(worktree)
    else:
        configuration = Repo.clone_from("https://github.com/jonathanmcelroy/configuration.git", worktree)

    print("Copying over files")
    copy(getVimrc(), join(worktree, ".vimrc"))
    copy(join(home, ".zshrc"), join(worktree, ".zshrc"))
    # TODO: copy the .cppuseful files
    # copytree(join(home, ".cppuseful"), join(worktree, ".cppuseful"))
    # TODO: copy the .cuseful files
    # copytree(join(home, ".cuseful"), join(worktree, ".cuseful"))

    print("Copying over binary files")
    makedirs(join(worktree, "bin"), exist_ok=True)
    for eachfile in listdir(join(home, "bin")):
        if eachfile.endswith(('.py', '.sh')):
            copy(join(home, 'bin', eachfile), join(worktree, 'bin'))

    print("Deleting files from git")
    configuration.git.add('.')
    #deletedFiles = configuration.git.ls_files('--deleted', '-z')
    #if deletedFiles != "":
        #deletedFilesList = deletedFiles.split('\x00')[:-1]
        #configuration.index.remove(deletedFilesList)

    print("Commiting git")
    try:
        configuration.git.diff('--cached', '--quiet')
    except GitCommandError as E:
        configuration.git.commit('-m', 'Updated configuration')

    print("Pushing git")
    try: 
        configuration.git.diff('--stat', 'origin/master', '--quiet')
    except GitCommandError as E:
        configuration.git.push()

except Exception as E:
    print("Exception occured")
    import traceback
    traceback.print_exc()

input("Done")
