//
//  AudioSessionApproachView.swift
//  Agora-1-1-Call-Interuptions
//
//  Created by shaun on 1/3/23.
//

import SwiftUI
import OSLog
import AVFoundation

struct AudioSessionApproachView: View {
    var body: some View {
        OneToOneView()
            .onAppear {
                logger.info("Changing AVSession preferences")
                let session = AVAudioSession.sharedInstance()
                do {
                    try session.setPrefersNoInterruptionsFromSystemAlerts(true)
                    try session.setCategory(.playAndRecord, options: [.overrideMutedMicrophoneInterruption])
                    try session.setActive(true, options: [.notifyOthersOnDeactivation])
                } catch {
                    logger.error("Failed to change AVSession preferences, \(error.localizedDescription)")
                    return
                }
                logger.info("Successfully changed AVSession preferences")
            
        }
        .onDisappear {
            logger.info("set av session as inactive")
            do {
                try AVAudioSession.sharedInstance().setActive(false)
            } catch {
                logger.error("Failed to change AVSession to inactive, \(error.localizedDescription)")
                return
            }
            logger.info("Successfully changed AVSession to inactive")
        
        }
    }
}

struct AudioSessionApproachView_Previews: PreviewProvider {
    static var previews: some View {
        AudioSessionApproachView()
    }
}
