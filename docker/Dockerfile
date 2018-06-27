FROM base/archlinux:latest

ARG USERID="1000"
ARG BUILD_TYPE

RUN pacman -Sy --noconfirm \
    base-devel binutils \
    git vim make sudo gcc \
 && pacman -Sc --noconfirm
RUN useradd -m -u $USERID builder \
 && echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER builder
WORKDIR /home/builder
COPY docker/${BUILD_TYPE}/aurbuilder /home/builder

ENTRYPOINT ["/home/builder/aurbuilder"]
CMD []
