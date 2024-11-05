//
//  AddAlarmView.swift
//  Wake Me
//
//  Created by Changjin Ha on 11/4/24.
//

import SwiftUI
import Neumorphic
import AVFoundation

struct AddAlarmView: View {
    @EnvironmentObject var helper: AlarmHelper
    @Environment(\.dismiss) var dismiss
    
    @State private var time = Date()
    @State private var showProgress = false
    @State private var selectedRepeatDay = [Int]()
    @State private var dayOfWeeks = ["S", "M", "T", "W", "T", "F", "S"]
    @State private var label = ""
    @State private var sound = 0
    @State private var soundList = [
        "Siren (Default)", "Clucking", "Beep", "Record a sound", "Select a sound"
    ]
        
    @State private var alarmTypes = [AlarmTypeModel.MATH, AlarmTypeModel.CAMERA, AlarmTypeModel.BOTH]
    @State private var selectedType = AlarmTypeModel.MATH
    @State private var mathLevel = 3.0
    @State private var questionCount = 4.0
    @State private var showPhotoDialog = false
    
    let showDismiss: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.Neumorphic.main.ignoresSafeArea(.all, edges: [.top, .bottom])
                
                ScrollView {
                    VStack {
                        DatePicker("Please select time to wake you up", selection: $time, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                        
                        HStack {
                            Text("REPEAT")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.gray)
                            
                            Spacer()
                            
                            Button(action: {
                                selectedRepeatDay.removeAll()
                            }) {
                                Text("CLEAR")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.accentColor)
                            }
                        }
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 15) {
                                ForEach(dayOfWeeks.indices, id: \.self) { code in
                                    Button(action: {
                                        if selectedRepeatDay.contains(code + 1) {
                                            let index = selectedRepeatDay.firstIndex(where: { $0 == code + 1 })
                                            
                                            if index != nil {
                                                selectedRepeatDay.remove(at: index!)
                                            }
                                        } else {
                                            selectedRepeatDay.append(code + 1)
                                        }
                                    }) {
                                        Text(dayOfWeeks[code])
                                    }
                                    .softButtonStyle(Circle(),
                                                     mainColor: selectedRepeatDay.contains(code + 1) ? Color.accentColor : Color.Neumorphic.main,
                                                     textColor: selectedRepeatDay.contains(code + 1) ?
                                                     Color.white : Color.Neumorphic.secondary,
                                                     darkShadowColor: selectedRepeatDay.contains(code + 1) ?
                                                     Color("DarkShadow") : Color.Neumorphic.darkShadow,
                                                     lightShadowColor: selectedRepeatDay.contains(code + 1) ?
                                                     Color("LightShadow") : Color.Neumorphic.lightShadow)
                                }
                            }
                            .padding(10)
                        }
                        
                        HStack {
                            Text("LABEL")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.gray)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Image(systemName: "list.bullet.clipboard.fill").foregroundColor(Color.Neumorphic.secondary).font(Font.body.weight(.bold))
                            TextField("Label", text: $label).foregroundColor(Color.Neumorphic.secondary)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 30).fill(Color.Neumorphic.main)
                                .softInnerShadow(RoundedRectangle(cornerRadius: 30), darkShadow: Color.Neumorphic.darkShadow, lightShadow: Color.Neumorphic.lightShadow, spread: 0.05, radius: 2)
                        )
                        
                        Spacer().frame(height: 20)
                        
                        HStack {
                            Text("SOUND")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.gray)
                            
                            Spacer()
                            
                            Picker(selection: $sound, content: {
                                ForEach(soundList.indices, id: \.self) {
                                    Text(soundList[$0])
                                }
                            }, label: {
                                Text("Select an alarm sound")
                            }).pickerStyle(MenuPickerStyle())
                        }
                        
                        if sound == 4 {
                            Button(action: {
                                helper.record()
                            }) {
                                Image(systemName: helper.isRecording ? "stop.circle.fill" : "record.circle.fill")
                            }
                            .softButtonStyle(
                                Circle(),
                                mainColor: helper.isRecording ? Color.accentColor : Color.Neumorphic.main,
                                textColor: helper.isRecording ? Color.white : Color.Neumorphic.secondary,
                                darkShadowColor: helper.isRecording ? Color("DarkShadow") : Color.Neumorphic.darkShadow,
                                lightShadowColor: helper.isRecording ? Color("LightShadow") : Color.Neumorphic.lightShadow
                            )
                        } else if sound == 5 {
                            
                        }
                        
                        Spacer().frame(height: 20)
                        
                        HStack {
                            Text("ALARM TYPE")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.gray)
                            
                            Spacer()
                            
                            Picker(selection: $selectedType, content: {
                                ForEach(alarmTypes, id: \.self) { type in
                                    Text(type.rawValue)
                                }
                            }, label: {
                                Text("Select alarm type")
                            }).pickerStyle(MenuPickerStyle())
                        }
                        
                        if selectedType == .MATH || selectedType == .BOTH {
                            HStack {
                                Text("SELECT QUESTION LEVEL\nCurrent Level: \(mathLevel, specifier: "%.0f")")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.gray)
                                    .multilineTextAlignment(.trailing)
                                
                                Spacer()
                                
                                Slider(value: $mathLevel, in: 1...5, step: 1, label: {
                                    Text("Math Question Level")
                                })
                            }
                            
                            Spacer().frame(height: 20)
                            
                            HStack {
                                Text("SELECT QUESTION COUNT\nCurrent Count: \(questionCount, specifier: "%.0f")")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.gray)
                                    .multilineTextAlignment(.trailing)
                                
                                Spacer()
                                
                                Slider(value: $questionCount, in: 3...5, step: 1, label: {
                                    Text("Math Question Count")
                                })
                            }
                        }
                        
                        if selectedType == .CAMERA || selectedType == .BOTH {
                            Button(action: { showPhotoDialog = true }) {
                                Text("Select Photo")
                            }
                            .softButtonStyle(Capsule())
                        }
                        
                    }.padding(20)
                        .navigationTitle(Text("New Alarm"))
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading, content: {
                                Button("Cancel") {
                                    self.dismiss()
                                }
                            })
                            
                            ToolbarItem(placement: .topBarTrailing, content: {
                                if showProgress {
                                    ProgressView()
                                } else {
                                    Button("Done") {
                                        showProgress = true
                                    }
                                }
                            })
                        }
                        .confirmationDialog("Please select a type to select photo", isPresented: $showPhotoDialog, actions: {
                            Button("Take a photo") {
                                
                            }
                            
                            Button("Select a photo") {
                                
                            }
                        })
                }
            }
        }
    }
}

#Preview {
    AddAlarmView(showDismiss: false)
        .environmentObject(AlarmHelper())
}
