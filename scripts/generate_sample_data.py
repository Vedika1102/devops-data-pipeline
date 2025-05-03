import os
import csv
import random
from datetime import datetime, timedelta
def generate_temperature_csv(filename, num_records=10000):
    if num_records<0 :
        raise ValueError('Number of must be positive')
    cities = ["New York", "London", "Tokyo","Paris","Sydney"]
    header = ["city", "temperature","timestamp"]

    os.makedirs(os.path.dirname(filename), exist_ok=True)

    try: 
        with open(filename, 'w', newline='') as f:
            writer = csv.writer (f)
            writer. writerow(header)

            for _ in range(num_records):
                city = random.choice(cities)
                temp = round(random.uniform(10, 35), 1)
                time = datetime.now() - timedelta(days=random.randint(0,365))

                writer.writerow([city, temp, time.strftime('%Y-%m-%d %H:%M:%S')])
    except (IOError, OSError) as e:
        raise IOError(f"Failed to generate csv file: {str(e)}")

if __name__ == "__main__":
    generate_temperature_csv("data/temperature_data.csv")    