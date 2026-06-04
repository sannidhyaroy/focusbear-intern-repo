//
//  ContentView.swift
//  UnitTesting
//
//  Created by Sannidhya Roy on 04/06/26.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var age = ""
    @State private var message = ""
    @State private var isValid = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
            TextField("Age", text: $age)
                .textFieldStyle(.roundedBorder)
            Button("Submit") {
                let ageInt = Int(age) ?? 0
                if let error = validateUserInputs(name: name,
                                                  email: email,
                                                  age: ageInt) {
                    message = error
                    isValid = false
                } else {
                    message = "Welcome, \(name)"
                    isValid = true
                }
            }
            if !message.isEmpty {
                Text(message)
                    .foregroundStyle(isValid ? .green : .red)
            }
        }
        .padding()
        .frame(minWidth: 400, minHeight: 300)
    }
}

#Preview {
    ContentView()
}
