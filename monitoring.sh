#!/bin/bash
# Bash script

arch=$(uname -a)
cpup=$(cat /proc/cpuinfo | grep "physical id" | wc -l)
cpuv=$(cat /proc/cpuinfo | grep processor | wc -l)
fram=$(free -m | awk '$1 == "Mem:" {print $2}')
uram=$(free -m | awk '$1 == "Mem:" {print $3}')
pram=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')
fdisk=$(df -Bg | grep '^/dev/' | grep -v '^/boot$' | awk '{ft += $2} END {print ft}')
udisk=$(df -Bg | grep '^/dev/' | grep -v '^/boot$' | awk '{ut += $3} END {print ut}')
pdisk=$(df -Bg | grep '^/dev/' | grep -v '^/boot$' | awk '{ut += $3} {ft += $2} END {pri>
cpul=$(top -bn1 | grep Cpu | awk '{printf("%.1f%%", $2 = $4)}')
lboot=$(uptime -s | awk '{printf("%s %s", $1, substr($2, 1, length($2) - 3))}')
lvm=$(lsblk | grep lvm | wc -l | awk '{if ($1){printf("Yes"); exit;} else print "No"}')
tcp=$(netstat -an | grep 'ESTABLISHED' | wc -l) log=$(users | wc -w)
ip=$(hostname -I)
mac=$(cat /sys/class/net/enp0s3/address)
sudo=$(journalctl -q _COMM=sudo | grep COMMAND | wc -l)
wall " Arquitectura: $arch
                Physical CPU: $cpup
                Virtual CPU: $cpuv
                Memory Usage: $uram/${fram}MB ($pram%)
                Disk Usage: $udisk/${fdisk}GB ($pdisk%)
                CPU Load: $cpul
                Last Boot: $lboot
                LVM Use: $lvm
                TCP Connections: $tcp
                User Log: $log
                Network: IPv4 Address: $ip
                MAC Address: ($mac)
                Sudo: $sudo commands"

Explanation
#!/bin/bash: Esta linha é chamada de shebang e indica que o script deve ser executado usando o shell Bash.

arch=$(uname -a): 
O comando uname -a retorna informações sobre o kernel e a arquitetura do sistema. 
Aqui, a saída é armazenada na variável arch para uso posterior.

cpup=$(cat /proc/cpuinfo | grep "physical id" | wc -l): 
Esta linha recupera o número de CPUs físicas no sistema. 
Ele usa o comando cat para ler o conteúdo do arquivo /proc/cpuinfo e, em seguida, 
direciona a saída para o comando grep para buscar as linhas contendo "physical id". 
Por fim, wc -l conta o número de linhas que correspondem ao padrão e atribui o resultado à variável cpup.

cpuv=$(cat /proc/cpuinfo | grep processor | wc -l): 
Similar à linha anterior, esse comando conta o número de CPUs virtuais no sistema, 
buscando as linhas que contêm "processor" no arquivo /proc/cpuinfo.

fram=$(free -m | awk '$1 == "Mem:" {print $2}'): 
Esta linha recupera a memória total do sistema em megabytes (MB) usando o comando free. 
A saída é direcionada para o awk, que procura pela linha que começa com "Mem:" e imprime 
o valor da segunda coluna (memória total). O resultado é armazenado na variável fram.

uram=$(free -m | awk '$1 == "Mem:" {print $3}'): 
Aqui, a memória utilizada do sistema é obtida extraindo o valor da terceira coluna da linha 
que começa com "Mem:" na saída do comando free. Ela é atribuída à variável uram.

pram=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}'): 
Esta linha calcula a porcentagem de memória utilizada dividindo a memória utilizada ($3) 
pela memória total ($2) e, em seguida, multiplicando por 100. A função printf é usada para 
formatar a saída com duas casas decimais. O resultado é armazenado na variável pram.

fdisk=$(df -Bg | grep '^/dev/' | grep -v '^/boot$' | awk '{ft += $2} END {print ft}'): 
Este comando recupera o espaço total em disco em gigabytes (GB) usando o comando df para 
listar o uso do espaço em disco dos sistemas de arquivos. A saída é filtrada para incluir 
apenas as linhas que começam com "/dev/" e excluir "/boot". O comando awk calcula a soma da
segunda coluna (tamanho do disco) e imprime o valor total, que é atribuído à variável fdisk.

udisk=$(df -Bg | grep '^/dev/' | grep -v '^/boot$' | awk '{ut += $3} END {print ut}'): 
Similar à linha anterior, esse comando calcula o espaço em disco utilizado somando a terceira 
coluna (espaço utilizado) na saída do comando df e armazenando-o na variável udisk.

pdisk=$(df -Bg | grep '^/dev/' | grep -v '^/boot$' | awk '{ut += $3} {ft += $2} END {print (ut/ft*100)}'): 
Esta linha calcula a porcentagem de espaço em disco utilizado, dividindo o espaço em disco utilizado 
(ut) pelo espaço em disco total (ft) e multiplicando por 100. O resultado é atribuído à variável pdisk.

cpul=$(top -bn1 | grep Cpu | awk '{printf("%.1f%%", $2 = $4)}'): 
Esta linha recupera a carga da CPU em percentagem. O comando top é usado com a opção -bn1 para ser 
executado em modo batch e exibir apenas uma vez. A saída é direcionada para grep para encontrar a 
linha contendo "Cpu". Em seguida, o awk é usado para extrair e imprimir a quarta coluna (carga da CPU) 
com uma casa decimal. O resultado é atribuído à variável cpul.

lboot=$(uptime -s | awk '{printf("%s %s", $1, substr($2, 1, length($2) - 3))}'): 
Esta linha recupera a data e hora do último arranque do sistema. O comando uptime -s exibe o 
tempo de arranque do sistema. A saída é direcionada para o awk para formatar o resultado, 
imprimindo a primeira coluna (data) e uma substring da segunda coluna (hora) para remover 
os últimos três caracteres (segundos). O resultado formatado é atribuído à variável lboot.

lvm=$(lsblk | grep lvm | wc -l | awk '{if ($1){printf("Sim"); exit;} else print "Não"}'): 
Esta linha verifica se o LVM (Logical Volume Manager) está em uso no sistema. 
Ela utiliza o comando lsblk para listar os dispositivos de bloco, grep para buscar as linhas 
contendo "lvm" e wc -l para contar o número de linhas. Em seguida, o awk é usado para imprimir 
"Sim" se a contagem for maior que zero, indicando o uso do LVM; caso contrário, imprime "Não". 
O resultado é atribuído à variável lvm.

tcp=$(netstat -an | grep 'ESTABLISHED' | wc -l): 
Esta linha conta o número de conexões TCP estabelecidas no sistema. Ela utiliza o comando netstat 
para exibir as conexões de rede (opção -an), direciona a saída para o grep para filtrar apenas as 
linhas contendo "ESTABLISHED" e, por fim, wc -l conta o número de linhas correspondentes ao filtro. 
O resultado é atribuído à variável tcp.

log=$(users | wc -w): 
Esta linha conta o número de utilizadores com sessão iniciada. 
O comando users lista os utilizadores atualmente com sessão iniciada, e wc -w conta o número de 
palavras na saída (que representa o número de utilizadores). O resultado é atribuído à variável log.

ip=$(hostname -I): 
Aqui, o script obtém o endereço IPv4 do sistema usando o comando hostname -I, que exibe todos 
os endereços IP atribuídos ao hospedeiro. O resultado é atribuído à variável ip.

mac=$(cat /sys/class/net/enp0s3/address): 
Esta linha lê o endereço MAC da interface de rede chamada "enp0s3". 
O comando cat é usado para ler o conteúdo do ficheiro /sys/class/net/enp0s3/address, 
que contém o endereço MAC da interface. O resultado é atribuído à variável mac.

sudo=$(journalctl -q _COMM=sudo | grep COMMAND | wc -l): 
Aqui, o script conta o número de comandos executados com o comando sudo. 
O comando journalctl é usado com a opção -q para executar em modo silencioso e a opção _COMM=sudo 
para filtrar apenas os registos relacionados ao comando sudo. A saída é direcionada para o grep 
para encontrar as linhas contendo "COMMAND" e, em seguida, wc -l conta o número de linhas 
correspondentes. O resultado é atribuído à variável sudo.

wall "Arquitectura: $arch
CPU Física: $cpup
CPU Virtual: $cpuv
Utilização de Memória: $uram/${fram}MB ($pram%)
Utilização de Disco: $udisk/${fdisk}GB ($pdisk%)
Carga da CPU: $cpul
Último Arranque: $lboot
Utilização do LVM: $lvm
Conexões TCP: $tcp
Utilizadores com Sessão: $log
Rede: Endereço IPv4: $ip
Endereço MAC: ($mac)
Sudo: $sudo comandos"    

