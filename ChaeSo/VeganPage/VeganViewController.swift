import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Lottie

class VeganViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var veganViewModel: VeganViewModel!
    
    
    init(veganViewModel: VeganViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.veganViewModel = veganViewModel
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
