//
//  CallKitApproach.swift
//  Agora-1-1-Call-Interuptions
//
//  Created by shaun on 1/3/23.
//

import CallKit
import SwiftUI

struct CallKitApproachView: View {
    @StateObject private var callHandler = CallHandler()
    
    
    var body: some View {
        OneToOneView()
            .onAppear {
                logger.info("Starting CX Call Handler")
                callHandler.startCall()
                logger.info("Started CX Call Handler")
                
            }
            .onDisappear {
                logger.info("Stoping CX Call Handler")
                callHandler.stopCall()
                logger.info("Stop CX Call Handler")
            }
    }
}

struct CallKitApproach_Previews: PreviewProvider {
    static var previews: some View {
        CallKitApproachView()
    }
}

private class CallHandler: NSObject, CXProviderDelegate, ObservableObject {
    func providerDidReset(_ provider: CXProvider) {
        logger.info("Provider did reset \(provider)")
    }
    private let callUUID = UUID()
    
    let cxController = CXCallController()
    
    func startCall() {
        let cxHandle = CXHandle(type: .generic, value: callUUID.uuidString)
        
        let startCallAction = CXStartCallAction(call: callUUID, handle: cxHandle)
        
        startCallAction.isVideo = true
        
        performCXTransaction(action: startCallAction)
    }
    
    
    func stopCall() {
        let endAction = CXEndCallAction(call: callUUID)
        self.performCXTransaction(action: endAction)
        
    }
    
    private func performCXTransaction(action: CXCallAction) {
        let transaction = CXTransaction(action: action)
        cxController.request(transaction) { error in
            if let error = error {
                logger.error("Error doing transaction \(error.localizedDescription)")
            }
        }
    }
    
}

private func createCallkitConfig() -> CXProviderConfiguration {
    let config = CXProviderConfiguration()
    config.supportsVideo = true
    config.includesCallsInRecents = false
    config.supportedHandleTypes = [.generic]
    return config
}
