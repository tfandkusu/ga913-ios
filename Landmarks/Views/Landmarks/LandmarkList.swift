/*
 See the LICENSE.txt file for this sample’s licensing information.

 Abstract:
 A view showing a list of landmarks.
 */

import FirebaseAnalytics
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

    var body: some View {
        NavigationSplitView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }.onChange(of: showFavoritesOnly) {
                    analyticsEventSender.sendAction(
                        action: AnalyticsEvent.Action.LandmarkList.FavoritesOnlySwitch(favoritesOnly: showFavoritesOnly)
                    )
                }

                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .animation(.default, value: filteredLandmarks)
            .navigationTitle("Landmarks")
            .onAppear {
                analyticsEventSender.sendScreen(screen: AnalyticsEvent.Screen.LandmarkList())
            }
        } detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    LandmarkList()
        .environment(ModelData())
}
