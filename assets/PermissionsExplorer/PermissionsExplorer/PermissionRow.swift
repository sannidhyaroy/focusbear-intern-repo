//
//  PermissionRow.swift
//  PermissionsExplorer
//
//  Created by Sannidhya Roy on 05/06/26.
//

import AVFoundation
import SwiftUI

struct PermissionRow: View {
    let title: String
    let systemImage: String
    let status: AVAuthorizationStatus
    let onRequest: () -> Void
    
    var statusText: String {
        switch status {
        case .authorized: return "Authorized"
        case .denied: return "Denied"
        case .restricted: return "Restricted"
        case .notDetermined: return "Not Determined"
        @unknown default: return "Unknown"
        }
    }
    
    var statusColor: Color {
        switch status {
        case .notDetermined: return .secondary
        case .restricted: return .orange
        case .denied: return .red
        case .authorized: return .green
        @unknown default: return .secondary
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: systemImage)
                .font(.title2)
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.medium)
                Text(statusText)
                    .font(.caption)
                    .foregroundStyle(statusColor)
            }
            
            Spacer()
            
            Button("Request Access") {
                onRequest()
            }
            .disabled(status == .authorized || status == .denied)
        }
        .padding()
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    PermissionRow(title: "Camera", systemImage: "camera.fill", status: AVCaptureDevice.authorizationStatus(for: .video)) {
        DispatchQueue.main.async {
            print("Camera Permission Tapped")
        }
    }
}
