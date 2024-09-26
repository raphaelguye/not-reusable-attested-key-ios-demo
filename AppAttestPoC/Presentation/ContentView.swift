import SwiftUI

// MARK: - ContentView

struct ContentView: View {
  var body: some View {
    VStack(spacing: 20) {
      Button("1. Generate an Attested Key") {
        viewModel.generateKeyAndAttestation()
      }
      Button("2. Generate an Assertion") {
        viewModel.signChallenge()
      }
      Button("3. Reused manually the Attested Key") {
        viewModel.getKeyPair()
      }
    }
    .padding()
  }

  private let viewModel = ContentViewModel()
}
