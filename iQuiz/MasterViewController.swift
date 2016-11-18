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
    let defaults = UserDefaults.standard
    var subjectTitles = [String]()
    var subjectDescs = [String]()
    
    var titles = [String]()
    private static func getTitle() -> [String] {
        let title = UserDefaults.standard.array(forKey: "titles")
        if title == nil {
            return Array()
        } else {
            return title! as! [String]
        }
    }
    
    var descs = [String]()
    private static func getDesc() -> [String] {
        let desc = UserDefaults.standard.array(forKey: "descs")
        if desc == nil {
            return Array()
        } else {
            return desc! as! [String]
        }
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
    
    var answer = [[String]]()
    private static func getAnswer() -> [[String]] {
        let answer = UserDefaults.standard.array(forKey: "answer")
        if answer == nil {
            return Array()
        } else {
            return answer! as! [[String]]
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
    
    var test: Bool = false
    private static func getBool() -> Bool {
        let test = UserDefaults.standard.bool(forKey: "testBool")
        return test
    }
    
    var subjectTitle: [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
    var subjectDesc: [String] = ["Questions about math!", "Questions about superheroes!", "Questions about science!"]
    var subjectQuestions: Array<Array<String>> = [["1+1=?", "2*3=?", "10/2=?", "8-3=?"], ["Who is Captain America?"], ["How many bones in a human?", "How many protons in carbon?"]]
    var subjectAnswers: Array<Array<Array<String>>> = [[["1", "2", "3", "4", "2"], ["2", "4", "6", "8", "3"], ["5", "4", "3", "2", "1"], ["2", "3", "4", "5", "4"]],[["Steve Rogers", "Tony Stark", "Bruce Banner", "Clark Kent", "1"], ["Steve Rogers", "Tony Stark", "Bruce Banner", "Clark Kent", "1"], ["Steve Rogers", "Tony Stark", "Bruce Banner", "Clark Kent", "1"]], [["300", "200", "206", "252", "3"], ["8", "6", "12", "4", "2"]]]



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.test = MasterViewController.getBool()
        if test == false {
            self.jsonGet()
        }
        var counts = defaults.integer(forKey: "count")
        counts = 0
        defaults.set(counts, forKey: "count")
        
        /*var answerGiven = defaults.integer(forKey: "answerGiven")
        answerGiven = 0
        defaults.set(answer, forKey: "answerGiven")*/
        
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
        //self.tableView.tableFooterView = UIView()
        //self.tableView.reloadData()
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
    
    @IBAction func refreshPressed(_ sender: Any) {
        self.jsonGet()
    }
    
    @IBAction func pullRefresh(_ sender: Any) {
        self.jsonGet()
    }
    
    
    func jsonGet() {
        var test = self.defaults.bool(forKey: "testBool")
        test = true
        self.defaults.set(test, forKey: "testBool")
        let requestURL: NSURL = NSURL(string: "https://tednewardsandbox.site44.com/questions.json")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as AnyObject
                    for i in 0...json.count - 1 {
                        let subjects = json[i] as? [String: AnyObject]
                        let title = subjects?["title"] as? String
                        //var titles: [String] = [String]()
                        //titles.append(title!)
                        var titles = self.defaults.array(forKey: "titles")
                        if titles == nil {
                            titles = Array()
                        }
                        //NSLog("\(titles)")
                        titles!.append(title!)
                        //NSLog("\(titles)")
                        self.defaults.set(titles, forKey: "titles")
                        //self.subjectTitles.append(title!)
                        
                        let desc = subjects?["desc"] as? String
                        //var descs: [String] = [String]()
                        //descs = self.defaults.array(forKey: "descs") as! [String]
                        var descs = self.defaults.array(forKey: "descs")
                        if descs == nil {
                            descs = Array()
                        }
                        descs!.append(desc!)
                        self.defaults.set(descs, forKey: "descs")
                        NSLog("\(desc)")
                        //self.subjectDescs.append(desc!)
                        
                        var texts: [String] = [String]()
                        let questions = subjects?["questions"] as? [[String : AnyObject]]
                        for j in 0...(questions?.count)! - 1 {
                            let question = questions?[j]
                            let text = question?["text"] as? String
                        //var textGroup: Array<Array<String>> = [[String]]()
                            texts.append(text!)
                        }
                        var textGroup = self.defaults.array(forKey: "texts")
                        if textGroup == nil {
                            textGroup = Array()
                        }
                        textGroup!.append(texts)
                        self.defaults.set(textGroup, forKey: "texts")
                        
                        var corrects: [String] = [String]()
                        for j in 0...(questions?.count)! - 1 {
                            let question = questions?[j]
                            let correct = question?["answer"] as? String
                        //var corrects: [String] = [String]()
                            corrects.append(correct!)
                        }
                        var correctGroup = self.defaults.array(forKey: "answer")
                        if correctGroup == nil {
                            correctGroup = Array()
                        }
                        correctGroup!.append(corrects)
                        //NSLog("\(correctGroup)")
                        self.defaults.set(correctGroup, forKey: "answer")

                        
                        var answerGroup: Array<Array<String>> = [[String]]()
                        for j in 0...(questions?.count)! - 1 {
                            let question = questions?[j]
                            let answer = question?["answers"] as? [String]
                            //NSLog("\(temp)")
                            //var answers: [String] = [String]()
                            /*for k in 0...(temp?.count)! - 1 {
                                let answer = temp![k]
                                NSLog("\(answer)")
                            //var answerMass: Array<Array<Array<String>>> = [[[String]]]()
                                answers.append(answer)
                                }*/
                            answerGroup.append(answer!)
                            //NSLog("\(answerGroup)")
                        }
                        var answerMass = self.defaults.array(forKey: "answers")
                        if answerMass == nil {
                            answerMass = Array()
                        }
                        answerMass!.append(answerGroup)
                        self.defaults.set(answerMass, forKey: "answers")
                        }
                    //self.tableview.reloadData()
                } catch {
                        print("Error with Json: \(error)")
                    }
                    
                }
            }
        //self.tableview.reloadData()
        task.resume()
    }
    
    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.descs = MasterViewController.getDesc()
        self.answer = MasterViewController.getAnswer()
        self.answers = MasterViewController.getAnswers()
        self.questionsText = MasterViewController.getQuestion()
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = self.descs[indexPath.row]
                let question = self.questionsText[indexPath.row]
                let answer = self.answer[indexPath.row]
                let answers = self.answers[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.questionItem = question
                controller.answerItem = answers
                controller.correctItem = answer
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = false

            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.titles = MasterViewController.getTitle()
        return titles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let i = indexPath.row
        self.titles = MasterViewController.getTitle()
        self.descs = MasterViewController.getDesc()

        NSLog("\(descs)")
        cell.titleLabel.text = titles[i]
        cell.descLabel.text = descs[i]


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

