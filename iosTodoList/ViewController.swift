//
//  ViewController.swift
//  iosTodoList
//
//  Created by 桑古　昌輝 on 2016/03/23.
//  Copyright © 2016年 桑古　昌輝. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIToolbarDelegate {
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var tableView: UITableView!
    var tasks:[Task] = [Task]()
    @IBOutlet weak var textArea: UITextField!
    @IBAction func addBtn(sender: AnyObject) {
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = ("yyyy-MM-dd HH:mm")
        
        let task = Task(taskName: textArea.text!, deadline: dateFormatter.stringFromDate(now))
        tasks.append(task)
        tableView.reloadData()
        textArea.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setUpTasks();
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle .SingleLine
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpTasks() {
        let task1 = Task(taskName: "議事録を書く", deadline: "2016-03-30")
        let task2 = Task(taskName: "彼女を作る", deadline: "2016-04-30")
        let task3 = Task(taskName: "あああ", deadline: "2016-05-30")
        
        tasks.append(task1)
        tasks.append(task2)
        tasks.append(task3)
    }
    
    // functions needed to be implemented
    // for table view
    
    // セクション数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // セクションの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as! CustomCell
        print(cell)
        cell.setCell(tasks[indexPath.row])
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            tasks.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    // キーボードが表示されたときの処理
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        let transform = CGAffineTransformMakeTranslation(0, -keyboardScreenEndFrame.size.height);
        self.view.transform = transform
    }
    
    // キーボードが非表示になったときの処理
    func handleKeyboardWillHideNotification(notification: NSNotification) {
         self.view.transform = CGAffineTransformIdentity
    }
    
    // UITextFieldでリターンを押した時にキーボードを閉じる
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}