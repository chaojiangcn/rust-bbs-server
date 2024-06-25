FROM rust:1.78.0 as builder

COPY . /app

WORKDIR /app

RUN cargo build --release

FROM gcr.io/distroless/cc-debian11

COPY --from=builder /app/target/release/rust-bbs-server /app/rust-bbs-server
WORKDIR /app

CMD ["./rust-bbs-server"]