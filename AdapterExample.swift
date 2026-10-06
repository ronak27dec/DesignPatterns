//
//  AdapterExample.swift
//  DesignPatterns
//
//  Created by Ronak Malick on 30/12/25.
//

import SwiftUI

protocol AnalyticsTracker {
    func trackEvent(name: String, attribute: [String: String])
}

class FirebaseAnalyticsTracker {
    func logEvent(eventName: String, parameter: [String: String]) {
        print(eventName, parameter)
    }
}

class MixPanelAnalyticsTrackerLogger {
    func logMixpanelEventsWithName(_ eventName: String, parameter: [String: String]) {
        print(eventName, parameter)
    }
}

class MixPanelAnalyticsAdapter: AnalyticsTracker {
    let mixpanel: MixPanelAnalyticsTrackerLogger
    
    init(mixpanel: MixPanelAnalyticsTrackerLogger) {
        self.mixpanel = mixpanel
    }
    
    func trackEvent(name: String, attribute: [String: String]) {
        mixpanel.logMixpanelEventsWithName(name, parameter: attribute)
    }
}

class FirebaseAnalyticsAdapter: AnalyticsTracker {
    let firebase: FirebaseAnalyticsTracker
    
    init(firebase: FirebaseAnalyticsTracker) {
        self.firebase = firebase
    }
    
    func trackEvent(name: String, attribute: [String: String]) {
        firebase.logEvent(eventName: name, parameter: attribute)
    }
}

class One: AnalyticsTracker {
    let tracker: AnalyticsTracker
    
    init(tracker: AnalyticsTracker) {
        self.tracker = tracker
    }
    func trackEvent(name: String, attribute: [String: String]) {
        tracker.trackEvent(name: name, attribute: attribute)
    }
}

class Two: AnalyticsTracker {
    func trackEvent(name: String, attribute: [String: String]) {
        
    }
}

struct AdapterExample: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AdapterExample()
}
