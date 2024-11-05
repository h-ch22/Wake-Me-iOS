//
//  AlarmListModel.swift
//  Wake Me
//
//  Created by Changjin Ha on 11/4/24.
//

import SwiftUI
import Neumorphic

struct AlarmListModel: View {
    @State var data: AlarmDataModel
    @State private var dayOfWeeks = [1, 2, 3, 4, 5, 6, 7]
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(data.label == "" ? "Alarm" : data.label)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
                
                Text(data.time)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.Neumorphic.secondary)
                
                if !data.repeatDayOfWeek.isEmpty {
                    HStack {
                        ForEach($dayOfWeeks, id: \.self) { dayOfWeek in
                            Text(AlarmHelper.convertDayOfWeekCodeAsString(code: dayOfWeek.wrappedValue))
                                .fontWeight(data.repeatDayOfWeek.contains(dayOfWeek.wrappedValue) ? .semibold : .regular)
                                .foregroundStyle(data.repeatDayOfWeek.contains(dayOfWeek.wrappedValue) ? Color.accentColor : Color.gray)
                        }
                    }
                }
            }
            
            Spacer()
            
            Toggle(isOn: $data.isOn, label: {
                
            })
            .softSwitchToggleStyle(tint: Color.accentColor)
            
        }
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
        )
    }
}

#Preview {
    AlarmListModel(data:
                    AlarmDataModel(label: "", time: "00:00", repeatDayOfWeek: [1, 2, 3], sound: "", type: .BOTH)
    )
}
