//
//  ResultViewController.swift
//  iQuiz
//
//  Created by studentuser on 11/16/16.
//  Copyright © 2016 emh. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var labelText: UILabel!
    
    private var rights = ResultViewController.getRights()
    
    private static func getRights() -> Int {
        let rights = UserDefaults.standard.integer(forKey: "right")
        //NSLog ("right\(rights)")
        return rights as Int
    }
    
    private var counts = ResultViewController.getCount()
    
    private static func getCount() -> Int {
        let counts = UserDefaults.standard.integer(forKey: "count")
        //NSLog ("c\(counts)")
        return counts as Int
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        switch rights {
        case 0: labelText.text = "AWW :( \(rights) out of \(counts)"
        case 1: labelText.text = "Need more work! \(rights) out of \(counts)"
        case 2: labelText.text = "Getting there! \(rights) out of \(counts)"
        case 3: labelText.text = "Almost! \(rights) out of \(counts)"
        default: labelText.text = "Awesome! \(rights) out of \(counts)"
            
        }

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
