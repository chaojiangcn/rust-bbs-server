FROM rust:1.78.0 as builder
#FROM registry.cn-heyuan.aliyuncs.com/cocaine_admin/bbs_rust:1.79.0
WORKDIR /app

COPY . .

RUN cargo build --release

#FROM gcr.io/distroless/cc-debian11

#COPY --from=builder /app/target/release/rust-bbs-server /app/rust-bbs-server
#WORKDIR /app

CMD ["./target/release/rust-bbs-server"]