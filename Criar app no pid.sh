#!/bin/sh

# Olá, este programa irá printar os processo com tal nome, e criar um executável para vc apos selecionar um pid
# Obs: O executável deve estar rodando, assim o comando irá pegar os processos com tais nomes qual escolhido
# Feel free to change it :)

set -e
echo "Fala ${USER}!"
echo Por qual processo posso buscar?
echo [ Help ] este input aceita parametros do pgrep. Mais informações: pgrep --help
read -p "p: " nomedeprocesso
piddoprocesso=$(pgrep $nomedeprocesso)
echo $piddoprocesso
for npid in $piddoprocesso
do
    printf '\033[?7l'
    echo ""
    echo pid: $npid
    printf "%-50s\n" $(ps -o cmd fp $npid) | awk '{ if ( NR > 1  ) { print } }'
done
echo ""
echo ""
echo Escreva o pid que lhe atrai:
read -p 'p: ' piddebusca
final=$(ps -o cmd fp $piddebusca | awk '{ if ( NR > 1  ) { print } }')
echo c: $final
echo '#!/bin/sh' > comando.sh
echo konsole -e '"'$final'"' >> comando.sh
chmod +x comando.sh
echo '[comando.sh] criado para execução do comando selecionado!'
exit 1
