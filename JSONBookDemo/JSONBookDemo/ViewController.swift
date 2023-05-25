//
//  ViewController.swift
//  JSONBookDemo
//
//  Created by Mac on 09/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var jsonDecoder : JSONDecoder?
    var books : [Book] = []
    
    @IBOutlet weak var bookTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTableView()
        jsonParsingUsingDecoder()
        registerBookTableViewCellWithXIB()

    }
    
    func registerBookTableViewCellWithXIB(){
        
        let uiNib = UINib(nibName: "BookTableViewCell", bundle: nil)
        self.bookTableView.register(uiNib, forCellReuseIdentifier: "BookTableViewCell")
    }
    
    func initializeTableView(){
        self.bookTableView.dataSource = self
        self.bookTableView.delegate =  self
        bookTableView.separatorStyle = .singleLine
        bookTableView.separatorColor = .black
        
    }

    
    func jsonParsingUsingDecoder(){
        url = URL(string: "https://api.itbook.store/1.0/new")
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"
        
        urlSession = URLSession(configuration: .default)
        
        urlSession?.dataTask(with: urlRequest!, completionHandler: {data, response, error in
            
            self.jsonDecoder = JSONDecoder()
            let bookApiResponse = try! self.jsonDecoder?.decode(BookAPIResponse.self, from: data!)
            self.books = bookApiResponse!.books
                                  
                    DispatchQueue.main.async {
                    self.bookTableView.reloadData()
                }
      }).resume()

   }
 }
                                  
                                  extension ViewController : UITableViewDataSource {
                    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                        books.count
                    }
                    
                    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                        print(indexPath.row)
                        
                        let bookTableViewCell = self.bookTableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for : indexPath) as! BookTableViewCell
                        bookTableViewCell.backgroundColor = UIColor(cgColor: CGColor(red: 0.0, green: 0.0, blue: 70.0, alpha: 0.4))
                        bookTableViewCell.layer.borderColor = CGColor(red: 100.0, green: 0.0, blue: 0.0, alpha: 1.0)
                        bookTableViewCell.layer.borderWidth = 2.0
                        bookTableViewCell.layer.cornerRadius = 10.0
                        
                        
                        bookTableViewCell.bookTitle.text =  books[indexPath.row].title
                        bookTableViewCell.bookSubtitle.text = books[indexPath.row].subtitle
                        bookTableViewCell.bookPrice.text =  books[indexPath.row].price
                       
                        
                        return BookTableViewCell()
                     
                    }
                }
                                  extension ViewController : UITableViewDelegate{
                    
                    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                        return 164.0
                    }
                }
