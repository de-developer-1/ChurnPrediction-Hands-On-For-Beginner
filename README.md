# Rによる解約予測テンプレート

Rを用いた解約予測モデルの学習・可視化を Docker 環境で体験できるハンズオン

## 構成内容
- XGBoost による学習(サンプルデータは生成AIにて作成)
- Shiny による予測可視化
- Docker による RStudio + Shiny 統合

## 起動方法

```bash
docker-compose up --build
```

- RStudio: http://localhost:8787 （ユーザ: rstudio / パスワード: rstudio）
- Shiny: http://localhost:3838