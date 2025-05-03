import os
import csv
import pytest
from datetime import datetime
from scripts.generate_sample_data import generate_temperature_csv

@pytest.fixture 

def temp_csv_file(tmp_path):
    return str(tmp_path/"test_temperature_data.csv")

def test_generate_data_csv_file(temp_csv_file):
    generate_temperature_csv(temp_csv_file, num_records=10)
    assert os.path.isfile(temp_csv_file)

def test_generate_data_csv_create_file(temp_csv_file):
    generate_temperature_csv(temp_csv_file, num_records=10)
    assert os.path.exists(temp_csv_file)

def test_generate_data_csv_header(temp_csv_file):
    generate_temperature_csv(temp_csv_file, num_records=1)
    with open(temp_csv_file, 'r') as f:
        reader = csv.reader(f)
        header = next(reader)

        assert header == ['city','temperature', 'timestamp']

def test_generate_temperature_csv_content(temp_csv_file):
    num_Records = 5
    generate_temperature_csv(temp_csv_file, num_records=num_Records) 
    
    with open(temp_csv_file, 'r') as f:
        reader = csv.reader(f)
        next(reader)
        rows = list(reader)

        vaild_cities = ["New York", "London", "Tokyo","Paris","Sydney"]
        for row in rows:
            #test cities
            assert row[0] in vaild_cities
            
            #test for temp
            temp = float(row[1])
            assert 10 <= temp <=35
            timestamp = datetime.fromisoformat(row[2])
            assert isinstance(timestamp, datetime)

def test_generate_temperature_csv_different_sizes(temp_csv_file):
    test_sizes = [0,1,10,100]

    for size in test_sizes:
        generate_temperature_csv(temp_csv_file,num_records=size)
        with open(temp_csv_file, 'r') as f:
            reader = csv.reader(f)
            next(reader)
            rows= list(reader)
            assert len(rows) == size

def test_generate_temperature_csv_invalid(temp_csv_file):
    with pytest.raises(ValueError):
        generate_temperature_csv(temp_csv_file, num_records=-1)

def test_generate_temperature_csv_file_permissions(tmp_path):
    dir_path = tmp_path/"test_dir.csv"
    dir_path.mkdir()

    with pytest. raises(IOError):
        generate_temperature_csv(str(dir_path), num_records=1)



