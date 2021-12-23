FROM debian
RUN apt update
RUN apt install ssh wget npm -y
RUN npm install -g wstunnel
RUN mkdir x-ui && cd x-ui
RUN rm x-ui/ /usr/local/x-ui/ /usr/bin/x-ui -rf
RUN wget https://github.com/vaxilu/x-ui/releases/download/0.3.2/x-ui-linux-amd64.tar.gz -O ./x-ui-linux-amd64.tar.gz
RUN tar zxvf x-ui-linux-amd64.tar.gz
RUN chmod +x x-ui/x-ui x-ui/bin/xray-linux-* x-ui/x-ui.sh
RUN cp x-ui/x-ui.sh /usr/bin/x-ui
RUN cp -f x-ui/x-ui.service /etc/systemd/system/
RUN v x-ui/ /usr/local/
RUN systemctl daemon-reload
RUN systemctl enable x-ui
RUN systemctl restart x-ui
RUN wget https://raw.githubusercontent.com/MvsCode/frps-onekey/master/install-frps.sh -O ./install-frps.sh
RUN chmod 700 ./install-frps.sh
RUN sh -c '/bin/echo -e "2\n5130\n5131\n5132\n5133\nadmin\nadmin\n\n\n\n\n\n\n\n\n\n" | ./install-frps.sh install'
RUN mkdir /run/sshd
RUN echo 'wstunnel -s 0.0.0.0:443 &' >>/1.sh
RUN echo '/usr/sbin/sshd -D' >>/1.sh
RUN echo '/etc/init.d/frps restart' >>/1.sh
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config 
RUN echo root:jr123456|chpasswd
RUN chmod 755 /1.sh
EXPOSE 80 8888 443 5130 5131 5132 5133 5134 5135 3306 54321
CMD  /1.sh
