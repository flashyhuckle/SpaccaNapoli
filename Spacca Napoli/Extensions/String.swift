import Foundation

extension String {
    var isValidName: Bool {
        let nameFormat = "[A-Z a-z]{3,50}"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameFormat)
        return namePredicate.evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }

    var isValidPhoneNumber: Bool {
        let phoneNumberFormat = "^\\d{3} \\d{3} \\d{3}$"
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberFormat)
        return numberPredicate.evaluate(with: self)
    }
    
    func formatPhoneNumber() -> String {
        let cleanNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let mask = "XXX XXX XXX"
        
        var result = ""
        var startIndex = cleanNumber.startIndex
        let endIndex = cleanNumber.endIndex
        
        for char in mask where startIndex < endIndex {
            if char == "X" {
                result.append(cleanNumber[startIndex])
                startIndex = cleanNumber.index(after: startIndex)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
}
