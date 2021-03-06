//
//  RepoContentsFetcher.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 04/02/16.
//  Copyright © 2016 Nuno Gonçalves. All rights reserved.
//

extension GitHub {
    class RepoContentFetcher : Getter {
        
        private let repoName: String
        
        init(repositoryName: String) {
            self.repoName = repositoryName
        }
        
        func getUrl() -> String {
            return "https://api.github.com/repos/\(repoName)/contents"
        }
        
        func getDataFrom(dictionary: NSDictionary) -> String {
            var readMeLocation = ""
            for item in dictionary["response"] as! NSArray {
                let name = (item["name"] as? String) ?? ""
                if name.lowercaseString.containsString("readme") {
                    if let url = item["html_url"] as? String {
                        readMeLocation = url
                        break
                    }
                }
            }
            return readMeLocation
        }
        
    }
}
