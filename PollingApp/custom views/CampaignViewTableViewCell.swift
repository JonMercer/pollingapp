//
//  CampaignView.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

protocol CampaignViewTableViewCellDelegate {
  func questionSelected(question:Question)
}

class CampaignViewTableViewCell: UITableViewCell {
  
  var delegate: CampaignViewTableViewCellDelegate?
  
  @IBOutlet weak var author: UILabel!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var expiry: UILabel!
  @IBOutlet weak var backgroundImage: UIImageView!
  
  private var question:Question?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func setFieldQuestion (question: Question) {
    self.question = question
  }
  
  func setQuestionText(questionName: QuestionText) {
    questionLabel.text = questionName
  }
  
  func setAuthorText(author:Author) {
    self.author.text = "asks \(author)"
    self.author.adjustsFontSizeToFitWidth = false
    self.author.lineBreakMode = NSLineBreakMode.ByClipping
  }
  
  func setExpiryMessage(expiry: String) {
    self.expiry.text = expiry
    self.expiry.adjustsFontSizeToFitWidth = false
    self.expiry.lineBreakMode = NSLineBreakMode.ByClipping
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    if !selected {
      backgroundImage.image = UIImage(named: "QuestionCell")!
      questionLabel.textColor = colors.textColor
      author.textColor = colors.authorColor
      expiry.textColor = colors.authorColor
    } else {
      backgroundImage.image = UIImage(named: "QuestionCellSelected")!
      questionLabel.textColor = UIColor.whiteColor()
      author.textColor = colors.lightAuthorColor
      expiry.textColor = colors.lightAuthorColor
    }
    
  }
  
  func setAnsweredBackground(isAnswered: Bool) {
    if isAnswered {
      backgroundImage.image = UIImage(named: "QuestionCellSelected")!
    } else {
      backgroundImage.image = UIImage(named: "QuestionCell")!
    }
  }
  
}
