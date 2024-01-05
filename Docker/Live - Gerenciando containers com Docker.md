https://www.youtube.com/watch?v=iXH5p-RjlkI

https://docs.docker.com/engine/install/centos/
->  2. Start Docker.
 sudo systemctl start docker
 sudo systemctl enable docker

    3. Verify that the Docker Engine installation is successful by running the hello-world image.
 sudo docker run hello-world


COMANDOS
# Consulte as imagens armazenadas na VM
[root@localhost /]# docker images
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
hello-world   latest    d2c94e258dcb   8 months ago   13.3kB
# Solicite uma nova imagem de algum serviço do Registro do Docker
[root@localhost /]# docker pull nginx
[root@localhost /]# docker images
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
nginx         latest    d453dd892d93   2 months ago   187MB
hello-world   latest    d2c94e258dcb   8 months ago   13.3kB
# inicie um Container
[root@localhost /]# docker run -p 80:80 nginx      # -p Especifica porta da VM : Porta do container. Acrescente -d
[root@localhost /]# docker run -p 80:80 -d nginx   # -d Coloca para rodar em Daemon(background) 
# Visualize os container rodando na máquina
[root@localhost /]#  docker container ls
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                               NAMES
30ee86e8f90a   nginx     "/docker-entrypoint.…"   20 seconds ago   Up 18 seconds   0.0.0.0:80->80/tcp, :::80->80/tcp   frosty_heyrovsky
# visualize os logs do container
[root@localhost /]# docker logs 30ee86e8f90a -f    # -f Logs rodando continuamente. ^C p/ sair
# Passe/Adicione um site.html para dentro do container
  # Crie um diretório por ex cep.html em /home/vagrant
[root@localhost vagrant]# docker run --name nginx-cep -p 8080:80 -v /home/vagrant/html:/usr/share/nginx/html -d nginx
648cb1b01d224d9fa974df9cb6ccdd5e51ffce1c523ff8dcb35bb8479af4e37f
# visualize os containers rodando
CONTAINER ID   IMAGE     COMMAND                  CREATED              STATUS              PORTS                                   NAMES
648cb1b01d22   nginx     "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:8080->80/tcp, :::8080->80/tcp   nginx-cep       
30ee86e8f90a   nginx     "/docker-entrypoint.…"   About an hour ago    Up About an hour    0.0.0.0:80->80/tcp, :::80->80/tcp       frosty_heyrovsky
# Remove um container
[root@localhost vagrant]# docker rm 648cb1b01d22 -f  # ID ou NAME / -f Forçar remoção pois ele está em execução.

# Criar uma imagem personalizada
[root@localhost vagrant]# mkdir image_nginx
[root@localhost vagrant]# ls
html  image_nginx
[root@localhost vagrant]# cd image_nginx/
[root@localhost image_nginx]# vim Dockerfile
[root@localhost image_nginx]# cat Dockerfile 
FROM nginx:latest
COPY html/cep.html /usr/share/nginx/html/cep.html
# Cria de fato a imagem
[root@localhost image_nginx]# docker build -t nginx-cep .
[root@localhost image_nginx]# docker run --name nginx-personalizado -p 8081:80 -d nginx # Erro, estamos criando com base na imagem já existente, nginx, e não a que acabos de criar nginx-cep
[ERROR] 2024/01/04 23:32:07 [error] 29#29: *1 open() "/usr/share/nginx/html/cep.html" failed (2: No such file or directory), client: 192.168.15.41, server: localhost, request: "GET /cep.html HTTP/1.1", host: "192.168.15.78:8081"
# Precisamos passar o nome da imagem que nós geramos (nginx-cep)
# Remova o containte e crie o correto
[root@localhost image_nginx]# docker run --name nginx-personalizado -p 8081:80 -d nginx-cep