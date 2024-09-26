import Foundation

// MARK: - ContentViewModel

class ContentViewModel {

  // MARK: Internal

  func generateKeyAndAttestation() {
    appAttestHelper.generateKeyAndAttestation { [weak self] keyId, attestation, error in
      if let error {
        print("❌ Attested Key not generated: \(error)")
        return
      }

      guard let keyId else { return }
      print("✅ Attested Key generated: \(keyId)")
      self?.keyId = keyId
    }
  }

  func signChallenge() {
    guard let keyId else {
      print("error: generate a key first")
      return
    }

    let challengeData = "back-end-challenge".data(using: .utf8)!
    appAttestHelper.signChallenge(with: keyId, challenge: challengeData) { signature, error in
      if let error {
        print("❌ Assertion not generated: \(error)")
        return
      }

      guard let signature else { return }
      print("✅ Assertion generated: \(signature.base64EncodedString())")
    }
  }

  func getKeyPair() {
    guard let keyId else {
      print("error: generate a key first")
      return
    }
    guard let keyPair = keyManagerHelper.getKeyPair(for: keyId) else {
      print("❌ Attested Key not reusable manually...")
      return
    }
    print("✅ Attested key reusable manually")
    print("privateKey: \(keyPair.privateKey)")
    print("publicKey: \(keyPair.publicKey)")
  }

  // MARK: Private

  private var keyId: String?
  private let appAttestHelper = AppAttestHelper()
  private let keyManagerHelper = KeyManagerHelper()

}
