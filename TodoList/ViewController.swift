
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mytableView: UITableView!
    
    struct Todo {
        var id: Int
        var title: String
        var iscomplete: Bool
    }
    
    var todoArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mytableView.dataSource = self
        mytableView.delegate = self
    }
}

//가독성을 위해 확장해야한다 필수메소드 두가지 구현해야함
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = todoArray[indexPath.row]
        let mySwitch = UISwitch()
        mySwitch.addTarget(self, action: #selector(switchbutton(_:)), for: .valueChanged)
        cell.accessoryView = mySwitch
        return cell
    }
    //스위치와 취소선이 같이 움직이게 해야함
    @objc func switchbutton(_ sender: UISwitch) {
        guard let cell = sender.superview as? UITableViewCell else { return }
        guard let indexPath = mytableView.indexPath(for: cell) else { return }
        if sender.isOn {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: todoArray[indexPath.row])
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
            cell.textLabel?.attributedText = attributeString
        } else {
            cell.textLabel?.attributedText = NSAttributedString(string: todoArray[indexPath.row])
        }
    }
    //알럿창 팝업 부분
    @IBAction func alertpopup () {
        let alert = UIAlertController(title: "할 일 추가", message: nil, preferredStyle: .alert)
        let add = UIAlertAction(title: "추가", style: .default) { textfield in
            let textfield = alert.textFields?[0].text
            //텍스트 필드에 입력한 값을 todoarry에 추가하는 부분
            self.todoArray.append(textfield!)
            //다시 테이블뷰를 그리는것 테이블뷰에 반영되게끔 하는거
            self.mytableView.reloadData()
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        
        alert.addAction(cancel)
        alert.addAction(add)
        alert.addTextField{ textfield in textfield.placeholder = "할 일을 입력하세요"}
        //alert창 띄우는값
        present(alert, animated: true)
    }
}
