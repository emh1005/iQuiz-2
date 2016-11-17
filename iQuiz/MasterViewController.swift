//
//  MasterViewController.swift
//  iQuiz
//
//  Created by studentuser on 11/15/16.
//  Copyright © 2016 emh. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [String]()
    var x: Int = 0
    
    var subjectTitle: [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
    var subjectDesc: [String] = ["Questions about math!", "Questions about superheroes!", "Questions about science!"]
    var subjectQuestions: Array<Array<String>> = [["1+1=?", "2*3=?", "10/2=?", "8-3=?"], ["Who is Captain America?"], ["How many bones in a human?", "How many protons in carbon?"]]
    var subjectAnswers: Array<Array<Array<String>>> = [[["1", "2", "3", "4", "2"], ["2", "4", "6", "8", "3"], ["5", "4", "3", "2", "1"], ["2", "3", "4", "5", "4"]],[["Steve Rogers", "Tony Stark", "Bruce Banner", "Clark Kent", "1"]], [["300", "200", "206", "252", "3"], ["8", "6", "12", "4", "2"]]]



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSLog("test")
        let defaults = UserDefaults.standard
        var counts = defaults.integer(forKey: "count")
        counts = 0
        defaults.set(counts, forKey: "count")
        
        var answer = defaults.integer(forKey: "answer")
        answer = 0
        defaults.set(answer, forKey: "answer")
        
        var rights = defaults.integer(forKey: "right")
        rights = 0
        defaults.set(rights, forKey: "right")
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        for _ in 0...subjectTitle.count - 1 {
            self.insertNewObject()
            if self.x < subjectTitle.count {
                self.x += 1
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        //self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject() {
        objects.append(subjectTitle[x])
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" || segue.identifier == "showAnswer" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = subjectDesc[indexPath.row]
                let question = subjectQuestions[indexPath.row]
                let answer = subjectAnswers[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.questionItem = question
                controller.answerItem = answer
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                //controller.navigationItem.leftItemsSupplementBackButton = false

            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectTitle.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let i = indexPath.row
        cell.titleLabel.text = subjectTitle[i]
        cell.descLabel.text = subjectDesc[i]


       // let object = objects[indexPath.row]
        //cell.textLabel!.text = object.description
        return cell
    }
/*
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }*/

    @IBAction func settings(_ sender: Any) {
        let alertController = UIAlertController(title: "Settings go here!", message: "", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }

}

