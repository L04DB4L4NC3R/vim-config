#!/bin/bash

git submodule foreach "git pull origin master"
# Install latest nodejs
if [ ! -x "$(command -v node)" ]; then
    curl --fail -LSs https://install-node.now.sh/latest | sh
    export PATH="/usr/local/bin/:$PATH"
    # Or use package manager, e.g.
    # sudo apt-get install nodejs
fi

# for vim8
cd ~/.vim/pack/syntax/start
curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -
# npm install coc-snippets --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
# vim +'CocInstall coc-bash coc-list coc-tsserver coc-go coc-pyright coc-snippets' +qall
