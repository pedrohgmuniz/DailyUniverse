//
//  Post.swift
//  DailyUniverse
//
//  Created by Pedro Muniz on 17/10/22.
//

import Foundation

// 💡 This is an concrete type that models the posts data (abstract types are protocols in Swift. the rest is concrete).
struct Post: Codable {
    let title: String
    let date: String
    let explanation: String
    let hdurl: String // The first hdurl --> httaps://apod.nasa.gov/apod/image/2209/WR140_WebbSchmidt_960
    let url: String // The first url --> https://apod.nasa.gov/apod/image/2209/WR140_WebbSchmidt_960.jpg
    let media_type: String // ℹ️ This is for establishing if it's an image or YouTube video
    let copyright: String // ℹ️ This is for the credits whenever the day's image is copyrighted
    
    // 💡 Here is the raw data I got after my first call to the API
    // {"date":"2022-10-13","explanation":"What are those strange rings? Rich in dust, the rings are likely 3D shells -- but how they were created remains a topic of research.  Where they were created is well known: in a binary star system that lies about 6,000 light years away toward the constellation of the Swan (Cygnus) -- a system dominated by the Wolf-Rayet star WR 140.  Wolf-Rayet stars are massive, bright, and known for their tumultuous winds. They are also known for creating and dispersing heavy elements such as carbon  which is a building block of interstellar dust. The other star in the binary is also bright and massive -- but not as active.  The two great stars joust in an oblong orbit as they approach each other about every eight years. When at closest approach, the X-ray emission from the system increases, as, apparently, does the dust expelled into space -- creating another shell.  The featured infrared image by the new Webb Space Telescope resolves greater details and more dust shells than ever before.","hdurl":"https://apod.nasa.gov/apod/image/2209/WR140_WebbSchmidt_960.jpg","media_type":"image","service_version":"v1","title":"Dust Shells around WR 140 from Webb","url":"https://apod.nasa.gov/apod/image/2209/WR140_WebbSchmidt_960.jpg"}
    
    // 💡 Here is APOD's github repo:
    // https://github.com/nasa/apod-api
}
