//
//  ContentView.swift
//  NetworkSpeedTesting
//
//  Created by Sudhi on 15/01/25.
//

import SwiftUI

struct ContentView: View {
    @State private var expensiveResult: String = "Expensive Network Access Test Result"
    @State private var nonExpensiveResult: String = "Non-Expensive Network Access Test Result"
    @State private var isLoading: Bool = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25) {
                Text("Network Speed Tester")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 40)
                
                resultCard(title: "Expensive Network Access", result: expensiveResult, color: .blue) {
                    Task { await testNetwork(allowsExpensiveNetworkAccess: true) }
                }
                
                resultCard(title: "Non-Expensive Network Access", result: nonExpensiveResult, color: .red) {
                    Task { await testNetwork(allowsExpensiveNetworkAccess: false) }
                }
                
                if isLoading {
                    ProgressView("Testing...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
                Spacer()
            }
            .padding()
        }
    }
    
    private func resultCard(title: String, result: String, color: Color, action: @escaping () -> Void) -> some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(color)
                .cornerRadius(10)
            
            Text(result)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
                .shadow(radius: 5)
            
            Button(action: action) {
                Text("Test Now")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(color)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        .padding()
        .background(BlurView(style: .systemUltraThinMaterial))
        .cornerRadius(15)
        .shadow(radius: 10)
    }
    
    private func testNetwork(allowsExpensiveNetworkAccess: Bool) async {
        isLoading = true
        let testType = allowsExpensiveNetworkAccess ? "Expensive" : "Non-Expensive"
        
        do {
            let configuration = URLSessionConfiguration.default
            configuration.allowsExpensiveNetworkAccess = allowsExpensiveNetworkAccess
            let session = URLSession(configuration: configuration)
            
            guard let url = URL(string: "https://www.apple.com") else {
                updateResult(for: testType, with: "Invalid URL")
                isLoading = false
                return
            }
            
            let startTime = Date()
            let (_, _) = try await session.data(from: url)
            let duration = Date().timeIntervalSince(startTime)
            
            updateResult(for: testType, with: "Time: \(String(format: "%.2f", duration)) seconds")
        } catch {
            updateResult(for: testType, with: "Error: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    private func updateResult(for testType: String, with result: String) {
        if testType == "Expensive" {
            expensiveResult = result
        } else {
            nonExpensiveResult = result
        }
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#Preview {
    ContentView()
}
