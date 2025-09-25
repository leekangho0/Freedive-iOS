//
//  MainTabView.swift
//  Freedive
//
//  Created by Kanghos on 9/25/25.
//

import SwiftUI

enum MainTab: String, CaseIterable, Identifiable {
    case drill = "Drill"
    case diveLog = "Log"
    case stats = "Stats"
    case profile = "Profile"
    
    var id: String {
        rawValue
    }
    
    var icon: String {
        switch self {
        case .drill: return "timer"
        case .diveLog: return "applepencil.and.scribble"
        case .stats: return "chart.line.uptrend.xyaxis"
        case .profile: return "person.text.rectangle.fill"
        }
    }
}

struct MainTabView: View {
    @State var selection: MainTab = .drill
    var body: some View {
        TabView(selection: $selection) {
            ForEach(MainTab.allCases) { tab in
                Tab(tab.id, systemImage: tab.icon, value: tab) {
                    NavigationStack {
                        makeTab(tab)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func makeTab(_ tab: MainTab) -> some View {
        switch tab {
        case .drill:
            TimerView()
        case .diveLog:
            DiveLogView()
        case .stats:
            StatsView()
        case .profile:
            ProfileView()
        }
    }
}
