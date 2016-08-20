//
//  PollAdminUserViewContainer.swift
//  PollingApp
//
//  Created by QuantumSpark on 2016-04-02.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//


import UIKit


protocol PollAdminViewContainerDelegate  {
  func segueToCampaign()
  func displayConfirmationMessage()
  func stopQuestion()
  func segueToWhoVotedFor(selectedAnswer:Answer)
}

class PollAdminViewContainer: UIView, UITableViewDelegate, UITableViewDataSource {
  private var answers:[Answer] = []
  private var question:Question?
  private var correctAnswers:[AnswerText] = []
  private var totalNumberOfAnswers: Int = 0
  @IBOutlet weak var timer: UILabel!
  @IBOutlet weak var AnswerTable: UITableView!
  @IBOutlet weak var questionLabel: UILabel!
  
  var delegate: PollAdminViewContainerDelegate?
  
  @IBAction func goToResult(sender: AnyObject) {
    delegate?.stopQuestion()
  }
  
  @IBAction func goToCampaign(sender: AnyObject) {
    delegate?.displayConfirmationMessage()
  }
  
  class func instanceFromNib(frame: CGRect) -> PollAdminViewContainer {
    let view = UINib(nibName: "PollAdminViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PollAdminViewContainer
    view.frame = frame
    view.AnswerTable.delegate = view
    view.AnswerTable.dataSource = view
    view.AnswerTable.allowsSelection = true
    
    return view
  }
  
  func setCorrectAnswers(Answers: [String]){
    correctAnswers = Answers
  }
  
  func doneTimerLabel(string: String) {
    timer.text = string
  }
  
  func setAnswers (answers: [Answer]) {
    self.answers = answers
  }
  
  func setQuestion (question: Question){
    self.questionLabel.text = question.questionText
  }
  
  func updateTimerLabel(timerString: String) {
    timer.text = timerString
  }
  func setTotalNumberOfAnswers (totalNumOfAnswers:Int){
    totalNumberOfAnswers = totalNumOfAnswers
  }
  
  func showTotalTally (totalNumOfAnswers:Int) {
    timer.text = "\(StringUtil.fillInString(totalVotes, time: totalNumOfAnswers))"
  }
  
  // returns an approiate number of rows depending on the section
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return  answers.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let nib_name = UINib(nibName: "AnswerAdminTableViewCell", bundle:nil)
    tableView.registerNib(nib_name, forCellReuseIdentifier: "answeradminCell")
    
    let cell = self.AnswerTable.dequeueReusableCellWithIdentifier("answeradminCell", forIndexPath: indexPath) as! AnswerAdminTableViewCell
    
    cell.setAnswerText(answers[indexPath.row].answerText)
    cell.setisCorrect(correctAnswers[indexPath.row])
    cell.SetTallyLabel(String(answers[indexPath.row].tally))
    
    if (totalNumberOfAnswers != 0) {
      let tally = answers[indexPath.row].tally
      
      let results:Double = MathUtil.convertTallyResultsToPercentage(
        Double(tally),
        denominator: Double(totalNumberOfAnswers))
      
      cell.setBarGraph(results)
    }else{
      cell.setBarGraph(0)
    }
    return cell
    
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return cellDimensions.pollAdminCellHeight
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Answers"
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    delegate?.segueToWhoVotedFor(answers[indexPath.row])
  }
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
}
