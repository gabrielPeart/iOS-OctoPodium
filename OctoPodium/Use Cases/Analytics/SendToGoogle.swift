//
//  SendToGoogle.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 27/01/16.
//  Copyright © 2016 Nuno Gonçalves. All rights reserved.
//

struct SendToGoogleAnalytics {
    
    private static let tracker = GAI.sharedInstance().defaultTracker
    private static let qos = Int(QOS_CLASS_USER_INTERACTIVE.rawValue)
    
    static func enteredScreen(screenName: String) {
        callAsync {
            sendScreenView(screenName)
        }
    }

    static func countrySearched(country: String, forLanguage language: String) {
        callAsync {
            sendEvent("Search", action: "Country<\(country)|\(language)>", label: "\(country)|\(language)")
        }
    }
    
    static func citySearched(city: String, forLanguage language: String) {
        callAsync {
            sendEvent("Search", action: "City<\(city)|\(language)>", label: "\(city)|\(language)")
        }
    }
    
    static func usersPaginatedInCity(city: String, forLanguage language: String, andPage page: String) {
        callAsync {
            let label = "Pagination<City:\(city)|Language:\(language)|Page:\(page)"
            sendEvent("Scroll", action: label, label: label)
        }
    }

    static func usersPaginatedInCountry(country: String, forLanguage language: String, andPage page: String) {
        callAsync {
            let label = "Pagination<Country:\(country)|Language:\(language)|Page:\(page)"
            sendEvent("Scroll", action: label, label: label)
        }
    }
    
    static func usersPaginatedInWorld(forLanguage language: String, andPage page: String) {
        callAsync {
            let label = "Pagination<World|Language:\(language)|Page:\(page)"
            sendEvent("Scroll", action: label, label: label)
        }
    }

    static func userSearched(login: String) {
        callAsync {
            sendEvent("Search", action: "User<\(login)>", label: login)
        }
    }
    
    static func viewUserOnGithub(login: String) {
        callAsync {
            sendEvent("Show", action: "UserGithub<\(login)>", label: login)
        }
    }
    
    static func viewUserLanguagesOnGithub(login: String, language: String) {
        callAsync {
            sendEvent("Show", action: "User<\(login)>Repositories<\(language)>", label: "\(login)-\(language)")
        }
    }
    
    static func searchedTrending(trendingScope: String, language: String) {
        callAsync {
            sendEvent("Search", action: "Trending<\(trendingScope)>Language<\(language)>", label: "Trending<\(trendingScope)>Language<\(language)>")
        }
    }
    
    private static func callAsync(closure: () -> ()) {
        dispatch_async(dispatch_get_global_queue(qos, 0)) {
            closure()
        }
    }
    
    private static func sendScreenView(screenName: String) {
        executeIfRelease {
            tracker.set(kGAIScreenName, value: screenName)
            let builder = GAIDictionaryBuilder.createScreenView()
            tracker.send(builder.build() as [NSObject : AnyObject])
        }
    }
    
    private static func sendEvent(category: String, action: String, label: String) {
        executeIfRelease {
            let builder = GAIDictionaryBuilder.createEventWithCategory(category, action: action, label: label, value: nil)
            tracker.send(builder.build() as [NSObject : AnyObject])
        }
    }
    
    private static func executeIfRelease(action: Void -> Void = {}) {
        #if RELEASE
            action()
        #endif
    }
}
