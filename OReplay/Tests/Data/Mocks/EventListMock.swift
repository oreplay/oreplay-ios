import Foundation

@testable import OReplay

struct EventListMock {
    static func dummyData(numberOfEvents: Int, totalEvents: Int? = nil) -> Data {
        let total = totalEvents != nil ? totalEvents! : numberOfEvents
        var string = "{\"data\": [ "
        
        for _ in 0..<numberOfEvents {
            string += eventString
        }
        
        string = String(string.dropLast(1))
        string += "], \"total\": \(String(total)), \"limit\": \(String(numberOfEvents))}"
        
        return string.toData
    }
    
    static var eventString: String {
    """
    {
        "id": "5f9c70c5-c211-4cdb-8ba2-f30715525752",
        "is_hidden": false,
        "description": "LEOP Galicia O Meeting - Baiona",
        "picture": null,
        "website": "https://razapalleira.com/i-galicia-o-meeting/",
        "scope": "nat",
        "location": null,
        "country_code": null,
        "initial_date": "2025-04-05",
        "final_date": "2025-04-06",
        "federation_id": null,
        "created": "2024-11-29T20:24:30.310+00:00",
        "modified": "2025-03-31T09:39:20.248+00:00",
        "organizer_id": "7f491f15-1245-4042-a70c-15199729e3c1",
        "organizer": {
            "id": "7f491f15-1245-4042-a70c-15199729e3c1",
            "name": "RAZA PALLEIRA",
            "country": "Spain",
            "region": "Galicia"
        },
        "_links": {
            "self": "https://www.oreplay.es/api/v1/events/5f9c70c5-c211-4cdb-8ba2-f30715525752"
        }
    },
    """
    }
}

let jsonString = """
    
        
        "total": 24,
        "limit": 20,
        "_links": {
            "self": {
                "href": "https://www.oreplay.es/api/v1/events?when=past&limit=20&page=1"
            },
            "next": {
                "href": "https://www.oreplay.es/api/v1/events?when=past&limit=20&page=2"
            }
        }
    }
    """
