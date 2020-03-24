//
//  User.swift
//  POC
//
//  Created by Cheryl Chen on 2020/3/24.
//  Copyright © 2020 Cheryl Chen. All rights reserved.
//

import UIKit

struct User: Codable {
    
    var login: String
    var avatarURL: String
    var siteAdmin: Bool
}

extension User {
    
    private enum CodingKeys: String, CodingKey {
        case login      = "login"
        case avatarURL  = "avatar_url"
        case siteAdmin  = "site_admin"
    }
    
    init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        login           = try container.decode(String.self, forKey: .login)
        avatarURL       = try container.decode(String.self, forKey: .avatarURL)
        siteAdmin       = try container.decode(Bool.self, forKey: .siteAdmin)
    }
}

/*
   "login": "octocat",
   "id": 1,
   "node_id": "MDQ6VXNlcjE=",
   "avatar_url": "https://github.com/images/error/octocat_happy.gif",
   "gravatar_id": "",
   "url": "https://api.github.com/users/octocat",
   "html_url": "https://github.com/octocat",
   "followers_url": "https://api.github.com/users/octocat/followers",
   "following_url": "https://api.github.com/users/octocat/following{/other_user}",
   "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
   "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
   "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
   "organizations_url": "https://api.github.com/users/octocat/orgs",
   "repos_url": "https://api.github.com/users/octocat/repos",
   "events_url": "https://api.github.com/users/octocat/events{/privacy}",
   "received_events_url": "https://api.github.com/users/octocat/received_events",
   "type": "User",
   "site_admin": false
*/
