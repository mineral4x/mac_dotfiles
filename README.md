# mineral4x dotfiles

## Installation

```bash
git clone https://github.com/mineral4x/mac_dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `mac_dotfiles` repository and then:

```bash
source bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
set -- -f; source bootstrap.sh
```

### Git-free install

To install these dotfiles without Git:

```bash
cd; curl -#L https://github.com/mineral4x/mac_dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh,LICENSE-MIT.txt}
```

To update later on, just run that command again.


### Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
./.osx
```

### Install Homebrew formulae

When setting up a new Mac, you may want to install some common [Homebrew](http://brew.sh/) formulae (after installing Homebrew, of course):

```bash
brew bundle ~/Brewfile
```

### Download native apps with `cask`

You could also install native apps with [`brew cask`](https://github.com/phinze/homebrew-cask):
Instead, I hijacked cask file to download packages instead of installing with brew cask

```bash
./.cask
```
