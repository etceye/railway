FROM debian
RUN apt update
RUN apt install ssh wget tar -y
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
RUN frps status
run ls -l /etc/systemd/system/
RUN wget https://github.com/vaxilu/x-ui/releases/download/0.3.2/x-ui-linux-amd64.tar.gz -O ./x-ui-linux-amd64.tar.gz
RUN tar zxvf x-ui-linux-amd64.tar.gz
RUN chmod -R 0777 ./x-ui/
RUN cp x-ui/x-ui.sh /usr/bin/x-ui
RUN cp -f x-ui/x-ui.service /etc/systemd/system/
RUN mv x-ui/ /usr/local/
