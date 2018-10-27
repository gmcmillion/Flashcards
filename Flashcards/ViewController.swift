//
//  ViewController.swift
//  Flashcards
//
//  Created by Gregg McMillion on 10/13/18.
//  Copyright © 2018 Gregg McMillion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var frontLabel: UILabel!
  @IBOutlet weak var backLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func didTapOnFlashcard(_ sender: Any) {
    frontLabel.isHidden = !frontLabel.isHidden;
  }
  
  func updateFlashCard(question: String, answer: String){
    frontLabel.text = question
    backLabel.text = answer
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // We know the destination of the segue is the Navigation Controller
    let navigationController = segue.destination as! UINavigationController
    
    // We know the Navigation Controller only contains a Creation View Controller
    let creationController = navigationController.topViewController as! CreationViewController
    
    // We set the flashcardsController property to self
    creationController.flashcardsController = self
  }
}
