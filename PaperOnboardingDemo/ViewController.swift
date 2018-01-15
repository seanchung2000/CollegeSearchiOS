
import FirebaseAuth
import UIKit

class ViewController: UIViewController {
    
  
  @IBOutlet weak var skipButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    skipButton.isHidden = true

  }
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            showHomePage()
        }
    }
    
    func showHomePage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let HomeVC:HomeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(HomeVC, animated: true, completion: nil)
    }
        
 


}

