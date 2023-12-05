# 1. Checa se espaço em disco é suficiente para suportar o backup
## 1.2 Verifica o espaço disponníve da raiz / em Kilobytes.
espaco_disponivel_kb=$(df -k / | awk 'NR==2 {print $4}')
## 1.3 Converte o valor de Kilobytes para Gigabytes.
espaco_disponivel_gb=$(echo "scale=2; $espaco_disponivel_kb / 1048576" | bc)
## 1.4 Verifica o tamanho da pasta do GLPI.
tamanho_glpi_kb=$(du -sk /var/www/html/glpi | cut -f1)
## 1.5 Converte o valor de Kilobytes para Gigabytes.
tamanho_glpi_gb=$(echo "scale=2; $tamanho_glpi_kb / 1048576" | bc)
## 1.6 Mostra os tamanhos de cada coisa
echo -e "Tamanho diretório 'glpi': \033[34m$tamanho_glpi_gb\033[0m GB"
echo -e "Espaço disponível no /  : \033[34m$espaco_disponivel_gb\033[0m GB"
read -p "Deseja continuar a execução do script? (S/N): " resposta
if [ "$resposta" != "S" ] && [ "$resposta" != "s" ]; then
    echo -e "\033[31mScript interrompido pelo usuário.\033[0m"
    exit 1
fi