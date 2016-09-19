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
    
    
    private func homeTableViewReload(){
    
        homeViewModel.loadData { (isSuccess) in
          
            if isSuccess {
             self.tableView.reloadData()
            
        }else{
             
             print("load error")
           
            }
      }
  
 }
   private func setupUI(){
    
       self.view.backgroundColor = UIColor.white
        
       navigationItem.leftBarButtonItem = UIBarButtonItem(imgName: "navigationbar_friendsearch", target: nil, action: nil)
        
       navigationItem.rightBarButtonItem = UIBarButtonItem(imgName: "navigationbar_pop", target: self, action: #selector(pop))
    
       tableView.register(XDLStatusTableViewCell.self, forCellReuseIdentifier: "cellid")
    
       tableView.rowHeight = UITableViewAutomaticDimension
    
       tableView.estimatedRowHeight = 200
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func pop(){
        
            let vc = XDLTempViewController()
        
            self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    /*
     access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
     count	false	int	单页返回的记录条数，默认为50。
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
    
}
