import Foundation

struct KeyManagerHelper {

  func getKeyPair(for keyId: String) -> KeyPair? {
    let privateKeyQuery: [String: Any] = [
      kSecClass as String: kSecClassKey,
      kSecAttrApplicationTag as String: keyId.data(using: .utf8)!,
      kSecReturnRef as String: true,
      kSecAttrKeyType as String: kSecAttrKeyTypeECSECPrimeRandom,
//      kSecAttrKeyClass as String: kSecAttrKeyClassPrivate,
    ]

    var item: CFTypeRef?
    let status = SecItemCopyMatching(privateKeyQuery as CFDictionary, &item)

    guard status == errSecSuccess else {
      print("Private key not found: \(Int(status))")
      return nil
    }
    let privateKey = item as! SecKey

    guard let publicKey = SecKeyCopyPublicKey(privateKey) else {
      print("Error retrieving the public key from the private key.")
      return nil
    }

    return (privateKey, publicKey)
  }

}
