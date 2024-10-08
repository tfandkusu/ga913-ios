/*
 See the LICENSE.txt file for this sample’s licensing information.

 Abstract:
 A view showing the details for a landmark.
 */

import SwiftUI

/// ランドマーク詳細画面
struct LandmarkDetail: View {
    @Environment(ModelData.self) var modelData
    var landmark: Landmark

    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }

    private let analyticsEventSender = AnalyticsEventSender()

    var body: some View {
        @Bindable var modelData = modelData

        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
                .frame(height: 300)

            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                    FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite, onChanged: { favorite in
                        if favorite {
                            analyticsEventSender.sendAction(
                                AnalyticsEvent.Action.LandmarkDetail.FavoriteOn(id: landmark.id, name: landmark.name)
                            )
                        } else {
                            analyticsEventSender.sendAction(
                                AnalyticsEvent.Action.LandmarkDetail.FavoriteOff(id: landmark.id, name: landmark.name)
                            )
                        }
                    })
                }

                HStack {
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Divider()

                Text("About \(landmark.name)")
                    .font(.title2)
                Text(landmark.description)
            }
            .padding()
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            analyticsEventSender.sendScreen(AnalyticsEvent.Screen.LandmarkDetail())
        }
    }
}

#Preview {
    let modelData = ModelData()
    return LandmarkDetail(landmark: modelData.landmarks[0])
        .environment(modelData)
}
