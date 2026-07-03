# recdvb-enable-b25-shell

[libaribb25](https://github.com/enprocode/libaribb25.git) と [recdvb](https://github.com/enprocode/recdvb.git)（`--enable-b25`付き）をビルド・インストールするためのシェルスクリプト集です。

![GitHub Workflow Status (with event)](https://img.shields.io/github/actions/workflow/status/enprocode/recdvb-enable-b25-shell/.github%2Fworkflows%2Fbuild.yml?style=for-the-badge&label=build)

## 概要

recdvb は Linux 向けの地上デジタル放送録画コマンドです。ARIB STD-B25 で暗号化されたストリームを録画時にデコードするには、B25デコードライブラリである libaribb25 を先にインストールし、recdvb を `--enable-b25` オプション付きでビルドする必要があります。本リポジトリは、その2つの手順を自動化するインストールスクリプトと、Ubuntu / macOS 向けにビルド検証を行う CI をまとめたものです。

## 動作環境

- Ubuntu (apt が使えること)
- macOS (Homebrew が使えること)

recdvb はLinuxのDVB APIに依存するため、実際に地デジチューナーで録画できるのは Ubuntu 環境のみです。macOS では libaribb25 のビルド検証のみ行っています。

## 構成

| ソース     | リポジトリ                                                    | 用途                                    |
| ---------- | -------------------------------------------------------------- | ----------------------------------------|
| libaribb25 | [libaribb25](https://github.com/enprocode/libaribb25.git)      | ARIB STD-B25 デコードライブラリ         |
| recdvb     | [recdvb](https://github.com/enprocode/recdvb.git)               | 地上デジタル放送録画コマンド            |

いずれも `lib/` 配下に git submodule として登録されています。

```
.
├── VERSION                        # リリースバージョン
├── lib/
│   ├── libaribb25/                # submodule
│   └── recdvb/                    # submodule
└── shell/
    ├── libaribb25_install.sh      # libaribb25のビルド・インストール
    └── recdvb_install.sh          # recdvbのビルド・インストール(--enable-b25)
```

## セットアップと使い方

submoduleを含めてclone します。

```bash
git clone --recurse-submodules https://github.com/enprocode/recdvb-enable-b25-shell.git
cd recdvb-enable-b25-shell
```

`--recurse-submodules` を付け忘れた場合でも、下記のインストールスクリプトが未取得のsubmoduleを自動で `git submodule update --init` します。

recdvb は libaribb25 が先にシステムへインストールされている必要があるため、**必ず libaribb25 → recdvb の順**で実行してください。

```bash
./shell/libaribb25_install.sh
./shell/recdvb_install.sh
```

いずれも内部で `make install` を実行するため、権限が必要な環境では `sudo` で実行してください。

## CI / リリース

- `.github/workflows/build.yml` が Ubuntu / macOS 向けのビルドを push・PR のたびに検証します。
- リリースはリポジトリ直下の [`VERSION`](VERSION) ファイルで管理しています。`VERSION` の内容を更新して `main` にマージすると、CIがそのバージョンに対応するGitHub Releaseがまだ存在しない場合のみ、ビルド成果物（libaribb25 / recdvb の実行ファイル一式）を添付したリリースを自動作成します。`VERSION` に変更が無いpush（例: Dependabotによる依存アクションの更新）ではリリースは作成されません。
- [Dependabot](.github/dependabot.yml) が GitHub Actions と git submodule の更新を定期的にチェックし、[Mergify](.github/mergify.yml) がCI通過後のDependabotのPRを自動マージします。

## ライセンス

本リポジトリ自体のシェルスクリプト・CI設定にライセンスは明記していません。ビルド対象の [libaribb25](https://github.com/enprocode/libaribb25.git) / [recdvb](https://github.com/enprocode/recdvb.git) はそれぞれのリポジトリのライセンスに従います。
