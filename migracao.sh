#!/bin/bash
url="https://user:senha@host/svn"

for projeto in `cat projetos-svn`; do
    echo \### Migrando: $projeto \###
    git svn clone --no-metadata -A usuarios-svn $url/$projeto $projeto
    cd $projeto
    git svn fetch
    cd ..
    git clone $projeto $projeto.git
    cd $projeto.git
    git remote add origin ssh://user@host/path/git/repos/$(echo $projeto|tr [:upper:] [:lower:]).git
    git push origin master
    echo \### Migracao de $projeto concluido! \###
    echo
done
