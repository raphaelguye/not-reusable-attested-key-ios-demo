import DeviceCheck
import Foundation

struct AppAttestHelper {

  func generateKeyAndAttestation(completion: @escaping (String?, String?, Error?) -> Void) {
    DCAppAttestService.shared.generateKey { keyId, error in
      guard let keyId, error == nil else {
        completion(nil, nil, error)
        return
      }

      let someClientDataHash = "abc123".data(using: .utf8)!
      DCAppAttestService.shared.attestKey(keyId, clientDataHash: someClientDataHash) { attestationData, error in
        guard let attestationData, error == nil else {
          completion(nil, nil, error)
          return
        }
        completion(keyId, attestationData.base64EncodedString(), nil)
      }
    }
  }

  func signChallenge(with keyId: String, challenge: Data, completion: @escaping (Data?, Error?) -> Void) {
    DCAppAttestService.shared.generateAssertion(keyId, clientDataHash: challenge) { assertion, error in
      guard let assertion, error == nil else {
        completion(nil, error)
        return
      }
      completion(assertion, nil)
    }
  }

}
