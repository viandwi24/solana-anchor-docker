# solana-anchor-docker
Run Solana with anchor in docker container

## Features
- solana-cli v1.18.18
- nodejs v22
- anchor-cli v0.30.1 (with avm v0.30.1)
- rustc v1.79.0 (with rustup v1.27.1)

## Development
### Build Image and Run Container
```bash
docker build -t solana-anchor:1.0 .
docker run -it --rm solana-anchor:1.0
```
### Run Container with Compose
```bash
docker compose up -d
```