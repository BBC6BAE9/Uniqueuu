//
//  UNHomeCell.swift
//  Uniqueuu
//
//  Created by huang on 2016/12/17.
//  Copyright © 2016年 BBC6BAE9. All rights reserved.
//

import UIKit

class UNHomeCell: UITableViewCell {
    var title:UILabel!
    var clickBtn:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil) {
            title = UILabel(frame: CGRect(x:20, y:20, width:200, height:30))
            self.contentView.addSubview(title)
            clickBtn = UIButton(frame: CGRect(x:200, y:20, width:60, height:30))
            clickBtn.setTitle("app", for: .normal)
            clickBtn.setTitleColor(UIColor.blue, for: .normal)
            clickBtn.setTitleColor(UIColor.white, for: .highlighted)
            self.contentView.addSubview(clickBtn)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
