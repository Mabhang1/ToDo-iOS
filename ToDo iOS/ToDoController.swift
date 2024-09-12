//
//  ViewController.swift
//  ToDo iOS
//
//  Created by Abhang on 09/09/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var listPlaceholderLbl: UILabel!
    @IBOutlet weak var addTodoTextField: RoundEditText!
    
    var randomTodoArray = ["Recharge Phone","Bring Eggs","Make Omlette"]
    var savedTodoArray: [String] = []
    var filteredSavedTodoArray: [String] = []
    var strSearchText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.todoTableView.register(UINib(nibName: "TodoTableCell", bundle: nil), forCellReuseIdentifier: "TodoTableCell")
        savedData()
        searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                                  for: UIControl.Event.editingChanged)
        searchTextField.delegate = self
    }
    
    func savedData() {
        if let recievedArray = UserDefaults.standard.array(forKey: "TodoList") as? [String] {
            print(recievedArray)
            savedTodoArray = recievedArray
            filteredSavedTodoArray = recievedArray
            showTip()
        } else {
            print("No data found in UserDefaults")
            savedTodoArray = []
            filteredSavedTodoArray = []
            showTip()
        }
        todoTableView.reloadData()
    }
    
    func showTip(){
        if savedTodoArray != []{
            listPlaceholderLbl.isHidden = true
        }else{
            listPlaceholderLbl.isHidden = false
        }
    }

    @IBAction func addPressed(_ sender: UIButton) {
        if let newTodo = addTodoTextField.text, !newTodo.isEmpty {
            savedTodoArray.append(newTodo)
            filteredSavedTodoArray.append(newTodo)
            UserDefaults.standard.set(savedTodoArray, forKey: "TodoList")
            savedData()
            addTodoTextField.text = ""
        }else{
            let alertController = UIAlertController(title: "", message: "Please enter a todo item", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        filteredSavedTodoArray.removeAll()
        if textField.text?.count != 0{
            for item in savedTodoArray{
                let range = item.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil{
                    filteredSavedTodoArray.append(item)
                }
            }
        }
        else{
            for item in savedTodoArray{
                filteredSavedTodoArray.append(item)
            }
        }
        todoTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSavedTodoArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableCell", for: indexPath) as! TodoTableCell
        cell.todoItemLbl.text = filteredSavedTodoArray[indexPath.row]
        
        // Gesture recognizer for the checkbox view
        let checkVwTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.checkTapped))
        cell.checkVw.isUserInteractionEnabled = true
        cell.checkVw.tag = indexPath.row
        cell.checkVw.addGestureRecognizer(checkVwTapGesture)
        
        // Gesture recognizer for the Todo Item
        let editVwGesture = UITapGestureRecognizer(target: self, action: #selector(self.editTapped))
        cell.todoItemLbl.isUserInteractionEnabled = true
        cell.todoItemLbl.tag = indexPath.row
        cell.todoItemLbl.addGestureRecognizer(editVwGesture)
        
        // Gesture recognizer for the delete view
        let deleteVwTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.deleteTapped))
        cell.deleteVw.isUserInteractionEnabled = true
        cell.deleteVw.tag = indexPath.row
        cell.deleteVw.addGestureRecognizer(deleteVwTapGesture)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // Function to handle checkbox tap
    @objc func checkTapped(sender: UITapGestureRecognizer) {
        if let view = sender.view {
            let index = view.tag
            if let tableView = view.superview?.superview as? UITableView,
               let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? TodoTableCell {
                // Toggle the checkbox image
                if cell.checkImgLbl.image == UIImage(named: "unchecked_icon") {
                    cell.checkImgLbl.image = UIImage(named: "checked_icon")
                } else {
                    cell.checkImgLbl.image = UIImage(named: "unchecked_icon")
                }
            }
        }
    }
    
    // Function to handle edit tap
    @objc func editTapped(sender: UITapGestureRecognizer) {
        if let view = sender.view {
            let index = view.tag
            let alert = UIAlertController(title: "Edit Todo Item", message: "", preferredStyle: .alert)
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextField { [self] (textField) in
                textField.text = savedTodoArray[index]
            }
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { [self, weak alert] (_) in
                let textField = alert?.textFields![0]
                if textField!.text != ""{
                    savedTodoArray[index] = textField!.text!
                    filteredSavedTodoArray[index] = textField!.text!
                    UserDefaults.standard.set(savedTodoArray, forKey: "TodoList")
                    savedData()
                }
                self.todoTableView.reloadData()
            }))
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }

    // Function to handle delete view tap
    @objc func deleteTapped(sender: UITapGestureRecognizer) {
        if let view = sender.view {
            let index = view.tag
            filteredSavedTodoArray.remove(at: index)
            savedTodoArray.remove(at: index)
            UserDefaults.standard.set(savedTodoArray, forKey: "TodoList")
            savedData()
        }
    }
}

