//
//  ViewController.swift
//  DragSample
//
//  Created by shoji on 2016/12/04.
//  Copyright © 2016年 shoji fujita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imageView = UIImageView()
    var isMiss = false
    @IBOutlet weak var missView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
        imageView.image = UIImage(named: "sample.png")
        imageView.frame = CGRect(x:0, y:0, width:128, height:128)
        
        // 画像をスクリーン中央に設定
        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        imageView.isUserInteractionEnabled = true
        view.addSubview(imageView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タッチイベントを取得
        let touchEvent = touches.first!
        guard touchEvent.view is UIImageView && !isMiss else {
            return
        }
        
        // ドラッグ前の座標, Swift 1.2 から
        let preDx = touchEvent.previousLocation(in: self.view).x
        let preDy = touchEvent.previousLocation(in: self.view).y
        
        // ドラッグ後の座標
        let newDx = touchEvent.location(in: self.view).x
        let newDy = touchEvent.location(in: self.view).y
        
        // ドラッグしたx座標の移動距離
        let dx = newDx - preDx
//        print("x:\(dx)")
        
        // ドラッグしたy座標の移動距離
        let dy = newDy - preDy
//        print("y:\(dy)")
        
        // 画像のフレーム
        var viewFrame: CGRect = imageView.frame
        
        // 移動分を反映させる
        viewFrame.origin.x += dx
        viewFrame.origin.y += dy
        
        imageView.frame = viewFrame
        
        if imageView.frame.origin.y + imageView.frame.size.height > missView.frame.origin.y {
            isMiss = true
            UIView.animate(withDuration: 2, animations: { () -> Void in
                self.imageView.frame.origin.y = 0
            })
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("End")
        isMiss = false
    }
}
