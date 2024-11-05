//
//  MainView.swift
//  Wake Me
//
//  Created by Changjin Ha on 11/4/24.
//

import SwiftUI
import Neumorphic

struct MainView: View {
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            AlarmsView_iPhone()
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            NavigationSplitView(sidebar: {
                AlarmsView_iPhone()
            }, detail: {
                EmptyView()
            })
        }
    }
}

#Preview {
    MainView()
}
