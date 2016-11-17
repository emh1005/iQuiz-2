//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by studentuser on 11/16/16.
//  Copyright © 2016 emh. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var correct: UILabel!
    
    let defaults = UserDefaults.standard
    
    private var counts = AnswerViewController.getCount()
    
    private static func getCount() -> Int {
        let counts = UserDefaults.standard.integer(forKey: "count")
        //NSLog ("c\(counts)")
        return counts as Int
    }
    
    private var answer = AnswerViewController.getAnswer()
    
    private static func getAnswer() -> Int {
        let answer = UserDefaults.standard.integer(forKey: "answer")
       // NSLog ("a\(answer)")
        return answer as Int
    }
    
    private var rights = AnswerViewController.getRights()
    
    private static func getRights() -> Int {
        let rights = UserDefaults.standard.integer(forKey: "right")
        //NSLog ("right\(rights)")
        return rights as Int
    }

    func configureView() {
        // Update the user interface for the detail item.
        //if self.detailItem != nil {
            if let label = self.questionLabel {
                label.text = questionItem[counts]?.description
            }
            if let label = self.answerLabel {
                let i: Int = Int(answerItem[counts][4]!)! - 1
                label.text = answerItem[counts][i]?.description
            }
        //}
        /*if let question = self.questionItem[0] {
         if let label = self.detailDescriptionLabel {
         label.text = question.description
         }
         }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
       /* self.questionText.text = commonViewController.questions[counts]
        self.answerText.text = commonViewController.answers[counts][answer - 1]*/
        if String(answer) == answerItem[counts][4] {
            self.correct.text = "RIGHT!!!!"
            self.correct.textColor = UIColor.green
            rights += 1
            defaults.set(rights, forKey: "right")
        } else {
            self.correct.text = "Wrong :("
            self.correct.textColor = UIColor.red
        }
        counts += 1
        defaults.set(counts, forKey: "count")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    var detailItem: String? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    var questionItem: [String?] = [] {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    var answerItem: Array<Array<String?>> = [[]] {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuestion" {
            //if let indexPath = self.tableView.indexPathForSelectedRow {
            //let object = subjectDesc[indexPath.row]
            let question = questionItem
            let answer = answerItem
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            //controller.detailItem = object
            controller.questionItem = question
            controller.answerItem = answer
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = false
        }
    }
}
