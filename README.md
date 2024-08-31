# DroidKaigi 2024「 データに基づく意思決定を支える、Google Analytics for Firebase のイベント送信」の iOS アプリのイベント送信実装例

Apple 公式サンプル  [Handling user input](https://developer.apple.com/tutorials/swiftui/handling-user-input) に対して、表題の発表内容に沿って [Google Analytics for Firebase](https://firebase.google.com/docs/analytics) のイベント送信を実装しています。

Analytics イベント送信は [AnalyticsEventSender 構造体](https://github.com/tfandkusu/ga913-ios/blob/main/Landmarks/Analytics/AnalyticsEventSender.swift)の関数によって行われます。
AnalyticsEventScreen, AnalyticsEventAction プロトコルに準拠したインスタンスしか渡せません。それを生成するための構造体群は [AnalyticsEvent.swift](https://github.com/tfandkusu/ga913-ios/blob/main/Landmarks/Analytics/AnalyticsEvent.swift) に定義されていて、[tfandkusu/ga913-yaml](https://github.com/tfandkusu/ga913-yaml) により [Android アプリ](https://github.com/tfandkusu/ga913-android)と共通の YAML ファイルから自動生成されます。

それにより、iOS / Android でイベント名やイベントパラメータ名、値の型の違いを仕組みで防いでいます。
