//
//  ViewController.swift
//  iosTodoList
//
//  Created by 桑古　昌輝 on 2016/03/23.
//  Copyright © 2016年 桑古　昌輝. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIToolbarDelegate {
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var tableView: UITableView!
    var tasks:[Task] = [Task]()
    var task = Task()
    @IBOutlet weak var textArea: UITextField!
    @IBAction func addBtn(sender: AnyObject) {
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = ("yyyy-MM-dd HH:mm")
        
        // TODO ここでデートピッカー生成
        // DatePickerを生成する.
        let myDatePicker: UIDatePicker = UIDatePicker()
        
        // datePickerを設定（デフォルトでは位置は画面上部）する.
        myDatePicker.frame = CGRectMake(0, 50, self.view.frame.width, 200)
        myDatePicker.timeZone = NSTimeZone.localTimeZone()
        myDatePicker.backgroundColor = UIColor.whiteColor()
        myDatePicker.datePickerMode = UIDatePickerMode.DateAndTime;
        myDatePicker.layer.cornerRadius = 5.0
        myDatePicker.layer.shadowOpacity = 0.5
        
        // 値が変わった際のイベントを登録する.
        myDatePicker.addTarget(self, action: #selector(ViewController.onDidChangeDate(_:)), forControlEvents: .ValueChanged)
        
        // DataPickerをViewに追加する.
        self.view.addSubview(myDatePicker)
        
        // TODO データピッカーから値取得して登録
        
        let addTask = Task(taskName: textArea.text!, deadline: dateFormatter.stringFromDate(now))
        tasks.append(addTask)
        task = addTask
        self.save()
        tableView.reloadData()
        textArea.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.dataGet()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle .SingleLine
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // データの保存
    func save() {
        do {
            let realm = try! Realm()
            
            try realm.write {
                realm.add(self.task)
            }
        } catch {
            // Error handling...
        }
    }
    
    // データの取得
    func dataGet() {
        
        let realm = try! Realm()
        
        let dataContent = realm.objects(Task)
        print(dataContent)
        
        for i in 0..<dataContent.count  {
            tasks.append(dataContent[i])
        }
    }
    
    // データの削除
    func dataDelete(deleteTask: Task) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(deleteTask)
        }
    }
    
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
            // TODO realmからも削除
            self.dataDelete(tasks[indexPath.row])
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
    
    /*
     DatePickerが選ばれた際に呼ばれる.
     */
    internal func onDidChangeDate(sender: UIDatePicker){
        
        // フォーマットを生成.
        let myDateFormatter: NSDateFormatter = NSDateFormatter()
        myDateFormatter.dateFormat = "yyyy/MM/dd hh:mm"
        
        // 日付をフォーマットに則って取得.
        let mySelectedDate: NSString = myDateFormatter.stringFromDate(sender.date)
        // TODO テキスト形式で返す
//        myTextField.text = mySelectedDate as String
    }
}