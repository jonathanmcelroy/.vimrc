try:
    from os import makedirs, listdir
    from os.path import expanduser, exists, join
    from platform import system
    from urllib.request import urlopen
    from shutil import copy, copytree
    platform = system()

    from git import Repo

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

    print("Cloning or pulling configuration git project")
    if exists(join(worktree, ".git")):
        configuration = Repo(worktree)
        origin = configuration.remotes.origin
        origin.pull()
    else:
        configuration = Repo.clone_from("https://github.com/jonathanmcelroy/configuration.git", worktree)

    print("Bootstrapping vim plugin: 'plug'")
    vimDir = getVimDir()
    if not exists(join(vimDir, "autoload", "plug.vim")):
        makedirs(join(vimDir, "autoload"), exist_ok = True)

        url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        response = urlopen(url)

        if response.getcode() != 200:
            raise Exception("Could not fetch '{}'".format(url))
        contents = response.read()
        print(len(contents))
        with open(join(vimDir, "autoload", "plug.vim"), 'wb') as f:
            f.write(contents)


    print("Copying over files")
    copy(join(worktree, ".vimrc"), getVimrc())
    copy(join(worktree, ".zshrc"), join(home, ".zshrc"))
    # TODO: copy the .cppuseful files
    # copytree(join(worktree, ".cppuseful"), join(home, ".cppuseful"))
    # TODO: copy the .cuseful files
    # copytree(join(worktree, ".cuseful"), join(home, ".cuseful"))
    
    print("Copying over binary files")
    makedirs(join(home, "bin"), exist_ok=True)
    for eachfile in listdir(join(worktree, "bin")):
        if eachfile.endswith(('.py', '.sh')):
            copy(join(worktree, 'bin', eachfile), join(home, 'bin'))

except Exception as E:
    print("Exception occured")
    import traceback
    traceback.print_exc()

input("Done")
