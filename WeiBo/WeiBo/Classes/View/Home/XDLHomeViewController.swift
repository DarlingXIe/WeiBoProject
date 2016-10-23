//
//  XDLHomeViewController.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit
import YYModel

class XDLHomeViewController: XDLVisitorTableViewController {

    
    //homeViewController refer the cell
    //var statusArray: [XDLStatus]?

    // create the XDLStatusViewModel to load 

    lazy var homeViewModel: XDLHomeViewModel = XDLHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if userlogin == false{
            
            self.visitorView.visitorImageInfo(imageName: nil, messageTitle: "NO INTERNET SERVICE")
            
            return
            
        }
        setupUI()
    
      //  loadData()
        homeTableViewReload()
        
    }

    private func setupUI(){
    
       self.view.backgroundColor = UIColor.white
        
       navigationItem.leftBarButtonItem = UIBarButtonItem(imgName: "navigationbar_friendsearch", target: nil, action: nil)
        
       navigationItem.rightBarButtonItem = UIBarButtonItem(imgName: "navigationbar_pop", target: self, action: #selector(pop))
    
       tableView.register(XDLStatusTableViewCell.self, forCellReuseIdentifier: "cellid")
    
       tableView.rowHeight = UITableViewAutomaticDimension
    
       tableView.estimatedRowHeight = 200
    
       tableView.separatorStyle = .none
       //pullUpFunction tableView set the footerView
       tableView.tableFooterView = pullUpView
        
       tableView.tableFooterView?.addSubview(pullUpViewText)
        
       pullUpViewText.snp_makeConstraints { (make) in
        
          make.centerX.equalTo(tableView.tableFooterView!).offset(80)
          make.centerY.equalTo(tableView.tableFooterView!)
       }
       tableView.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0)
        
       //1. using xcode pullDownUI for load new data
       /*
       self.refreshControl = UIRefreshControl()
    
       self.refreshControl?.addTarget(self, action: #selector(homeTableViewReload), for: .valueChanged)
       */
       //2. the twoMethod by using our refreshControl
        
       tableView.addSubview(xdlRefreshControl)
       
       xdlRefreshControl.addTarget(self, action:#selector(homeTableViewReload), for: .valueChanged)
        
     //  xdlRefreshControl.snp_makeConstraints { (make) in
        
     //  }
        
       self.navigationController?.view.insertSubview(pullDownTipView, belowSubview: self.navigationController!.navigationBar)
        
       pullDownTipView.frame.origin.y = self.navigationController!.navigationBar.frame.maxY - self.pullDownTipView.frame.size.height
       
    }
    internal func homeTableViewReload(){
        
        homeViewModel.loadData(pullUp: pullUpView.isAnimating) { (isSuccess,count) in
            
            if isSuccess {
                
                self.tableView.reloadData()
                // this bug: if keep the status of pullUpView.isAnimating is true, than can't load the next action for pull cause cannot recall reload the data for tableView
            }else{
                print("load error")
            }
            print("*******load \(count) messages*******")
            
            if !self.pullUpView.isAnimating{
            
                self.pullDownTipView(count: count)
            
            }
        
            self.pullUpView.stopAnimating()
            
            self.xdlRefreshControl.endRefreshing()
        
        }
        
        /*
         homeViewModel.loadData { (isSuccess) in
         
         if isSuccess {
         self.tableView.reloadData()
         
         }else{
         
         print("load error")
         
         }
         }
         */
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func pop(){
        
            let vc = XDLQRToolBarController()
        
        
            self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    private func pullDownTipView(count : Int){
        
        if pullDownTipView.isHidden == false{
            return
        }
        
        pullDownTipView.isHidden = false
        
        let str = count == 0 ? "no new nessages" : "load \(count) messages"
        
        pullDownTipView.text = str
        
        UIView.animate(withDuration: 1, animations: {
            self.pullDownTipView.transform = CGAffineTransform.init(translationX: 0, y: self.pullDownTipView.frame.size.height)
            }) { (_) in
                UIView.animate(withDuration: 1, delay: 1, options: [], animations: { 
                    self.pullDownTipView.transform = CGAffineTransform.identity
                    }, completion: { (_) in
                        self.pullDownTipView.isHidden = true
                })
        }
    }
    
    /*
     access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
     count	false	int	单页返回的记  录条数，默认为50。
     page	false	int	返回结果的页码，默认为1。
     base_app	false	int	是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0.
     */

    //MARK: - tableView request
    /*
    private func loadData(){
        
            let urlString = "https://api.weibo.com/2/statuses/public_timeline.json"
        
            let parameters = [
                
                "access_token" : XDLUserAccountViewModel.shareModel.access_token ?? ""
            ]
        
        XDLNetWorkTools.sharedTools.request(method: .Get, urlSting: urlString, parameters: parameters) { (response, error) in
            if response == nil && error != nil{
                
                print("-------\(error)")
                return
            }
               print("******\(response)")
            // the array of statuses with dict
            guard let dictArray = (response! as! [String : Any])["statuses"] as? [[String : Any]] else{
                
              return
            }
            // change the array of stauses with dict to the model of XDLStatus array
            
          let modelArray = NSArray.yy_modelArray(with: XDLStatus.self, json: dictArray) as! [XDLStatus]
            
          self.statusArray = modelArray
            
          self.tableView.reloadData()
        }
    
    }
    
   */
    
    override func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print("scrollView");
    }
    
    //MARK: - tableView loadData
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return homeViewModel.statusArray?.count ?? 0
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
       let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! XDLStatusTableViewCell
       
       let model = homeViewModel.statusArray![indexPath.row]
        
       cell.XDLStatusViewModel = model
    
       return cell
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == (homeViewModel.statusArray?.count)! - 1 && pullUpView.isAnimating == false{
            
            print("**************have to show the last row for cell*************")
            
            pullUpView.startAnimating()
            
            homeTableViewReload()
        }
    }
    //MARK: - pullUpUI
    
    private lazy var pullUpView : UIActivityIndicatorView = {()-> UIActivityIndicatorView in
        
       let pullUpView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
       pullUpView.color = UIColor.black
       
       pullUpView.frame.origin.x = -60
        
       return pullUpView
    }()
    
    private lazy var pullUpViewText :UILabel = {()-> UILabel in
    
        let label = UILabel(textColor:UIColor.gray, fontSize: 11)
        
        label.text = "loading............"
        
        return label
    
    }()
    
    //MARK: - PullDown-refreshController
    
    private lazy var xdlRefreshControl :XDLRefreshControl = {()-> XDLRefreshControl in
        
        let xdlRefreshControl = XDLRefreshControl()
        
        //label.textColor = UIcolor.red
        
        return xdlRefreshControl
    }()

   private lazy var pullDownTipView :UILabel = {()-> UILabel in
        
        let label = UILabel(textColor: UIColor.lightGray, fontSize: 12)
    
        label.backgroundColor = UIColor.black
    
        label.textAlignment = .center
        //label.textColor = UIcolor.red
        label.isHidden = true
    
        label.frame.size = CGSize(width: XDLScreenW, height: 35)
    
        return label
    }()
    
    
}
