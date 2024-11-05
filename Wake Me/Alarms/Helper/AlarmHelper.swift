//
//  AlarmHelper.swift
//  Wake Me
//
//  Created by Changjin Ha on 11/4/24.
//

import Foundation
import AVFoundation

class AlarmHelper: ObservableObject {
    @Published var alarms = [AlarmDataModel]()
    @Published var isRecording = false
    
    private let recordingSession = AVAudioSession.sharedInstance()
    
    static func convertDayOfWeekCodeAsString(code: Int) -> String {
        switch code {
        case 1: return "S"
        case 2: return "M"
        case 3: return "T"
        case 4: return "W"
        case 5: return "T"
        case 6: return "F"
        case 7: return "S"
        default: return ""
        }
    }
    
    func record() {
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMddyyyy_kkmmss"
            
            let fileName = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Audio_\(dateFormatter.string(from: Date())).m4a")
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            let audioRecorder = try? AVAudioRecorder(url: fileName, settings: settings)
            
            if isRecording && audioRecorder != nil {
                isRecording = false
                audioRecorder!.stop()
            } else if !self.isRecording && audioRecorder != nil {
                AVAudioApplication.requestRecordPermission(completionHandler: { (isAccepted) in
                    if isAccepted {
                        do {
                            self.isRecording = true
                            
                            try self.recordingSession.setCategory(.playAndRecord)
                            try self.recordingSession.overrideOutputAudioPort(.speaker)

                            audioRecorder!.record()
                            
                        } catch let error {
                            self.isRecording = false
                            print(error.localizedDescription)
                        }
                    }
                })
            }
        }
    }
}
