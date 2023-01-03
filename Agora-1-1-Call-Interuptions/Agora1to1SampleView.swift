//
//  Agora1to1SampleView.swift
//  Agora-1-1-Call-Interuptions
//
//  Created by shaun on 1/3/23.
//

/// Note all of the following code is not endoresed for use in production, this is specifically for sample purposes only.

import SwiftUI
import AgoraUIKit

struct OneToOneView: View {
    @State private var connectedToChannel = false

    static var agview = AgoraViewer(
        connectionData: AgoraConnectionData(
            appId: API.agoraAppID,
            rtcToken: .none
        ),
        style: .floating
    )

    @State private var agoraViewerStyle = 0
    var body: some View {
        ZStack {
            OneToOneView.agview
            VStack {
                Picker("Format", selection: $agoraViewerStyle) {
                    Text("Floating").tag(0)
                    Text("Grid").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                .frame(
                    minWidth: 0, idealWidth: 100, maxWidth: 200,
                    minHeight: 0, idealHeight: 40, maxHeight: .infinity, alignment: .topTrailing
                ).onChange(
                    of: agoraViewerStyle,
                    perform: {
                        OneToOneView.agview.viewer.style = $0 == 0 ? .floating : .grid
                    }
                )
                Spacer()
                HStack {
                    Spacer()
                    Button(
                        action: { connectToAgora() },
                        label: {
                            if connectedToChannel {
                                Text("Disconnect").padding(3.0).background(Color.red).cornerRadius(3.0).hidden()
                            } else {
                                Text("Connect").padding(3.0).background(Color.green).cornerRadius(3.0)
                            }
                        }
                    )
                    Spacer()
                }
                Spacer()
            }
        }

    }

    func connectToAgora() {
        connectedToChannel.toggle()
        if connectedToChannel {
            OneToOneView.agview.join(channel: "test", with: nil, as: .broadcaster)
        } else {
            OneToOneView.agview.viewer.leaveChannel()
        }
    }
}

struct OneToOneView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
