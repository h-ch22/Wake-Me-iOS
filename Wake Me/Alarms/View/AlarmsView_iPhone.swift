//
//  AlarmsView_iPhone.swift
//  Wake Me
//
//  Created by Changjin Ha on 11/4/24.
//

import SwiftUI
import Neumorphic

struct AlarmsView_iPhone: View {
    @StateObject private var helper = AlarmHelper()
    @State private var showSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.Neumorphic.main.ignoresSafeArea(.all, edges: [.top, .bottom])
                
                if helper.alarms.isEmpty {
                    VStack {
                        Spacer()
                        
                        Text("There is no alarm yet.")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.Neumorphic.secondary)
                        
                        Spacer()
                    }.padding(20)
                } else {
                    ScrollView {
                        VStack {
                            
                        }.padding(20)
                    }
                }
            }
            .navigationTitle(Text("Wake Me!"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(action: {
                        showSheet = true
                    }){
                        Image(systemName: "plus")
                    }
                })
            }
            .sheet(isPresented: $showSheet, content: {
                AddAlarmView(showDismiss: true)
                    .environmentObject(helper)
            })
        }
    }
}

#Preview {
    AlarmsView_iPhone()
}
