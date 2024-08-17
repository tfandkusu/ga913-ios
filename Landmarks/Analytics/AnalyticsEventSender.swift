import FirebaseAnalytics

struct AnalyticsEventSender {
    func sendScreen(_ screen: AnalyticsEventScreen) {
        if screen.isConversionEvent {
            Analytics.logEvent(screen.eventName, parameters: nil)
        } else {
            Analytics.logEvent(AnalyticsEventScreenView, parameters: [
                AnalyticsParameterScreenName: screen.eventName,
            ])
        }
    }

    func sendAction(_ action: AnalyticsEventAction) {
        if action.isConversionEvent {
            Analytics.logEvent(action.eventName, parameters: action.eventParameters)
        } else {
            var parameters = action.eventParameters
            parameters["ga913_action_name"] = action.eventName
            Analytics.logEvent(AnalyticsEventSelectContent, parameters: parameters)
        }
    }
}
