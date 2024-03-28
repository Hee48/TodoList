
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mytableView: UITableView!
    
    struct Todo {
        var id: Int
        var title: String
        var iscomplete: Bool
    }
    
    let todoArray = ["title1", "title2" ,"title3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        mytableView.dataSource = self
        mytableView.delegate = self
    }


}

//가독성을 위해 확장해야한다
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = todoArray[indexPath.row]
        return cell
    }
}
