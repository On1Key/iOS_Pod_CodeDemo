/* 
  bugfix.js
  iOS_Pod_CodeDemo

  Created by mac book on 2016/12/23.
  Copyright © 2016年 mac book. All rights reserved.
*/

require("UIViewController,UIView,UILabel,UIColor,CALayer")

// 动态修改xmlparse vc的取消选中状态
defineClass("XMLParseController", {
        tableView_didSelectRowAtIndexPath: function(tableView, indexPath) {
            self.ORIGtableView_didSelectRowAtIndexPath(tableView,indexPath);
            console.log(indexPath);
            tableView.deselectRowAtIndexPath_animated(indexPath,true);
        }
    },{})

defineClass("GRMustacheController",{
            viewDidLoad:function() {
                //原有的viewdidload方法
                self.ORIGviewDidLoad();
                
                self.view().setBackgroundColor(UIColor.lightGrayColor());
                
                var view = UILabel.alloc().init();
                view.setBackgroundColor(UIColor.redColor());
                view.setText("这是用JSPatch动态添加的label\n布局用MAS动态部署");
                view.setNumberOfLines(0);
                view.setTextAlignment(1);
                self.view().addSubview(view);
                
                var height = 100;

                
                view.mas__makeConstraints(block('MASConstraintMaker*', function(make) {
                                                make.top().equalTo()(self.redView().mas__bottom()).with().offset()(15);
                                                make.left().equalTo()(self.view()).with().offset()(10);
                                                make.right().equalTo()(self.view()).with().offset()(-10);
                                                make.height().equalTo()((height));
                                                }));
            
                // 告诉view约束需要更新
                self.view().setNeedsUpdateConstraints();
                // 调用此方法告诉view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
                self.view().updateConstraintsIfNeeded();
                // 更新界面到指定位置
                self.view().layoutIfNeeded();
                view.layer().setCornerRadius(height*0.5);
            
            }
            
//            viewDidLayoutSubviews:function(){
//                self.ORIGviewDidLayoutSubviews();
//                self.view().layer().setCornerRadius(100*0.5);
//            }
            
            },{})
