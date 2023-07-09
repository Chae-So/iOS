import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NicknameViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var nicknameViewModel: NicknameViewModel!
    
    
    init(nicknameViewModel: NicknameViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.nicknameViewModel = nicknameViewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.hidesBackButton = true
        
        bind()
        attribute()
        layout()
    }
    
    func bind(){
        
    }
    
    func attribute(){
        
    }
    
    func layout(){
        
    }

}
