> 这里是 rust-bbs 开源项目的服务端，本项目旨在帮助大家快速了解&入门 rust Web 开发，如果觉得对你有帮助记得点个🌟，🙏。

## 项目地址

## 项目介绍

`rust-bbs`是一个使用 Rust 语言搭建的开源社区系统，采用前后端分离技术。Nextjs 作为前端用户界面渲染框架，Rust 提供 API 数据支持。

### 功能结构

## 项目部署

### 本地部署
1、配置数据地址在`.env`文件中
```shell
DATABASE_URL="mysql://username:password@localhost/bbs"
```
2、生成entity
```shell
sea-orm-cli generate entity  -o entity/src -l --with-serde both
```
3、启动项目
```shell
cargo build
```