//
//  TutorialView.swift
//  Wake Me
//
//  Created by Changjin Ha on 11/4/24.
//

import SwiftUI
import Neumorphic

struct TutorialView: View {
    @State private var currentIdx = 0
    
    @State private var images = [
        "ic_main", "ic_notification", "ic_math", "ic_camera", "ic_check"
    ]
    
    @State private var titles = [
        "Welcome!", "Please turn on notification", "Wake up with math calculations", "Or, take a picture!", "Let's start!"
    ]
    
    @State private var descriptions = [
        "Hello, welcome to Wake Me!", "Notification Permission is required to sound an alarm.", "Wake up and clear your head by solving math problems in the morning!", "You can also wake up by taking a photo of the same location as the photo you registered in advance!\nOf course, you can set both!", "Now that everything is ready, let's get started!"
    ]
    
    @State private var showMainView = false
    
    var body: some View {
        ZStack {
            Color.Neumorphic.main.ignoresSafeArea(.all, edges: [.top, .bottom])
            
            VStack {
                Spacer()
                
                Image(images[currentIdx])
                    .resizable()
                    .frame(width: 150, height: 150)
                
                Text(titles[currentIdx])
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.Neumorphic.secondary)
                
                Text(descriptions[currentIdx])
                    .font(.caption)
                    .foregroundStyle(Color.gray)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                HStack {
                    if currentIdx > 0 && currentIdx < 4 {
                        Button(action: {
                            currentIdx -= 1
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.caption)
                        }
                        .softButtonStyle(Circle())
                        
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if currentIdx < 4 {
                            currentIdx += 1
                        } else {
                            showMainView = true
                        }
                    }) {
                        Image(systemName: currentIdx == 4 ? "checkmark" : "arrow.right")
                            .font(.title)
                            .padding(10)
                    }
                    .softButtonStyle(
                        Circle(),
                        mainColor: currentIdx == 4 ? Color.accentColor : Color.Neumorphic.main,
                        textColor: currentIdx == 4 ? Color.white : Color.Neumorphic.secondary,
                        darkShadowColor: currentIdx == 4 ? Color("DarkShadow") : Color.Neumorphic.darkShadow,
                        lightShadowColor: currentIdx == 4 ? Color("LightShadow") : Color.Neumorphic.lightShadow
                    )
                    
                    Spacer()

                }
                

            }.padding(20)
                .fullScreenCover(isPresented: $showMainView, content: {
                    MainView()
                })
        }
    }
}

#Preview {
    TutorialView()
}
