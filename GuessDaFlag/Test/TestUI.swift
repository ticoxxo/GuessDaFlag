//
//  TestUI.swift
//  GuessDaFlag
//
//  Created by Alberto Almeida on 07/10/23.
//

import SwiftUI

struct TestView: View {
    @State private var showingAlert = false
    var body: some View {
        VStack {
            Button {
                showingAlert = true
            } label: {
                Label("Edit",systemImage:  "pencil")
            }
            .alert("Alerta alerta", isPresented: $showingAlert) {
                Button("Delete", role: .destructive) { }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Please understand")
            }
        }
    }
    
    func executeDelete() {
        print("Deliting")
    }
}

#Preview {
    TestView()
}
