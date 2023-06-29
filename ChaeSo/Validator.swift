//
//  Validator.swift
//  ChaeSo
//
//  Created by 박중선 on 2023/06/29.
//

import Foundation

class Validator{
    
    func validateId(_ id: String) -> Bool {
        let idRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{5,12}$"
        let idPredicate = NSPredicate(format: "SELF MATCHES %@", idRegex)
        return idPredicate.evaluate(with: id)
    }
    
    func validatePassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,15}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
}
