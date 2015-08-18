//
//  EmojiAttributedString.swift
//  图文混排
//
//  Created by Jason on 15/8/16.
//  Copyright © 2015年 KYLERUAN. All rights reserved.
//

import UIKit

class EmojiTextAttachment: NSTextAttachment {
    var emojioTag:NSString?
    var emojiSize:CGFloat?
    override func attachmentBoundsForTextContainer(textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {
        return self.scaleImageSizeToWidth(emojiSize!)
    }
    
    
    func scaleImageSizeToWidth(width:CGFloat)->CGRect{
        //Scale factor
        var factor:CGFloat = 1.0
    
        //Get image size
        let oriSize = self.image?.size
        
        //Calculate factor
        factor = width/oriSize!.width
        //Get new size
        let newSize = CGRectMake(0, 0, oriSize!.width * factor, oriSize!.height * factor)
        return newSize
  
    }


}


extension NSAttributedString {
    func getPlainString()->String{
        let plainString = NSMutableString(string: self.string)
        var  base = 0
        let ranges =  NSMakeRange(0, self.length)
        self.enumerateAttribute(NSAttachmentAttributeName, inRange:ranges, options: NSAttributedStringEnumerationOptions.LongestEffectiveRangeNotRequired)
            { (value, range, error) -> Void in
                if (value != nil) {
                    if value is EmojiTextAttachment{
                        let makeRange = NSMakeRange(range.location+base, range.length)
                        let  emoji = value as! EmojiTextAttachment
                        plainString.replaceCharactersInRange(makeRange, withString: emoji.emojioTag! as String)
                        base = base + (emoji.emojioTag?.length)!-1
                    }
                    
                }
        }
        
        
        return plainString as String
    }
}


