import Foundation
import RxCocoa


class CommentViewModel{
    
    var localizationManager: LocalizationManager
    
    let writeRepliesText = BehaviorRelay<String>(value: "")
    let showRepliesText = BehaviorRelay<String>(value: "")
    
    let comments = BehaviorRelay<[Comment]>(value: [])
    
    
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        
        comments.accept([Comment(user: User(profileImage: UIImage(named: "tomato"), nickname: "111"), content: "dfgkjdnfg", replies: [Reply(user: User(profileImage: UIImage(named: "tomato"), nickname: "222"), content: "fdgnkdfngj"),Reply(user: User(profileImage: UIImage(named: "tomato"), nickname: "111"), content: "fdgnkdfngj")]),Comment(user: User(profileImage: UIImage(named: "tomato"), nickname: "333"), content: "fdkgjnbna", replies: []),Comment(user: User(profileImage: UIImage(named: "tomato"), nickname: "111"), content: "dfgkjdnfg", replies: [Reply(user: User(profileImage: UIImage(named: "tomato"), nickname: "222"), content: "fdgnkdfngj"),Reply(user: User(profileImage: UIImage(named: "tomato"), nickname: "111"), content: "fdgnkdfngj")]),Comment(user: User(profileImage: UIImage(named: "tomato"), nickname: "333"), content: "fdkgjnbna", replies: []),Comment(user: User(profileImage: UIImage(named: "tomato"), nickname: "111"), content: "dfgkjdnfg", replies: [Reply(user: User(profileImage: UIImage(named: "tomato"), nickname: "222"), content: "fdgnkdfngj"),Reply(user: User(profileImage: UIImage(named: "tomato"), nickname: "111"), content: "fdgnkdfngj")]),Comment(user: User(profileImage: UIImage(named: "tomato"), nickname: "333"), content: "fdkgjnbna", replies: []),Comment(user: User(profileImage: UIImage(named: "tomato"), nickname: "111"), content: "dfgkjdnfg", replies: [Reply(user: User(profileImage: UIImage(named: "tomato"), nickname: "222"), content: "fdgnkdfngj"),Reply(user: User(profileImage: UIImage(named: "tomato"), nickname: "111"), content: "fdgnkdfngj")]),Comment(user: User(profileImage: UIImage(named: "tomato"), nickname: "333"), content: "fdkgjnbna", replies: []),Comment(user: User(profileImage: UIImage(named: "tomato"), nickname: "111"), content: "dfgkjdnfg", replies: [Reply(user: User(profileImage: UIImage(named: "tomato"), nickname: "222"), content: "fdgnkdfngj"),Reply(user: User(profileImage: UIImage(named: "tomato"), nickname: "111"), content: "fdgnkdfngj")]),Comment(user: User(profileImage: UIImage(named: "tomato"), nickname: "333"), content: "fdkgjnbna", replies: []),Comment(user: User(profileImage: UIImage(named: "tomato"), nickname: "111"), content: "dfgkjdnfg", replies: [Reply(user: User(profileImage: UIImage(named: "tomato"), nickname: "222"), content: "fdgnkdfngj"),Reply(user: User(profileImage: UIImage(named: "tomato"), nickname: "111"), content: "fdgnkdfngj")]),Comment(user: User(profileImage: UIImage(named: "tomato"), nickname: "333"), content: "fdkgjnbna", replies: []),Comment(user: User(profileImage: UIImage(named: "tomato"), nickname: "111"), content: "dfgkjdnfg", replies: [Reply(user: User(profileImage: UIImage(named: "tomato"), nickname: "222"), content: "fdgnkdfngj"),Reply(user: User(profileImage: UIImage(named: "tomato"), nickname: "111"), content: "fdgnkdfngj")]),Comment(user: User(profileImage: UIImage(named: "tomato"), nickname: "333"), content: "fdkgjnbna", replies: [])])
        
        self.updateLocalization()
    }
    
    private func updateLocalization() {
        writeRepliesText.accept(localizationManager.localizedString(forKey: "replies"))
    }
    
    
    func toggleSection(section: Int) {
        var currentComments = comments.value
        currentComments[section].isExpanded.toggle()
        print(currentComments[section].isExpanded)
        comments.accept(currentComments)
    }
    
    
}
