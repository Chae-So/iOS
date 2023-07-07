import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ToSViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var tosViewModel: TosViewModel!
    
    private lazy var imageView = UIImageView()
    private lazy var firstLabel = UILabel()
    private lazy var secondLabel = UILabel()
    
    private lazy var allSelectLabel = UILabel()
    private lazy var serviceTosLabel = UILabel()
    private lazy var infoTosLabel = UILabel()
    
    private lazy var allSelectButton = UIButton()
    private lazy var serviceTosButton = UIButton()
    private lazy var infoTosButton = UIButton()

    init(tosViewModel: TosViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.tosViewModel = tosViewModel
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
        //MARK: 바탕색
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        //MARK: imageView Attribute
        imageView = UIImageView(image: UIImage(named: "tomato"))
        
        //MARK: firstLabel Attribute
        firstLabel.textColor = UIColor.black
        firstLabel.font = UIFont(name: "Pretendard-Bold", size: 24)
        firstLabel.textAlignment = .center
        
        //MARK: secondLabel Attribute
        secondLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        secondLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        secondLabel.textAlignment = .center
        
        //MARK: allSelectLabel Attribute
        allSelectLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        allSelectLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        allSelectLabel.textAlignment = .left
        
        //MARK: serviceTosLabel Attribute
        serviceTosLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        serviceTosLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        serviceTosLabel.textAlignment = .left
        
        //MARK: infoTosLabel Attribute
        infoTosLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        infoTosLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        infoTosLabel.textAlignment = .left
        
        
//        //MARK: tomatoLoginButton Attribute
//        tomatoLoginButton.titleLabel?.textAlignment = .center
//        tomatoLoginButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
//        tomatoLoginButton.setTitleColor(UIColor.black, for: .normal)
//        tomatoLoginButton.layer.cornerRadius = 8
//        tomatoLoginButton.backgroundColor = UIColor.white
//        tomatoLoginButton.setImage(UIImage(named: "tomato"), for: .normal)
        allSelectButton.layer.cornerRadius = 2
        
        
        
        
    }
    
    func layout(){
        
    }

}
