FROM base/arch
MAINTAINER Ricardo Lanziano <arpunk@cryptolab.net>

RUN pacman -Syu --noconfirm

# Installing the required packages
RUN pacman -S --noconfirm base-devel
RUN pacman -S --noconfirm ghc alex happy cabal-install

# Update Hackage package list and cabal-install
RUN cabal update

# Enable library-profiling in global cabal
RUN sed -E 's/(-- )?(library-profiling: )False/\2True/' -i .cabal/config

# Enable user cabal binaries
RUN echo "export PATH=/.cabal/bin:$PATH" > /etc/profile.d/cabal.sh
RUN chmod a+x /etc/profile.d/cabal.sh

# Update cabal
RUN cabal install cabal-install

# Load cabal.sh on login
RUN echo "source /etc/profile.d/cabal.sh" > /.bashrc