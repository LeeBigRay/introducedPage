//
//  ViewController.swift
//  LRIntroducePageDemo
//
//  Created by 李瑞 on 2016/11/1.
//  Copyright © 2016年 李瑞. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    /// 屏幕的宽
    let KJRScreenWidth = UIScreen.main.bounds.size.width
    /// 屏幕的高
    let KJRScreenHeight = UIScreen.main.bounds.size.height

     let numPages  = 3
    var pageControl  = UIPageControl()
    var beginBtn  = UIButton()
    let pageControlWidth = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = self.view.bounds
        
        let scrollView = UIScrollView.init()
        scrollView.frame = frame
        scrollView.delegate = self
        
        //为了能让内容横向移动 设置横向宽度为3个页面的宽度之和
        scrollView.contentSize = CGSize.init(width:KJRScreenWidth * CGFloat(numPages) , height: KJRScreenHeight)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator  = false
        scrollView.showsVerticalScrollIndicator  = false
        //        scrollsToTop是UIScrollView的一个属性，主要用于点击设备的状态栏时，是scrollsToTop == YES的控件滚动返回至顶部。
        
        //        每一个默认的UIScrollView的实例，他的scrollsToTop属性默认为YES，所以要实现某一UIScrollView的实例点击设备状态栏返回顶部，则需要关闭其他的UIScrollView的实例的scrollsToTop属性为NO。很好理解：若多个scrollView响应返回顶部的事件，系统就不知道到底要将那个scrollView返回顶部了，因此也就不做任何操作了。。。
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        for index in 0..<numPages {
            let imageView = UIImageView.init(image: UIImage.init(named: "GuideImage\(index + 1).png"))
            imageView.frame = CGRect.init(x: KJRScreenWidth * CGFloat(index), y: 0, width: KJRScreenWidth, height: KJRScreenHeight)
            scrollView.addSubview(imageView)
        }
        
        self.view.addSubview(scrollView)
        
        
        let pageControlx = KJRScreenWidth - CGFloat(pageControlWidth)
        
        pageControl = UIPageControl.init(frame: .init(x: pageControlx/2, y: KJRScreenHeight - 50.0, width:CGFloat(pageControlWidth) , height: 20))
        
        pageControl.numberOfPages = numPages
        
        pageControl.currentPage = 0
        
        view.addSubview(pageControl)
        
        
        beginBtn = UIButton.init(type: .custom)
        beginBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        beginBtn.frame = CGRect.init(x: pageControlx/2, y: KJRScreenHeight - 80, width:CGFloat(pageControlWidth), height: 25)
        beginBtn.setTitle("点击进入", for: .normal)
        beginBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        beginBtn.layer.masksToBounds = true
        beginBtn.layer.cornerRadius = 3.0
        view.addSubview(beginBtn)
        beginBtn.alpha = 0.0
        
        self.view.bringSubview(toFront: pageControl)
        self.view.bringSubview(toFront: beginBtn)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        // 随着滑动改变pageControl的状态
        pageControl.currentPage = Int(offset.x / view.bounds.width)
        // 因为currentPage是从0开始，所以numOfPages减1
        if pageControl.currentPage == numPages - 1 {
            UIView.animate(withDuration: 0.5) {
                self.beginBtn.alpha = 0.8
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.beginBtn.alpha = 0.0
            }
        }
    }
    


}

