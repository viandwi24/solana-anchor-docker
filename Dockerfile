FROM --platform=linux/amd64 ubuntu:22.04 AS base

# step 1. install global dependencies
# step 1.1 update repo
RUN apt-get update

# step 2.1 Install node
# step 2.1.1 deps
RUN apt-get install -y curl gnupg2
# step 2.1.2 install node
RUN curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
# step 2.1.3 test

# step 3.1 Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# step 4.1 Install rustup
RUN apt-get install -y build-essential
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# step 2.4 Install Solana CLI
RUN apt-get install -y git bash pkg-config libudev-dev libssl-dev
RUN sh -c "$(curl -sSfL https://release.solana.com/v1.18.18/install)"
ENV PATH="$PATH:/root/.local/share/solana/install/active_release/bin"
RUN echo 'export PATH="$PATH:/root/.local/share/solana/install/active_release/bin"' >> ~/.bashrc

# step 2.5 Install Anchor CLI
# step 2.5.1 install version manager
RUN cargo install --git https://github.com/coral-xyz/anchor avm --locked --force
ENV PATH="$PATH:/root/.cargo/bin/"
# step 2.5.2 install latest version
RUN avm install latest
# step 2.5.3 set default version
RUN avm use latest

# step 0 Prepare environment
ENV SOLANA_RPC=devnet
COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

# CMD
ENTRYPOINT ["/usr/local/bin/startup.sh"]