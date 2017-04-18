FROM archlinuxjp/archlinux:latest

RUN pacman -S --noconfirm base-devel \
    && paccache -r -k0

RUN pacman -S --noconfirm git cmake \
    && paccache -r -k0

RUN pacman -S --noconfirm neovim python-{neovim,pytest} \
    && paccache -r -k0

RUN pacman -S --noconfirm rustup \
    && paccache -r -k0 \
    && rustup default nightly
    && rustup component add rls
    && rustup component add rust-analysis
    && rustup component add rust-src

RUN timeout 3 rustup run nightly rls

RUN git clone --depth 1 https://github.com/junegunn/fzf.git /root/.fzf && /root/.fzf/install --bin

CMD /bin/bash
