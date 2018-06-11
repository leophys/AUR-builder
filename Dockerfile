FROM base/archlinux:latest

ARG USERID="1000"

RUN pacman -Sy --noconfirm \
    base-devel binutils \
    git vim make sudo gcc \
 && pacman -Sc --noconfirm
RUN useradd -m -u $USERID builder \
 && echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER builder
WORKDIR /home/builder
COPY entry-point.sh /home/builder

ENTRYPOINT ["/home/builder/entry-point.sh"]
CMD []
