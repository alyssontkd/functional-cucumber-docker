#!/bin/bash
set -e

git_user='alyssontkd'
git_pswd='senha'
cucumber_dir='/usr/src/app/cucumber-petshop'
cucumber_cred_file="${cucumber_dir}/.git-credentials"
path_remote_origin='https://github.com/alyssontkd/cucumber-petshop.git'

echo "[ ****************** ] Listando diretorio atual"
ls -la
pwd

if [ ! -e "${cucumber_dir}/Gemfile" ]; then
    echo "[ ****************** ] Starting Endpoint of Application"
    sleep 2
    echo "[ ****************** ] Application not found in ${cucumber_dir} - Cloning now..."
    mkdir -p ${cucumber_dir}
    cd ${cucumber_dir}
    git init
    git remote add origin ${path_remote_origin}

    #Cria um arquivo com as credenciais para que todos os comandos que precisem de autenticação utilize este arquivo
    git config credential.helper "store --file=${cucumber_cred_file}"
    echo "https://${git_user}:${git_pswd}@github.com" > "${cucumber_cred_file}"
    echo "[ ****************** ] Ending Endpoint of Application"
fi
echo "[ ****************** ] Rodando o permissionamento...."

echo "[ ****************** ] Arquivo já existe e foi localizado. Acessando diretorio da aplicacao"
cd ${cucumber_dir}
pwd
git remote update
git reset --hard origin/master
git describe --tags --always
echo "[ ****************** ] OK! Clone Successfull!"

echo "[ ****************** ] Instalando as dependencias do Cucumber........."
cp -av /tmp/config.yml ${cucumber_dir}/features/support
cp -av /tmp/env.rb ${cucumber_dir}/features/support
cp -av /tmp/cucumber.yaml ${cucumber_dir}
rm -f ${cucumber_dir}/features/support/linux.env.rb features/support/windows.env.rb

cd ${cucumber_dir}
pwd
sleep 20
echo "************************************** Iniciando a configuração do PROJETO CUCUMBER ************************************** "
bundle install
bundle update --all
gem update
cucumber
tail -f /dev/null

exec "$@"

