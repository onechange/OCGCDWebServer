//
//  ViewController.swift
//  OCGCDWebServer
//
//  Created by orange on 2017/3/20.
//  Copyright © 2017年 onechange. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let webServer = GCDWebServer()
//        webServer?.addDefaultHandler(forMethod:"GET", request: GCDWebServerRequest.self, processBlock: { request in
//                let html = "<html><body>欢迎访问 <b>onechange</b></body></html>"
//            return GCDWebServerDataResponse(html: html)
//        })
//        webServer?.start(withPort:8080, bonjourName: "GCD Web Server")
//        print("服务器启动成功,请访问:\(webServer?.serverURL)")
//        webServer?.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self, asyncProcessBlock: { (request, completionBlock) in
//            //模拟耗时操作
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
//                let html = "<html><body>欢迎访问 <b>hangge.com</b></body></html>"
//                let response = GCDWebServerDataResponse(html: html)
//                completionBlock!(response)
//            }
//        })
//        webServer?.addHandler(forMethod: "GET", path: "/", request: GCDWebServerRequest.self , processBlock:{ (request) -> GCDWebServerResponse? in
//            let url = URL(string: "index.html", relativeTo: request?.url)
//            return GCDWebServerResponse.init(redirect: url, permanent: false)
//        })

        //处理get请求:/(返回一个提交表单)
        webServer?.addHandler(forMethod: "GET", path: "/", request: GCDWebServerRequest.self, processBlock: { (request) -> GCDWebServerResponse? in
            let html = "<html><body>" +
                "<form name=\"input\" action=\"/\" method=\"post\" " +
                "enctype=\"application/x-www-form-urlencoded\"> " +
                "用户名: <input type=\"text\" name=\"username\">" +
                "<input type=\"submit\" value=\"提交\">" +
                "</form>" +
                "</body></html>"
            return GCDWebServerDataResponse(html:html)
        })
        //处理post请求
        webServer?.addHandler(forMethod: "POST", path: "/", request: GCDWebServerURLEncodedFormRequest.self, processBlock: { (request) -> GCDWebServerResponse? in
            let formRequest = request as! GCDWebServerURLEncodedFormRequest
            let value = formRequest.arguments["username"]
            let html = "<html><body>\(value)</body></html>"
            return GCDWebServerDataResponse(html:html)
        })
        webServer?.start(withPort: 8080, bonjourName: "GCD Web Server")
        print("服务启动成功，使用你的浏览器访问：\(webServer?.serverURL)")
    }
    
    
}

