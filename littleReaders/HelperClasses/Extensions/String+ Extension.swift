//
//  String+ Extension.swift
//  littleReaders
//
//  Created by mymac on 21/10/22.
//

import Foundation
import UIKit

extension NSMutableAttributedString{
enum scripting : Int{
    case aSub = -1
    case aSuper = 1
}

func characterSubscriptAndSuperscript(string:String,
                                      characters:[Character],
                                      type:scripting,
                                      fontSize:CGFloat,
                                      fontColor: UIColor,
                                      scriptFontSize:CGFloat,
                                      offSet:Int,
                                      length:[Int],
                                      alignment:NSTextAlignment)-> NSMutableAttributedString
{
    let paraghraphStyle = NSMutableParagraphStyle()
     // Set The Paragraph aligmnet , you can ignore this part and delet off the function
    paraghraphStyle.alignment = alignment

    var scriptedCharaterLocation = Int()
    //Define the fonts you want to use and sizes
    let stringFont = UIFont.boldSystemFont(ofSize: fontSize)
    let scriptFont = UIFont.boldSystemFont(ofSize: scriptFontSize)
     // Define Attributes of the text body , this part can be removed of the function
    let attString = NSMutableAttributedString(string:string, attributes: [NSAttributedString.Key.font:stringFont,NSAttributedString.Key.foregroundColor: fontColor,NSAttributedString.Key.paragraphStyle: paraghraphStyle])

    // the enum is used here declaring the required offset
    let baseLineOffset = offSet * type.rawValue
    // enumerated the main text characters using a for loop
    for (i,c) in string.enumerated()
    {
        // enumerated the array of first characters to subscript
        for (theLength,aCharacter) in characters.enumerated()
        {
            if c == aCharacter
            {
               // Get to location of the first character
                scriptedCharaterLocation = i
              //Now set attributes starting from the character above
                attString.setAttributes([NSAttributedString.Key.font:scriptFont,
              // baseline off set from . the enum i.e. +/- 1
                                         NSAttributedString.Key.baselineOffset:baseLineOffset,
                                         NSAttributedString.Key.foregroundColor: fontColor],
               // the range from above location
        range:NSRange(location:scriptedCharaterLocation,
         // you define the length in the length array
         // if subscripting at different location
         // you need to define the length for each one
         length:length[theLength]))

            }
        }
    }
    return attString}
  }
