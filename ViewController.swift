//
//  ViewController.swift
//  图文混排
//
//  Created by Jason on 15/8/16.
//  Copyright © 2015年 KYLERUAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var emojiSizeSlider: UISlider!
    let size:Float = 64.0
   
    var emojiImage:UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiImage = UIImage(named:"emoji_1_big")
   resetTextStyle()
    }
    @IBAction func emojiButton(sender: UIButton) {
        let emoji = EmojiTextAttachment()
        emoji.image = emojiImage
        emoji.emojioTag = "[/emoji_1]"
        let scale = emojiSizeSlider.value * size
         emoji.emojiSize = CGFloat(scale)
        let attributeString = NSAttributedString(attachment: emoji)
        
        textView.textStorage.insertAttributedString(attributeString, atIndex: textView.selectedRange.location)
        textView.selectedRange = NSMakeRange(textView.selectedRange.location+1, textView.selectedRange.length)
        resetTextStyle()
    }
    
    
    @IBAction func plainString() {
        self.showLabel.text = textView.textStorage.getPlainString()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //设置textView的字体属性
    func resetTextStyle(){
        let wholeRange:NSRange = NSMakeRange(0, textView.textStorage.length)
        textView.textStorage.removeAttribute(NSFontAttributeName, range: wholeRange)
        textView.textStorage.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(40), range: wholeRange)

    }

}

