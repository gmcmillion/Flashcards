//
//  ViewController.swift
//  Flashcards
//
//  Created by Gregg McMillion on 10/13/18.
//  Copyright © 2018 Gregg McMillion. All rights reserved.
//

import UIKit

struct Flashcard {
  var question: String
  var answer: String
}

class ViewController: UIViewController {

  @IBOutlet weak var frontLabel: UILabel!
  @IBOutlet weak var backLabel: UILabel!
  @IBOutlet weak var prevButton: UIButton!
  @IBOutlet weak var nextButton: UIButton!
  
  @IBAction func didTapOnPrev(_ sender: Any) {
    // Decrease current index
    currentIndex = currentIndex - 1
    
    // Update labels
    updateLabels()
    
    // Update buttons
    updateNextPrevButtons()
  }
  
  @IBAction func didTapOnNext(_ sender: Any) {
    // Increase current index
    currentIndex = currentIndex + 1
    
    // Update labels
    updateLabels()
    
    // Update buttons
    updateNextPrevButtons()
  }
  
  //Array to hold flashcards
  var flashcards = [Flashcard]()
  
  //Current flashcard index
  var currentIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    // Read saved flashcards
    readSavedFlashcards()
    
    // Adding our initial card if needed
    if flashcards.count == 0 {
      updateFlashCard(question: "Whats the capital of Brazil?", answer: "Brasilia")
    } else {
      updateLabels()
      updateNextPrevButtons()
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func didTapOnFlashcard(_ sender: Any) {
    frontLabel.isHidden = !frontLabel.isHidden;
  }
  
  func updateFlashCard(question: String, answer: String){
    let flashcard = Flashcard(question: question, answer: answer)

    // Add flashcard to the flashcards array
    flashcards.append(flashcard)
    
    print("😎 Added new flashcard")
    print("😎 We now have \(flashcards.count) flashcards")
    
    // Update current index
    currentIndex = flashcards.count - 1
    print("😎 Our current index is \(currentIndex)")
    
    // Update buttons
    updateNextPrevButtons()
    
    // Update labels
    updateLabels()
    
    // Save flashcards array to disk
    saveAllFlashcardsToDisk()
  }
  
  func updateNextPrevButtons() {
    // Disable next button if at the end
    if(currentIndex == flashcards.count - 1){
      nextButton.isEnabled = false
    } else {
      nextButton.isEnabled = true
    }
    
    // Disable the prev button if at the beginning
    if(currentIndex == 0) {
      prevButton.isEnabled = false
    } else {
      prevButton.isEnabled = true
    }
  }
  
  func updateLabels() {
    // Get current flashcard
    let currentFlashcard = flashcards[currentIndex]
  
    // Update labels
    frontLabel.text = currentFlashcard.question
    backLabel.text = currentFlashcard.answer
  }
  
  func saveAllFlashcardsToDisk() {
    // From flashcard array to dictionary array
    let dictionaryArray = flashcards.map { (card) -> [String:String] in
      return ["question": card.question, "answer": card.answer]
    }
    
    // Save arry on disk using UserDefaults
    UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
    
    print("🎉 Flashcards saved to UserDefaults")
  }
  
  func readSavedFlashcards() {
    // Read dictionary array from disk (if any)
    if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
      
      // In here we know for sure we have a dictionary
      let savedCards = dictionaryArray.map { dictionary -> Flashcard in
        return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
      }
      
      //  Put all these cards in our flashcards array
      flashcards.append(contentsOf: savedCards)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // We know the destination of the segue is the Navigation Controller
    let navigationController = segue.destination as! UINavigationController
    
    // We know the Navigation Controller only contains a Creation View Controller
    let creationController = navigationController.topViewController as! CreationViewController
    
    // We set the flashcardsController property to self
    creationController.flashcardsController = self
    
    if(segue.identifier == "EditSegue") {
      creationController.initialQuestion = frontLabel.text
      creationController.initialAnswer = backLabel.text
    }
  }
}
