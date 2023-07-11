import Foundation

class UserInfo {
    static let shared = UserInfo()
    
    var id: String = ""
    var pw: String = ""
    var nickname: String = ""
    
    private init(){
        
    }
}
