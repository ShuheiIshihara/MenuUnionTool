# CLAUDE.md

このファイルは、Claude Code (claude.ai/code) がこのリポジトリでコードを操作する際のガイダンスを提供します。

## プロジェクト概要

MenuUnionToolは、買い物リストと食事メニューを管理するためのSwiftUIベースのiOSアプリケーションです。このアプリはバックエンドデータベースサービスとしてSupabaseに接続します。

## アーキテクチャ

- **言語**: Swift
- **フレームワーク**: SwiftUI
- **データベース**: Supabase
- **プラットフォーム**: iOS (Xcodeプロジェクト)

### 主要コンポーネント

- `MenuUnionToolApp.swift`: メインアプリのエントリーポイント
- `ContentView.swift`: Supabaseから食事メニューデータを表示するプライマリUIビュー
- `Supabase.swift`: データベース設定とデータモデル
- `Config.xcconfig`: Supabaseの認証情報を含む設定ファイル

### データモデル

- `Instrument`構造体は食事メニュー項目を表し、以下を含みます：
  - `meal_id`: 食事の整数識別子
  - `ingredients_id`: 食材の整数識別子
  - `created_at`: 文字列タイムスタンプ

## 開発コマンド

これはXcodeベースのSwiftプロジェクトです。開発にはXcode IDEを使用してください：

- **ビルド**: XcodeのBuild (⌘+B) または Product → Build を使用
- **実行**: XcodeのRun (⌘+R) または Product → Run を使用
- **テスト**: XcodeのTest (⌘+U) または Product → Test を使用

## データベース統合

アプリは以下のテーブルでSupabaseを使用します：
- `meal_menu`: 食事と食材の関係を保存

設定は`Config.xcconfig`から読み込まれ、`Bundle.main.object(forInfoDictionaryKey:)`経由でアクセスされます。

## プロジェクト構造

```
MenuUnionTool/
├── MenuUnionTool/          # メインアプリターゲット
│   ├── MenuUnionToolApp.swift
│   ├── ContentView.swift
│   ├── Supabase.swift
│   ├── Config.xcconfig
│   └── Assets.xcassets/
├── MenuUnionToolTests/     # ユニットテスト
└── MenuUnionToolUITests/   # UIテスト
```