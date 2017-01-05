//
//  UNCarouselScrollView.swift
//  Uniqueuu
//
//  Created by huang on 2017/1/5.
//  Copyright © 2017年 BBC6BAE9. All rights reserved.
//

import UIKit

import UIKit


//广告数目

class UNCarouselScrollView: UIView,UIScrollViewDelegate
{
    //MARK: - 属性
    //是否URL加载
    fileprivate var isFromURL:Bool  = true
    //页码
    fileprivate var index:Int       = 0
    //图片数量
    fileprivate var imgViewNum:Int  = 0
    //宽度
    fileprivate var sWidth:CGFloat  = 0
    //高度
    fileprivate var sHeight:CGFloat = 0
    //广告每一页停留时间
    fileprivate var pageStepTime:TimeInterval  = 0
    
    //定时器
    fileprivate var timer:Timer?
    //图片数组
    fileprivate var imgArray: [UIImage]?
    //图片url数组
    fileprivate var imgURLArray:[String]?
    
    
    //MARK: - 初始化方法
    /**
     初始化方法1,传入图片URL数组,以及pageControl的当前page点的颜色,特别注意需要SDWebImage框架支持
     
     - parameter frame:          frame
     - parameter imgURLArray:    图片URL数组
     - parameter pagePointColor: pageControl的当前page点的颜色
     - parameter stepTime:       广告每一页停留时间
     
     - returns: ScrollView图片轮播器
     */
    init(frame: CGRect, imageURLArray:[String], pagePointColor: UIColor, stepTime: TimeInterval)
    {
        super.init(frame: frame)
        
        imgURLArray = imageURLArray
        
        prepareUI(imageURLArray.count, pagePointColor: pagePointColor,stepTime: stepTime)
        
    }
    
    /**
     初始化方法2,传入图片数组,以及pageControl的当前page点的颜色,无需依赖第三方库
     
     - parameter frame:          frame
     - parameter imgArray:       图片数组
     - parameter pagePointColor: pageControl的当前page点的颜色
     - parameter stepTime:       广告每一页停留时间
     
     - returns: ScrollView图片轮播器
     */
    init(frame: CGRect, imageArray:[UIImage], pagePointColor: UIColor, stepTime: TimeInterval)
    {
        super.init(frame: frame)
        
        imgArray = imageArray
        
        isFromURL = false
        
        prepareUI(imageArray.count, pagePointColor: pagePointColor,stepTime: stepTime)
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 准备UI
    fileprivate func prepareUI(_ numberOfImage:Int, pagePointColor: UIColor,stepTime: TimeInterval)
    {
        //设置图片数量
        imgViewNum = numberOfImage
        //广告每一页停留时间
        pageStepTime = stepTime
        
        //添加scrollView
        addSubview(ScrollView)
        //添加pageControl
        addSubview(pageControl)
        //pageControl数量
        pageControl.numberOfPages = imgViewNum;
        //pageControl颜色
        pageControl.currentPageIndicatorTintColor = pagePointColor
        //view宽度
        sWidth = self.frame.size.width
        //view高度
        sHeight = self.frame.size.height
        
        //设置代理
        ScrollView.delegate = self;
        //一页页滚动
        ScrollView.isPagingEnabled = true;
        //隐藏滚动条
        ScrollView.showsHorizontalScrollIndicator = false;
        //设置一开始偏移量
        ScrollView.contentOffset = CGPoint(x: sWidth , y: 0);
        
        //设置timer
        setTheTimer()
        //设置图片
        prepareImage()
    }
    
    //布局子控件
    override func layoutSubviews()
    {
        super.layoutSubviews()
        //布局ScrollView
        ScrollView.frame = self.bounds
        
        //布局pageControl
        let pW = ScrollView.frame.width
        let pH = CGFloat(15)
        let pX = CGFloat(0)
        let pY = ScrollView.frame.height -  CGFloat(pH * 2)
        
        pageControl.frame = CGRect(x: pX, y: pY, width: pW, height: pH)
    }
    
    deinit
    {
        print("scrollDeinit")
    }
    
    //MARK: - 创建广告图片
    /**
     *  创建广告图片
     */
    fileprivate func prepareImage()
    {
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            //设置一开始偏移量
            self.ScrollView.contentOffset = CGPoint(x: self.sWidth, y: 0);
            //设置滚动范围
            
            self.ScrollView.contentSize = CGSize(width: CGFloat(self.imgViewNum + 2) * self.sWidth, height: 0)
            
        })
        
        
        for i in 0 ..< imgViewNum + 2
        {
            var imgX = CGFloat(i) * sWidth;
            let imgY:CGFloat = 0;
            let imgW = sWidth;
            let imgH = sHeight;
            let imgView = UIImageView()
            
            if i == 0
            {
                //第0张 显示广告最后一张
                imgX = 0;
                
                if !isFromURL
                {
                    imgView.image = imgArray?.last
                }
                else
                {
                    imgView.kf.setImage(with: URL(string: (imgURLArray?.last)!), placeholder: UIImage(named: "holder"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
            else if i == imgViewNum + 1
            {
                //第n+1张,显示广告第一张
                imgX = CGFloat(imgViewNum + 1) * sWidth;
                
                if !isFromURL
                {
                    imgView.image = imgArray?.first
                }
                else
                {
                    //                    imgView.sd_setImage(with: URL(string: (imgURLArray?.first)!), placeholderImage: UIImage(named: "holder"))
                    imgView.kf.setImage(with: URL(string: (imgURLArray?.first)!), placeholder: UIImage(named:"holder"), options: nil, progressBlock: nil, completionHandler: nil)
                    
                }
            }
            else
            {
                //正常显示广告
                if !isFromURL
                {
                    imgView.image = imgArray?[i - 1]
                }
                else
                {
                    //                    imgView.sd_setImage(with: , placeholderImage: UIImage(named: "holder"))
                    imgView.kf.setImage(with: URL(string: (imgURLArray?[i - 1])!), placeholder: UIImage(named: "holder"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
            
            imgView.frame = CGRect(x: imgX, y: imgY, width: imgW, height: imgH)
            
            //添加子控件
            ScrollView.addSubview(imgView)
        }
        
    }
    
    /**
     *  执行下一页的方法
     */
    @objc fileprivate func nextImage()
    {   //取得当前pageControl页码
        var indexP = self.pageControl.currentPage
        
        if indexP == imgViewNum
        {
            indexP = 1;
        }
        else
        {
            indexP += 1;
        }
        
        ScrollView.setContentOffset(CGPoint(x: CGFloat(indexP + 1) * sWidth, y: 0), animated: true)
    }
    
    
    //MARK: - pragma mark- 代理
    
    /**
     * 动画减速时的判断
     *
     */
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
    {
        carousel()
    }
    
    /**
     *  拖拽减速时的判断
     *
     */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        carousel()
    }
    
    func carousel()
    {
        
        //获取偏移值
        let offset = ScrollView.contentOffset.x;
        //当前页
        let page = Int((offset + sWidth/2) / sWidth);
        //如果是N+1页
        if page == imgViewNum + 1
        {
            //瞬间跳转第1页
            ScrollView.setContentOffset(CGPoint(x: sWidth, y: 0), animated: false)
            index = 1
        }
            //如果是第0页
        else if page == 0
        {
            //瞬间跳转最后一页
            ScrollView.setContentOffset(CGPoint(x: CGFloat(imgViewNum) * sWidth, y: 0), animated: false)
            
        }
    }
    
    /**
     *  滚动时判断页码
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        
        //获取偏移值
        let offset = ScrollView.contentOffset.x - sWidth;
        //页码
        let pageIndex = Int((offset + sWidth / 2.0) / sWidth);
        
        pageControl.currentPage = pageIndex
        
    }
    
    /**
     *  拖拽广告时停止timer
     */
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    {
        stopTimer()
    }
    
    /**
     销毁timer
     */
    func stopTimer()
    {
        timer?.invalidate()
        
        timer = nil
    }
    
    /**
     *  结束拖拽时重新创建timer
     */
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        setTheTimer()
    }
    
    //MARK:设置timer
    fileprivate func setTheTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: pageStepTime, target: self, selector: #selector(UNCarouselScrollView.nextImage), userInfo: nil, repeats: true)
        
        let runloop = RunLoop.current
        
        runloop.add(timer!, forMode: RunLoopMode.commonModes)
        
    }
    
    
    //MARL: - 懒加载
    //广告滚动view
    fileprivate lazy var ScrollView: UIScrollView = UIScrollView()
    
    fileprivate lazy var pageControl: UIPageControl =  UIPageControl()
   
}
