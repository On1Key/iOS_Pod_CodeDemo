//
//  RedView.swift
//  iOS_Pod_CodeDemo
//
//  Created by mac book on 16/9/21.
//  Copyright © 2016年 mac book. All rights reserved.
//

import UIKit
import SnapKit

class RedView: UIView {

//    override init(frame: CGRect) {
//        
//    }
    
    var titleLabel : UILabel!
    var contentLabel : UILabel!
    
    
    
    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)!
//        super.init(coder: aDecoder);
        print("initCoder");
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.redColor()
        
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        contentLabel = UILabel()
        self.addSubview(contentLabel)
        titleLabel.backgroundColor = UIColor.yellowColor()
        contentLabel.backgroundColor = UIColor.blueColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        contentLabel.textAlignment = NSTextAlignment.Center
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFontOfSize(13)
        
        titleLabel.text = "标题一定要长"
        contentLabel.text = "文本随意,但是也不能特别随意，随意出🆕花样，随意➗❤️境界，就是这么的随意"
        
        
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = CGRectGetHeight(self.frame) * 0.5;
        self.layer.masksToBounds = true
        
        titleLabel.snp.makeConstraints(closure: { (make) in
            make.top.equalTo(10);
            make.left.equalTo(10);
            make.right.equalTo(-10);
//            make.height.equalTo(self.frame.size.height * 0.4);
        })
        
        contentLabel.snp.makeConstraints(closure: { (make) in
            make.top.equalTo(titleLabel.snp.bottom);
            make.left.equalTo(10);
            make.right.equalTo(-10);
//            make.height.equalTo(self.frame.size.height * 0.4);
        })
        
    }
    
    

}
