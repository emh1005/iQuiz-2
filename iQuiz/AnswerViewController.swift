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
    
    private var answerGiven = AnswerViewController.getAnswerGiven()
    
    private static func getAnswerGiven() -> Int {
        let answer = UserDefaults.standard.integer(forKey: "answerGiven")
       // NSLog ("a\(answer)")
        return answer as Int
    }
    
    private var rights = AnswerViewController.getRights()
    
    private static func getRights() -> Int {
        let rights = UserDefaults.standard.integer(forKey: "right")
        //NSLog ("right\(rights)")
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

    
    

    func configureView() {
        // Update the user interface for the detail item.
        //if self.detailItem != nil {
            if let label = self.questionLabel {
                NSLog("\(questionItem) \(questionItem[counts])")
                label.text = questionItem[counts]?.description
            }
            if let label = self.answerLabel {
                //NSLog("\(correctItem) \(correctItem[counts])")
                let i: Int = Int((correctItem[counts]?.description)!)! - 1
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
        if String(answerGiven) == correctItem[counts] {
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
    
/*
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
     
    }*/
    
    var detailItem: String?
        {
        didSet {
        }
    }
    
    var questionItem: [String?] = []
    
    var answerItem: Array<Array<String?>> = [[]]
    
    var correctItem: [String?] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuestion" {
            //if let indexPath = self.tableView.indexPathForSelectedRow {
            //let object = subjectDesc[indexPath.row]
            let question = questionItem
            let answer = answerItem
            let object = detailItem
            let correct = correctItem
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.detailItem = object
            controller.questionItem = question
            controller.answerItem = answer
            controller.correctItem = correct
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = false
        }
    }
}
