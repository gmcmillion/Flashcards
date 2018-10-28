//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Gregg McMillion on 10/27/18.
//  Copyright © 2018 Gregg McMillion. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
  
  var flashcardsController: ViewController!
  
  @IBOutlet weak var questionTextField: UITextField!
  @IBOutlet weak var answerTextField: UITextField!
  
  override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
  
  @IBAction func didTapOnCancel(_ sender: Any) {
    dismiss(animated: true)
  }
  
  @IBAction func didTapOnDone(_ sender: Any) {
    // Get the text in the question text field
    let questionText = questionTextField.text
    
    // Get the text in the answer text field
    let answerText = answerTextField.text
    
    // If question or answer are nil
    if(questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty) {
      // Create alert message
      let alert = UIAlertController(title: "Missing text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
      
      // Add ok button for dismissing action
      let okAction = UIAlertAction(title: "Ok", style: .default)
      alert.addAction(okAction)
      
      // Show error message
      present(alert, animated: true)
    } else {
      // Call the function to update the flashcard
      flashcardsController.updateFlashCard(question: questionText!, answer: answerText!)
    
      // Dismiss
      dismiss(animated: true)
    }
  }
  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
