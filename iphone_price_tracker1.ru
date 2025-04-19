import requests
from bs4 import BeautifulSoup

CATEGORIES = [
    "iphone", "ipad", "macbook", "apple-watch",
    "airpods", "apple-pencil", "apple-mouse", "playstation", "dyson"
]

BASE_URL = "https://killprice24.ru/catalog/"

def fetch_prices():
    for category in CATEGORIES:
        url = f"{BASE_URL}{category}"
        response = requests.get(url)
        if response.status_code == 200:
            soup = BeautifulSoup(response.text, 'html.parser')
            items = soup.select('.product-card')
            print(f"--- {category.upper()} ---")
            for item in items:
                title = item.select_one('.product-title').text.strip()
                price = item.select_one('.price').text.strip()
                print(f"{title} — {price}")
        else:
            print(f"Failed to fetch {category}")

if __name__ == "__main__":
    fetch_prices()
