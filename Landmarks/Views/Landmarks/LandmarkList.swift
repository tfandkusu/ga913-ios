/*
 See the LICENSE.txt file for this sample’s licensing information.

 Abstract:
 A view showing a list of landmarks.
 */

import FirebaseAnalytics
import ga913kmp
import SwiftUI

/// 最初のリスト画面
struct LandmarkList: View {
    /// データ層
    @Environment(ModelData.self) var modelData
    /// Favorites only スイッチの状態
    @State private var showFavoritesOnly = false

    private let analyticsEventSender = AnalyticsEventSender()

    /// 表示するランドマーク一覧
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            !showFavoritesOnly || landmark.isFavorite
        }
    }

    @AppStorage("navigationPath") var navigationPath: [Landmark] = []

    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }.onChange(of: showFavoritesOnly) {
                    analyticsEventSender.sendAction(
                        AnalyticsEvent.Action.LandmarkList.FavoritesOnlySwitch(favoritesOnly: showFavoritesOnly)
                    )
                    // KMP 版の使用例
                    /*
                     analyticsEventSender.sendAction(
                         KmpAnalyticsEventAction.LandmarkListFavoritesOnlySwitch(favoritesOnly: showFavoritesOnly)
                     )
                      */
                }

                ForEach(filteredLandmarks) { landmark in
                    NavigationLink(value: landmark) {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .animation(.default, value: filteredLandmarks)
            .navigationTitle("Landmarks")
            .navigationDestination(for: Landmark.self) { landmark in
                LandmarkDetail(landmark: landmark)
            }
            .onAppear {
                analyticsEventSender.sendScreen(AnalyticsEvent.Screen.LandmarkList())
                // KMP 版の使用例
                /*
                 analyticsEventSender.sendScreen(KmpAnalyticsEventScreen.LandmarkList())
                  */
            }
        }
    }
}

#Preview {
    LandmarkList()
        .environment(ModelData())
}
