// https://github.com/tfandkusu/ga913-yaml/ による自動生成コードです。編集しないでください。
/**
 * 画面遷移イベントのプロトコル */
protocol AnalyticsEventScreen {

  /**
   * Analytics イベント名 */
  var eventName: String { get }
  /**
   * コンバージョンイベントフラグ */
  var isConversionEvent: Bool { get }

}

/**
 * 画面内操作イベントのプロトコル */
protocol AnalyticsEventAction {

  /**
   * Analytics イベント名 */
  var eventName: String { get }
  /**
   * Analytics イベントパラメータ */
  var eventParameters: [String : Any] { get }
  /**
   * コンバージョンイベントフラグ */
  var isConversionEvent: Bool { get }

}

/**
 * Analytics イベント構造体群 */
struct AnalyticsEvent {

  /**
   * 画面遷移イベント構造体群 */
  struct Screen {

    /**
     * ランドマーク一覧画面 */
    struct LandmarkList : AnalyticsEventScreen {

      let eventName: String = "LandmarkList"
      let isConversionEvent: Bool = false

    }

    /**
     * ランドマーク詳細画面 */
    struct LandmarkDetail : AnalyticsEventScreen {

      let eventName: String = "LandmarkDetail"
      let isConversionEvent: Bool = false

    }

    /**
     * 設定画面 */
    struct Setting : AnalyticsEventScreen {

      let eventName: String = "Setting"
      let isConversionEvent: Bool = true

    }

    /**
     * 情報画面 */
    struct Info : AnalyticsEventScreen {

      let eventName: String = "Info"
      let isConversionEvent: Bool = false

    }

  }

  /**
   * 画面内操作イベント構造体群 */
  struct Action {

    /**
     * ランドマーク一覧画面 */
    struct LandmarkList {

      /**
       * いいねを付けたランドマークのみを表示するスイッチ */
      struct FavoritesOnlySwitch : AnalyticsEventAction {

        let eventName: String = "LandmarkListFavoritesOnlySwitch"
        let eventParameters: [String : Any]
        let isConversionEvent: Bool = false

        init(favoritesOnly: Bool) {
          eventParameters = [
              "favorites_only": favoritesOnly,
          ]
        }

      }

    }

    /**
     * ランドマーク詳細画面 */
    struct LandmarkDetail {

      /**
       * いいねを付ける */
      struct FavoriteOn : AnalyticsEventAction {

        let eventName: String = "LandmarkDetailFavoriteOn"
        let eventParameters: [String : Any]
        let isConversionEvent: Bool = true

        init(id: Int64, name: String) {
          eventParameters = [
              "id": id,
              "name": name,
          ]
        }

      }

      /**
       * いいねを解除する */
      struct FavoriteOff : AnalyticsEventAction {

        let eventName: String = "LandmarkDetailFavoriteOff"
        let eventParameters: [String : Any]
        let isConversionEvent: Bool = false

        init(id: Int64, name: String) {
          eventParameters = [
              "id": id,
              "name": name,
          ]
        }

      }

    }

    /**
     * 設定画面 */
    struct Setting {
    }

    /**
     * 情報画面 */
    struct Info {

      /**
       * プライバシーポリシーを表示する */
      struct PrivacyPolicy : AnalyticsEventAction {

        let eventName: String = "InfoPrivacyPolicy"
        let eventParameters: [String : Any]
        let isConversionEvent: Bool = false

        init() {
          eventParameters = [:]
        }

      }

    }

  }

}
