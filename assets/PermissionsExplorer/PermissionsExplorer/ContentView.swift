//
//  ContentView.swift
//  PermissionsExplorer
//
//  Created by Sannidhya Roy on 05/06/26.
//

import AVFoundation
import SwiftUI

struct ContentView: View {
    @State private var cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)
    @State private var micStatus = AVCaptureDevice.authorizationStatus(for: .audio)
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "checkmark.seal.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Let's set up some Permissions!")
                .font(.title)
                .fontWeight(.semibold)
            
            PermissionRow(title: "Camera", systemImage: "camera.fill", status: cameraStatus) {
                AVCaptureDevice.requestAccess(for: .video) { _ in
                    DispatchQueue.main.async {
                        cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)
                    }
                }
            }
            PermissionRow(title: "Microphone", systemImage: "mic.fill", status: micStatus) {
                AVCaptureDevice.requestAccess(for: .audio) { _ in
                    DispatchQueue.main.async {
                        micStatus = AVCaptureDevice.authorizationStatus(for: .audio)
                    }
                }
            }
        }
        .padding(32)
        .frame(minWidth: 420, minHeight: 240)
    }
}

#Preview {
    ContentView()
}
