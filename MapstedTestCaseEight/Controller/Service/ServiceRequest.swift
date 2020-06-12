//
//  ServiceRequest.swift
//  MapstedTestCaseEight
//
//  Created by Rafael Cunha de Oliveira on 2020-06-11.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation
import Alamofire

enum RequestUrlType: String { // enum of urls to avoid strings on code
    case analyticData = "http://positioning-test.mapsted.com/api/Values/GetAnalyticData/"
    case buildingData = "http://positioning-test.mapsted.com/api/Values/GetBuildingData/"
}

class ServiceRequest {

    let decoder = JSONDecoder()

    //MARK: - Requests
    //Requests using Alamofire

    func getBuildingData(success: @escaping([BuildingInfo]) -> Void,
                         failure: @escaping(Error) -> Void) {
        guard let url = URL(string: RequestUrlType.buildingData.rawValue) else { return }
        AF.request(url).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    success(try self.decoder.decode([BuildingInfo].self, from: data))
                } catch {
                    print(error)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }

    func getAnalyticsData(success: @escaping([Analytic]) -> Void,
                         failure: @escaping(Error) -> Void) {
        guard let url = URL(string: RequestUrlType.analyticData.rawValue) else { return }
        AF.request(url).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    success(try self.decoder.decode([Analytic].self, from: data))
                } catch {
                    print(error)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
}
