FROM debian:latest
LABEL maintainer="a58524andy@gmail.com"

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install dialog apt-utils aptitude
RUN aptitude update
RUN aptitude -y safe-upgrade
RUN aptitude -y install gcc g++ gdb clang valgrind vim tmux zsh htop pigz make cmake openssh-client openssh-server openssh-sftp-server ntfs-3g libboost-all-dev git wget
RUN mkdir /var/run/sshd
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN sed -i -r 's/\#*(PermitRootLogin.*prohibit-password)/\1/' /etc/ssh/sshd_config
RUN sed -i -r 's/\#*(PasswordAuthentication).*yes/\1\ no/' /etc/ssh/sshd_config

RUN useradd --create-home --shell `which zsh` liparadise
USER liparadise
WORKDIR /home/liparadise
RUN cd
RUN git config --global user.email a58524andy@gmail.com
RUN git config --global user.name LIParadise
RUN mkdir -p .oh-my-zsh .zsh .vim/.backup .vim/.undo .vim/.swp .ssh
RUN git clone https://github.com/robbyrussell/oh-my-zsh .oh-my-zsh
RUN wget https://raw.githubusercontent.com/LIParadise/home_dir/master/.vimrc
RUN wget https://raw.githubusercontent.com/LIParadise/home_dir/master/.zshrc
RUN wget https://raw.githubusercontent.com/LIParadise/home_dir/master/.tmux.conf
RUN sed -i -r 's/(.*)virtualenvwrapper.*/\#\ \1virtualenvwrapper\.sh/' .zshrc
RUN sed -i -r 's/^export\ ZSH=.*/export\ ZSH="\$HOME\/\.oh-my-zsh"/' .zshrc
RUN sed -i -r 's/^export\ ZDOTDIR=.*/export\ ZDOTDIR="\$HOME\/\.zsh"/' .zshrc
RUN sed -i -r 's/(.*default-shell)/\#\1/' .tmux.conf
RUN sed -i -r 's/(.*default-command)/\#\1/' .tmux.conf
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDepD5TKBLysJHQb9vCzKLIOEkYcJJaHpxu+gDOuEJ/uxnTRsR4Ovx2dVGleaV45UHD1DGgKaGmHbs0qpIhKtJvWqXcI5MFgivPJfDYRD2beLx5Ch/7bAP7G1P2tAHSkSKyfEPyP6i4n6AzD6xSXpttW49h8OiLB5gm+JRmT1DSIbRsO3w3xdi8mceyL+Vo48989aCA2HB5QMsr7EiQbfvQU1OhumLMRu//Yi+IziLdl3qR0NGOxnbaT0xkK6BwvC7Yj3O1fjUJL6j7jNzsslWebsI7fWXpt1QTVYZdJ5V+Vhj+lnrXK7rLHW21wWFIrDM/XjopYo6Wy/vi5cCCDMOKQTraWl+sExsa6preLDiXK9Cw3+VHDZeDtmBBKnRHFLoSR+jFMS3MTt1JkFku9qyvRu//BspVFMCqnpkxMG5ypRB4uKzvjRBVyAd9O7iT6wB0mD+bGod4mf0nDsa5SrVi9caUUSqUSC+tHtv34st8R5HfA1TMiMIT14HbO0e82chBx/XPOaQV1qL5bCRvVNOCLXmcJuurgOrb1e0H6sIay/Q/oad+Bpi1Nrz4oWte5ER+ZxHRxq4RrkEQRD0BNXF+h6FSFqbVJ4TeoKZBnqmLIj6MCVAjGHv4Bm0lu2yvKFJPKoJQKAjEjTvEFoHLzXdWino3H7QT/xG6diaf1obO5w== client_windows_3600__host_fedora_31_60g" >> .ssh/authorized_keys
RUN chmod 644 .ssh/authorized_keys
RUN cp .zshrc .zsh

# RUN wget http://apache.stu.edu.tw/tomcat/tomcat-7/v7.0.82/bin/apache-tomcat-7.0.82.tar.gz
# RUN tar zxvf apache-tomcat-7.0.82.tar.gz

# ENV JAVA_HOME=/jdk1.8.0_152
# ENV PATH=$PATH:/jdk1.8.0_152/bin

USER root
WORKDIR /root


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
