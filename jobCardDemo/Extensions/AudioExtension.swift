//
//  AudioExtension.swift
//  Base Project MVP
//
//  Created by Mohamed Akl on 03/04/2022.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import Foundation
import AVFoundation

class AudioManager: NSObject {
    
    static let shared = AudioManager()
    
    var recordingSession: AVAudioSession?
    var recorder: AVAudioRecorder?
    var meterTimer: Timer?
    var recorderApc0: Float = 0
    var recorderPeak0: Float = 0
    //PLayer
    var player: AVAudioPlayer?
    var savedFileURL: URL?
    var audioDidFinish:(()-> Void)?

    func setup() {
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession?.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)
            try recordingSession?.setActive(true)
            recordingSession?.requestRecordPermission({ (allowed) in
                if allowed {
                    print("Mic Authorised")
                } else {
                    print("Mic not Authorised")
                }
            })
        } catch {
            print("Failed to set Category", error.localizedDescription)
        }
    }
    
    func record(fileName: String) -> Bool {
        setup()
        let url = getUserPath().appendingPathComponent(fileName + ".m4a")
        let audioURL = URL.init(fileURLWithPath: url.path)
        let recordSettings: [String: Any] = [AVFormatIDKey: kAudioFormatMPEG4AAC,
                                             AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
                                             AVNumberOfChannelsKey: 2,
                                             AVSampleRateKey: 44100.0]
        do {
            recorder = try AVAudioRecorder.init(url: audioURL, settings: recordSettings)
            recorder?.delegate = self
            recorder?.isMeteringEnabled = true
            recorder?.prepareToRecord()
            recorder?.record()
            self.meterTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer: Timer) in
                //Update Recording Meter Values so we can track voice loudness
                if let recorder = self.recorder {
                    recorder.updateMeters()
                    self.recorderApc0 = recorder.averagePower(forChannel: 0)
                    self.recorderPeak0 = recorder.peakPower(forChannel: 0)
                }
            })
            savedFileURL = url
            print("Recording")
            return true
        } catch {
            print("Error Handling", error.localizedDescription)
            return false
        }
    }
    
    func getUserPath() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func finishRecording() -> URL? {
        recorder?.stop()
        self.meterTimer?.invalidate()
        let url: URL? = recorder?.url
        return url
    }
    //Player
    func setupPlayer(_ url: URL) {
        print(url.path)
        do {
            try player = AVAudioPlayer.init(contentsOf: url)
        } catch {
            print("Error1", error.localizedDescription)
        }
        player?.prepareToPlay()
        player?.play()
        player?.volume = 20.0
        player?.delegate = self
    }
}
extension AudioManager: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        print("AudioManager Finish Recording")
        audioDidFinish?()
    }
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Encoding Error\(error?.localizedDescription ?? "")")
    }
    
}

extension AudioManager: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer,
                                     successfully flag: Bool) {
        
        player.stop()
        
        print("Finish Playing")
        
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer,
                                        error: Error?) {
        
        print(error?.localizedDescription ?? "")
        
    }
    
}






