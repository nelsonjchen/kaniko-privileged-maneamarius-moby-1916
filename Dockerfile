FROM gentoo/stage3-amd64
# Download and extract latest portage
RUN wget http://distfiles.gentoo.org/snapshots/portage-latest.tar.bz2 && \
    wget http://distfiles.gentoo.org/snapshots/portage-latest.tar.bz2.md5sum && \
    md5sum -c portage-latest.tar.bz2.md5sum 
RUN tar -xjvf portage-latest.tar.bz2 -C /usr
RUN emerge dev-lang/go
