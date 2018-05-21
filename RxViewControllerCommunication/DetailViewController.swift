

import UIKit
import RxSwift

/*protocol CharacterDelegate {
    func didSelectCharacter (_ name:String)
}*/

class DetailViewController: UIViewController {
   
    
    // var delegate:CharacterDelegate?
    
    private let selectedCharacterVariable = Variable("User")
    
    var selectedCharacter:Observable<String> {
        return selectedCharacterVariable.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func characterSelected(_ sender: UIButton) {
        guard let characterName = sender.titleLabel?.text else {return}
        
        selectedCharacterVariable.value = characterName
        
        /*if let delegateObject = delegate {
            delegateObject.didSelectCharacter(characterName)
        }*/
        
    }
    
    
}
