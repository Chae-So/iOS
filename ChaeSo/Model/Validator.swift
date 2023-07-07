//
//  Validator.swift
//  ChaeSo
//
//  Created by 박중선 on 2023/06/29.
//

import Foundation

class Validator{
    
    func validateId(_ id: String) -> Bool {
        let idRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]*$"
        let idPredicate = NSPredicate(format: "SELF MATCHES %@", idRegex)
        return idPredicate.evaluate(with: id)
    }
    
    func validateLengthId(_ id: String) -> Bool {
        return id.count >= 5 && id.count <= 12
    }
    
    func validatePassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&^])[A-Za-z\\d@$!%*#?&^]*$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func validateLengthPassword(_ password: String) -> Bool {
        return password.count >= 8 && password.count <= 15
    }
    
}
