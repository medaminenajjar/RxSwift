
import UIKit
import RxSwift

class MasterViewController: UIViewController { //, CharacterDelegate {

    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var searchCityName: UITextField!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let names = Variable(["Amine"])
        
        names.asObservable()
            .filter({ (value) in
                return value.count > 1
            })
            //.debug()
            .map({ (value) in
                return "Users : \(value)"
            })
            
            .subscribe { (value) in
                print("\(value)")
        }
        names.value = ["Hello","Med","Amine","Najjar"]
        names.value = ["Amine","Najjar"]
        names.value = ["Najjar"]

        
    }
    
    
    @IBAction func selectCharacter(_ sender: Any) {
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        //detailVC.delegate = self
        
        detailVC.selectedCharacter
            .filter({ (value) in
                return value.count > 3
            })
            .subscribe(onNext: { [weak self] character in
            self?.greetingsLabel.text = "Hello \(character)"
        }).disposed(by: disposeBag)
       
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    /*
    func didSelectCharacter(_ name: String) {
        self.greetingsLabel.text = "Hello \(name)"
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

