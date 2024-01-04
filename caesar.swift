import Foundation

class Cipher 
{
  func ord(_ character: Character) -> UInt32 
  {
    return character.unicodeScalars.first?.value ?? 0
  }

  func chr(_ codePoint: UInt32) -> Character? 
  {
    return Unicode.Scalar(codePoint).map(Character.init)
  }

  func encrypt(pt: String, key: Int) -> String 
  {
    var ct: String = ""
    let letters = CharacterSet.letters
    let lowerCase = CharacterSet.lowercaseLetters
    for char in pt 
    {
      if letters.contains(char.unicodeScalars.first!) 
      {
        var shift: UInt32 = 0
        if lowerCase.contains(char.unicodeScalars.first!) 
        {
          shift = 97
        } 
        else 
        {
          shift = 65
        }
        if let encryptedChar = chr((ord(char) - shift + UInt32(key)) % 26 + shift) 
        {
          ct += String(encryptedChar)
        }
      } 
      else 
      {
        ct += String(char)
      }
    }
    return ct
  }

  func decrypt(ct: String, key: Int) -> String 
  {
    var pt: String = ""
    let letters = CharacterSet.letters
    let lowerCase = CharacterSet.lowercaseLetters
    for char in ct 
    {
      if letters.contains(char.unicodeScalars.first!) 
      {
        var shift: UInt32 = 0
        if lowerCase.contains(char.unicodeScalars.first!)
        {
          shift = 97
        }
        else
        {
          shift = 65
        }
        if let decryptedChar = chr((ord(char) - shift - UInt32(key)) % 26 + shift)
        {
          pt += String(decryptedChar)
        }
      }
      else
      {
        pt += String(char)
      }
    }
    return pt
  }
}

class Main 
{
    var newCipher: Cipher
    let cryptText: String
    let cryptText2: String

    init() 
    {
      newCipher = Cipher()
      cryptText = "secret message"
      cryptText2 = "qvomrsb vsb"
    }

    func run() -> Void
    {
      let fEncrypt = newCipher.encrypt(pt: cryptText, key: 14)
      print("Output 1: \(fEncrypt)")
      let fDecrypt = newCipher.decrypt(ct: cryptText2, key: 14)
      print("Output 2: \(fDecrypt)")
    }
}

let main = Main()
main.run()
