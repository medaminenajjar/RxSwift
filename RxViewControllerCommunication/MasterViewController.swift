
import UIKit
import RxSwift
import RxCocoa



class TableViewViewModel {
    
    // MARK: Private properties
    private let privateDataSource: Variable<[String]> = Variable([])
    private let disposeBag = DisposeBag()
    
    // MARK: Outputs
    public let dataSource: Observable<[String]>
    
    init(addItemTap: Driver<Void>) {
        self.dataSource = privateDataSource.asObservable()
        
        addItemTap.drive(onNext: { [unowned self] _ in
            self.privateDataSource.value.append("Item")
        })
            .disposed(by: disposeBag)
    }
}



class MasterViewController: UIViewController { //, CharacterDelegate {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    private var viewModel: TableViewViewModel!
    private let cellIdentifier = "Cell"

    let disposeBag = DisposeBag()
    
    
    
    private func setupViewModel() {
        self.viewModel = TableViewViewModel(addItemTap: addButton.rx.tap.asDriver())
    }
    
    private func setupTableView() {
        
        //This is necessary since the UITableViewController automatically set his tableview delegate and dataSource to self
        tableView.delegate = nil
        tableView.dataSource = nil
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func setupTableViewBinding() {
        
        viewModel.dataSource
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: UITableViewCell.self)) {  row, element, cell in
                cell.textLabel?.text = "\(element) \(row)"
            }
            .disposed(by: disposeBag)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        
        
        
        
        
        
        
        
        /**     Demo 0    **/
        
        let names = Variable(["Amine"])
        
        names.asObservable()
            .filter({ (value) in
                return value.count > 1
            })
            //.debug()
            .map({ (value) in
                return "Users : \(value)"
            })
            .subscribe(onNext:  { [weak self] (value) in
                print("\(value)")
        })
        names.value = ["Hello","Med","Amine","Najjar"]
        names.value = ["Amine","Najjar"]
        names.value = ["Najjar"]
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        /**     Demo 1    **/

        search.isHidden = true
        label.isHidden = true
        
        search.rx.text
            .map { "Hello \($0!)" }
            .bind(to: label.rx.text)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        /**     Demo 2    **/
        
        greetingsLabel.isHidden = true
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        /**     Demo 3    **/
        addButton.isHidden = true
        tableView.isHidden = true
        setupViewModel()
        setupTableView()
        setupTableViewBinding()
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    @IBAction func selectCharacter(_ sender: Any) {
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        //detailVC.delegate = self
        
        detailVC.selectedCharacter
            .filter({ (value) in
                return value.count > 3
            })
            .map({ (value) in
                return "Hello \(value)"
            })
            .subscribe(onNext: { [weak self] character in
            self?.greetingsLabel.text = "\(character)"
        })
            .disposed(by: disposeBag)
       
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

