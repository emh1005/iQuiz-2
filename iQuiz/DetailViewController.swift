//
//  DetailViewController.swift
//  iQuiz
//
//  Created by studentuser on 11/15/16.
//  Copyright © 2016 emh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet var answerGroup: [UIButton]!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var submitButton: UIBarButtonItem!
    
    let defaults = UserDefaults.standard
    
    private var counts = DetailViewController.getCount()
    private static func getCount() -> Int {
        let counts = UserDefaults.standard.integer(forKey: "count")
        return counts as Int
    }
    
    private var answerGiven = DetailViewController.getAnswerGiven()
    private static func getAnswerGiven() -> Int {
        let answer = UserDefaults.standard.integer(forKey: "answerGiven")
        return answer as Int
    }
    
    private var rights = DetailViewController.getRights()
    private static func getRights() -> Int {
        let rights = UserDefaults.standard.integer(forKey: "right")
        return rights as Int
    }
    
    var questionsText = [[String]]()
    private static func getQuestion() -> [[String]] {
        let text = UserDefaults.standard.array(forKey: "texts")
        if text == nil {
            return Array()
        } else {
            return text! as! [[String]]
        }
    }
    
    var answer = [String]()
    private static func getAnswer() -> [String] {
        let answer = UserDefaults.standard.array(forKey: "answer")
        if answer == nil {
            return Array()
        } else {
            return answer! as! [String]
        }
    }
    
    var answers = [[[String]]]()
    private static func getAnswers() -> [[[String]]] {
        let answers = UserDefaults.standard.array(forKey: "answers")
        if answers == nil {
            return Array()
        } else {
            return answers! as! [[[String]]]
        }
    }
    
    
    @IBAction func answerPressed(_ sender: UIButton) {
        for i in 0...3 {
            if sender == answerGroup[i] {
                sender.isEnabled = true
                answerGiven = i + 1
                defaults.set(answerGiven, forKey: "answerGiven")
            } else {
                answerGroup[i].isEnabled = false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if self.detailItem != nil {
            NSLog("\(counts)")
        if counts < questionItem.count {
            if let label = self.detailDescriptionLabel {
                label.text = questionItem[counts]?.description
                for i in 0...3 {
                    self.answerGroup[i].setTitle(answerItem[counts][i], for: .normal)
                }
            }
        } else {
            //NSLog("no")
            switch rights {
                case 0: self.detailDescriptionLabel.text = "AWW :( \(rights) out of \(counts)"
                case 1: self.detailDescriptionLabel.text = "Need more work! \(rights) out of \(counts)"
                case 2: self.detailDescriptionLabel.text = "Getting there! \(rights) out of \(counts)"
                case 3: self.detailDescriptionLabel.text = "Almost! \(rights) out of \(counts)"
                default: self.detailDescriptionLabel.text = "Awesome! \(rights) out of \(counts)"
                
            }
            for i in 0...3 {
                self.answerGroup[i].isHidden = true
            }
            self.submitButton.title = nil
            self.submitButton.isEnabled = false
        }
        }
    }
    
    /*func segueToResults() {
        performSegue(withIdentifier: "showResults", sender: self)
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: String?
        {
        didSet {
            // Update the view.
            //self.configureView()
        }
    }
    
    var questionItem: [String?] = []
        /*{
        didSet {
            // Update the view.
            self.configureView()
        }
    }*/
    
    var answerItem: Array<Array<String?>> = [[]]
    
    var correctItem: [String?] = []
        /*{
        didSet {
            // Update the view.
            self.configureView()
        }
    }*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAnswer" {
    //if let indexPath = self.tableView.indexPathForSelectedRow {
    //let object = subjectDesc[indexPath.row]
            let question = questionItem
            let answer = answerItem
            let object = detailItem
            let correct = correctItem
            let controller = (segue.destination) as! AnswerViewController
            controller.detailItem = object
            controller.questionItem = question
            controller.answerItem = answer
            controller.correctItem = correct
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = false
        }
    }
}

