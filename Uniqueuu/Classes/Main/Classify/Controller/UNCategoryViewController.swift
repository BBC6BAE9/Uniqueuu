//
//  UNCategoryViewController.swift
//  Uniqueuu
//
//  Created by huang on 2016/12/30.
//  Copyright © 2016年 BBC6BAE9. All rights reserved.
//

import UIKit

class UNCategoryViewController: UNBaseViewController,YMCategoryBottomViewDelegate {
    internal func bottomViewButtonDidClicked(button: UIButton) {
        
        let searchBarVC = UNSearchViewController()
        navigationController?.pushViewController(searchBarVC, animated: true)
        
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image:UIImage(named:"Feed_SearchBtn_18x18_"), style: .plain, target: self, action: #selector(categoryRightBBClick))

        setupScrollView()

    }

    func setupScrollView(){
    
        view.addSubview(scrollView)
        let headerViewController = YMCategoryHeaderViewController()
        addChildViewController(headerViewController)
        let topBGView = UIView(frame: CGRect(x:0, y:0, width:SCREENW, height:135))
        scrollView.addSubview(topBGView)
        
        let headerVC = childViewControllers[0]
        topBGView.addSubview(headerVC.view)

        let bottomBGView = YMCategoryBottomView(frame: CGRect(x:0, y:topBGView.frame.maxY + 10, width:SCREENW, height:SCREENH - 160))
        bottomBGView.backgroundColor = YMGlobalColor()
        bottomBGView.delegate = self
        
        scrollView.addSubview(bottomBGView)
        scrollView.contentSize = CGSize(width:SCREENW, height: bottomBGView.frame.maxY)

    }
    
    /// 懒加载创建 scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = YMGlobalColor()
        scrollView.frame = CGRect(x:0, y:0, width:SCREENW, height:SCREENH)
        return scrollView
    }()

    func categoryRightBBClick(){
        
        let searchBarVC = UNSearchViewController()
        navigationController?.pushViewController(searchBarVC, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
