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
    @IBOutlet weak var submit: UIButton!
    
    let defaults = UserDefaults.standard
    
    private var counts = DetailViewController.getCount()
    
    private static func getCount() -> Int {
        let counts = UserDefaults.standard.integer(forKey: "count")
        return counts as Int
    }
    
    private var answer = DetailViewController.getAnswer()
    
    private static func getAnswer() -> Int {
        let answer = UserDefaults.standard.integer(forKey: "answer")
        return answer as Int
    }
    
    private var rights = DetailViewController.getRights()
    
    private static func getRights() -> Int {
        let rights = UserDefaults.standard.integer(forKey: "right")
        return rights as Int
    }
        
        

            //nextButton[1].isEnabled = false
            //nextButton[1].isHidden = true
            /*self.questionText.text = commonViewController.questions[counts]
            for i in 0...3 {
                self.answersGroup[i].setTitle(commonViewController.answers[counts][i], for: .normal)
            }
        } else {
            switch rights {
            case 0: questionText.text = "AWW :( \(rights) out of \(commonViewController.questions.count)"
            case 1: self.questionText.text = "Need more work! \(rights) out of \(commonViewController.questions.count)"
            case 2: questionText.text = "Getting there! \(rights) out of \(commonViewController.questions.count)"
            case 3: questionText.text = "Almost! \(rights) out of \(commonViewController.questions.count)"
            default: questionText.text = "Awesome! \(rights) out of \(commonViewController.questions.count)"
                
            }
            for i in 0...3 {
                //answersGroup[i].isEnabled = false
                answersGroup[i].isHidden = true
            }
            nextButton[0].isEnabled = false
            nextButton[0].isHidden = true
            nextButton[1].isEnabled = true
            nextButton[1].isHidden = false
        }
        */
    
    @IBAction func answerPressed(_ sender: UIButton) {
        for i in 0...3 {
            if sender == answerGroup[i] {
                sender.isEnabled = true
                answer = i + 1
                defaults.set(answer, forKey: "answer")
            } else {
                answerGroup[i].isEnabled = false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        self.button.isHidden = true
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        //if self.detailItem != nil {
        if counts < questionItem.count {
            NSLog("\(questionItem.count)")
            if let label = self.detailDescriptionLabel {
                label.text = questionItem[counts]?.description
                for i in 0...3 {
                    self.answerGroup[i].setTitle(answerItem[counts][i], for: .normal)
                }
                // }
            }
        } else {
            NSLog("no")
            //self.segueToResults()
            
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
    
    /*func segueToResults() {
        performSegue(withIdentifier: "showResults", sender: self)
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: String?
        /*{
        didSet {
            // Update the view.
            self.configureView()
        }
    }*/
    
    var questionItem: [String?] = []
        /*{
        didSet {
            // Update the view.
            self.configureView()
        }
    }*/
    
    var answerItem: Array<Array<String?>> = [[]]
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
    let controller = (segue.destination) as! AnswerViewController
    //controller.detailItem = object
    controller.questionItem = question
    controller.answerItem = answer
    controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
    controller.navigationItem.leftItemsSupplementBackButton = false
    }
    }
}

