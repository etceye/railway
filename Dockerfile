FROM debian
RUN apt update
RUN apt install ssh wget -y
RUN wget https://raw.githubusercontent.com/MvsCode/frps-onekey/master/install-frps.sh -O ./install-frps.sh
RUN chmod 700 ./install-frps.sh
RUN sh -c '/bin/echo -e "2\n5130\n5131\n5132\n5133\nadmin\nadmin\n\n\n\n\n\n\n\n\n\n" | ./install-frps.sh install'
RUN mkdir /run/sshd
RUN echo '/usr/sbin/sshd -D' >>/1.sh
RUN echo '/etc/init.d/frps restart' >>/1.sh
RUN echo '/etc/init.d/sshd restart' >>/1.sh
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config 
RUN echo root:jr227799|chpasswd
RUN chmod 755 /1.sh
EXPOSE 80 8888 443 5130 5131 5132 5133 5134 5135 3306 54321
CMD  /1.sh
RUN wget https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh -O ./install.sh
RUN chmod 755 ./install.sh
RUN sh -c './install.sh install'
