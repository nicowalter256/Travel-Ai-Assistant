class StaticTravelData {
  static final List<Map<String, dynamic>> destinations = [
    {
      "id": "1",
      "name": "Paris, France",
      "country": "France",
      "image":
          "https://images.unsplash.com/photo-1502602898536-47ad22581b52?w=500",
      "description":
          "The City of Light, famous for its art, fashion, and cuisine",
      "category": "Cultural Tours",
      "rating": 4.8,
      "priceRange": "€800 - €2000",
      "duration": "5-7 days",
      "bestTime": "April - October",
      "highlights": [
        "Eiffel Tower",
        "Louvre Museum",
        "Notre-Dame",
        "Champs-Élysées"
      ],
      "pricing": {
        "budget": {
          "accommodation": "€50-80/night",
          "food": "€30-50/day",
          "activities": "€20-40/day",
          "transport": "€10-20/day",
          "total": "€800-1200"
        },
        "mid": {
          "accommodation": "€100-200/night",
          "food": "€60-100/day",
          "activities": "€50-80/day",
          "transport": "€20-40/day",
          "total": "€1200-2000"
        },
        "luxury": {
          "accommodation": "€300-500/night",
          "food": "€150-300/day",
          "activities": "€100-200/day",
          "transport": "€50-100/day",
          "total": "€2000-4000"
        }
      },
      "itinerary": [
        {
          "day": 1,
          "title": "Arrival & Montmartre",
          "activities": ["Check-in", "Sacré-Cœur", "Art galleries"]
        },
        {
          "day": 2,
          "title": "Historic Paris",
          "activities": ["Notre-Dame", "Sainte-Chapelle", "Latin Quarter"]
        },
        {
          "day": 3,
          "title": "Museums & Art",
          "activities": ["Louvre", "Tuileries Garden", "Orsay Museum"]
        },
        {
          "day": 4,
          "title": "Eiffel Tower & Seine",
          "activities": ["Eiffel Tower", "Seine cruise", "Champs-Élysées"]
        },
        {
          "day": 5,
          "title": "Versailles Day Trip",
          "activities": ["Palace of Versailles", "Gardens", "Return to Paris"]
        }
      ]
    },
    {
      "id": "2",
      "name": "Tokyo, Japan",
      "country": "Japan",
      "image":
          "https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=500",
      "description":
          "A perfect blend of traditional culture and modern innovation",
      "category": "Cultural Tours",
      "rating": 4.9,
      "priceRange": "¥120,000 - ¥300,000",
      "duration": "7-10 days",
      "bestTime": "March - May, September - November",
      "highlights": [
        "Senso-ji Temple",
        "Tokyo Skytree",
        "Shibuya Crossing",
        "Tsukiji Market"
      ],
      "pricing": {
        "budget": {
          "accommodation": "¥3000-6000/night",
          "food": "¥2000-4000/day",
          "activities": "¥1500-3000/day",
          "transport": "¥500-1000/day",
          "total": "¥120,000-180,000"
        },
        "mid": {
          "accommodation": "¥8000-15000/night",
          "food": "¥5000-10000/day",
          "activities": "¥3000-6000/day",
          "transport": "¥1000-2000/day",
          "total": "¥180,000-280,000"
        },
        "luxury": {
          "accommodation": "¥20000-40000/night",
          "food": "¥15000-30000/day",
          "activities": "¥8000-15000/day",
          "transport": "¥3000-6000/day",
          "total": "¥300,000-500,000"
        }
      },
      "itinerary": [
        {
          "day": 1,
          "title": "Arrival & Asakusa",
          "activities": [
            "Narita Express",
            "Senso-ji Temple",
            "Traditional dinner"
          ]
        },
        {
          "day": 2,
          "title": "Modern Tokyo",
          "activities": ["Tokyo Skytree", "Sumida River", "Akihabara"]
        },
        {
          "day": 3,
          "title": "Shibuya & Harajuku",
          "activities": ["Shibuya Crossing", "Meiji Shrine", "Takeshita Street"]
        },
        {
          "day": 4,
          "title": "Tsukiji & Ginza",
          "activities": ["Tsukiji Market", "Ginza shopping", "Imperial Palace"]
        },
        {
          "day": 5,
          "title": "Day Trip to Nikko",
          "activities": [
            "Nikko temples",
            "Natural hot springs",
            "Return to Tokyo"
          ]
        }
      ]
    },
    {
      "id": "3",
      "name": "Bali, Indonesia",
      "country": "Indonesia",
      "image":
          "https://images.unsplash.com/photo-1537953773345-d172ccf13cf1?w=500",
      "description":
          "Tropical paradise with stunning beaches, temples, and vibrant culture",
      "category": "Beach Getaways",
      "rating": 4.7,
      "priceRange": "\$400 - \$1200",
      "duration": "7-14 days",
      "bestTime": "April - October",
      "highlights": [
        "Ubud Rice Terraces",
        "Tanah Lot Temple",
        "Seminyak Beach",
        "Mount Batur"
      ],
      "pricing": {
        "budget": {
          "accommodation": "\$15-30/night",
          "food": "\$10-20/day",
          "activities": "\$15-30/day",
          "transport": "\$5-15/day",
          "total": "\$400-800"
        },
        "mid": {
          "accommodation": "\$50-100/night",
          "food": "\$30-60/day",
          "activities": "\$40-80/day",
          "transport": "\$20-40/day",
          "total": "\$800-1500"
        },
        "luxury": {
          "accommodation": "\$200-500/night",
          "food": "\$100-200/day",
          "activities": "\$100-200/day",
          "transport": "\$50-100/day",
          "total": "\$1500-3000"
        }
      },
      "itinerary": [
        {
          "day": 1,
          "title": "Arrival & Ubud",
          "activities": [
            "Airport transfer",
            "Ubud market",
            "Traditional massage"
          ]
        },
        {
          "day": 2,
          "title": "Rice Terraces & Temples",
          "activities": [
            "Tegallalang Rice Terraces",
            "Tirta Empul Temple",
            "Goa Gajah"
          ]
        },
        {
          "day": 3,
          "title": "Mount Batur Sunrise",
          "activities": [
            "Early morning hike",
            "Volcano breakfast",
            "Hot springs"
          ]
        },
        {
          "day": 4,
          "title": "Beach Day",
          "activities": ["Seminyak Beach", "Water sports", "Sunset dinner"]
        },
        {
          "day": 5,
          "title": "Tanah Lot & Canggu",
          "activities": ["Tanah Lot Temple", "Canggu surfing", "Beach clubs"]
        }
      ]
    },
    {
      "id": "4",
      "name": "New York City, USA",
      "country": "United States",
      "image":
          "https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=500",
      "description":
          "The city that never sleeps - iconic landmarks and endless entertainment",
      "category": "City Breaks",
      "rating": 4.6,
      "priceRange": "\$800 - \$2500",
      "duration": "5-7 days",
      "bestTime": "April - June, September - November",
      "highlights": [
        "Statue of Liberty",
        "Central Park",
        "Times Square",
        "Broadway"
      ],
      "pricing": {
        "budget": {
          "accommodation": "\$80-150/night",
          "food": "\$40-80/day",
          "activities": "\$30-60/day",
          "transport": "\$15-30/day",
          "total": "\$800-1400"
        },
        "mid": {
          "accommodation": "\$200-400/night",
          "food": "\$80-150/day",
          "activities": "\$60-120/day",
          "transport": "\$30-60/day",
          "total": "\$1400-2500"
        },
        "luxury": {
          "accommodation": "\$500-1000/night",
          "food": "\$200-400/day",
          "activities": "\$150-300/day",
          "transport": "\$60-120/day",
          "total": "\$2500-5000"
        }
      },
      "itinerary": [
        {
          "day": 1,
          "title": "Manhattan Arrival",
          "activities": ["JFK transfer", "Times Square", "Broadway show"]
        },
        {
          "day": 2,
          "title": "Central Park & Museums",
          "activities": ["Central Park", "Metropolitan Museum", "Guggenheim"]
        },
        {
          "day": 3,
          "title": "Statue of Liberty & 9/11",
          "activities": [
            "Liberty Island",
            "9/11 Memorial",
            "Financial District"
          ]
        },
        {
          "day": 4,
          "title": "Brooklyn & DUMBO",
          "activities": ["Brooklyn Bridge", "DUMBO", "Brooklyn Heights"]
        },
        {
          "day": 5,
          "title": "Shopping & Departure",
          "activities": ["Fifth Avenue", "SoHo", "Airport transfer"]
        }
      ]
    },
    {
      "id": "5",
      "name": "Santorini, Greece",
      "country": "Greece",
      "image":
          "https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=500",
      "description":
          "Stunning sunsets, white-washed buildings, and crystal-clear waters",
      "category": "Beach Getaways",
      "rating": 4.8,
      "priceRange": "€600 - €1800",
      "duration": "4-6 days",
      "bestTime": "May - October",
      "highlights": [
        "Oia Sunset",
        "Red Beach",
        "Ancient Thera",
        "Wine Tasting"
      ],
      "pricing": {
        "budget": {
          "accommodation": "€40-80/night",
          "food": "€25-50/day",
          "activities": "€20-40/day",
          "transport": "€10-25/day",
          "total": "€600-1000"
        },
        "mid": {
          "accommodation": "€100-200/night",
          "food": "€60-120/day",
          "activities": "€50-100/day",
          "transport": "€25-50/day",
          "total": "€1000-1800"
        },
        "luxury": {
          "accommodation": "€300-600/night",
          "food": "€150-300/day",
          "activities": "€100-200/day",
          "transport": "€50-100/day",
          "total": "€1800-3500"
        }
      },
      "itinerary": [
        {
          "day": 1,
          "title": "Arrival & Fira",
          "activities": ["Airport transfer", "Fira town", "Sunset dinner"]
        },
        {
          "day": 2,
          "title": "Oia & Sunset",
          "activities": ["Oia village", "Blue domes", "Famous sunset"]
        },
        {
          "day": 3,
          "title": "Beach Day",
          "activities": ["Red Beach", "Kamari Beach", "Water sports"]
        },
        {
          "day": 4,
          "title": "Wine Tour",
          "activities": ["Wine tasting", "Ancient Thera", "Traditional dinner"]
        },
        {
          "day": 5,
          "title": "Departure",
          "activities": ["Last minute shopping", "Airport transfer"]
        }
      ]
    },
    {
      "id": "6",
      "name": "Machu Picchu, Peru",
      "country": "Peru",
      "image":
          "https://images.unsplash.com/photo-1587595431973-160d0d94add1?w=500",
      "description": "Ancient Incan citadel high in the Andes Mountains",
      "category": "Adventure Sports",
      "rating": 4.9,
      "priceRange": "\$600 - \$1500",
      "duration": "4-6 days",
      "bestTime": "May - September",
      "highlights": [
        "Inca Trail",
        "Machu Picchu Ruins",
        "Huayna Picchu",
        "Sacred Valley"
      ],
      "pricing": {
        "budget": {
          "accommodation": "\$30-60/night",
          "food": "\$20-40/day",
          "activities": "\$40-80/day",
          "transport": "\$15-30/day",
          "total": "\$600-1000"
        },
        "mid": {
          "accommodation": "\$80-150/night",
          "food": "\$50-100/day",
          "activities": "\$80-150/day",
          "transport": "\$30-60/day",
          "total": "\$1000-1800"
        },
        "luxury": {
          "accommodation": "\$200-400/night",
          "food": "\$100-200/day",
          "activities": "\$150-300/day",
          "transport": "\$60-120/day",
          "total": "\$1800-3500"
        }
      },
      "itinerary": [
        {
          "day": 1,
          "title": "Cusco Arrival",
          "activities": [
            "Airport transfer",
            "Cusco city tour",
            "Acclimatization"
          ]
        },
        {
          "day": 2,
          "title": "Sacred Valley",
          "activities": [
            "Pisac market",
            "Ollantaytambo",
            "Train to Aguas Calientes"
          ]
        },
        {
          "day": 3,
          "title": "Machu Picchu",
          "activities": [
            "Early morning bus",
            "Machu Picchu tour",
            "Huayna Picchu hike"
          ]
        },
        {
          "day": 4,
          "title": "Return to Cusco",
          "activities": [
            "Train journey",
            "Cusco exploration",
            "Traditional dinner"
          ]
        },
        {
          "day": 5,
          "title": "Departure",
          "activities": ["Last minute shopping", "Airport transfer"]
        }
      ]
    }
  ];

  static const List<String> categories = [
    "All",
    "Beach Getaways",
    "City Breaks",
    "Cultural Tours",
    "Adventure Sports",
    "Nature & Wildlife",
    "Food & Wine",
    "Wellness Retreats"
  ];

  static final List<String> priceRanges = [
    "All",
    "Under \$1000",
    "\$1000 - \$2000",
    "\$2000 - \$3000",
    "\$3000+"
  ];

  static const List<String> durations = [
    "All",
    "1-3 days",
    "4-6 days",
    "7-10 days",
    "10+ days"
  ];
}
