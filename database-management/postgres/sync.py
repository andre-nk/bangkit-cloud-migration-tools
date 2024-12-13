import psycopg2
import requests
import datetime
import subprocess
import sys
import os
import time
from decimal import Decimal
import datetime

def install_requirements():
    required_modules = ["psycopg2", "requests"]
    for module in required_modules:
        try:
            __import__(module)
        except ImportError:
            print(f"Module '{module}' not found. Installing...")
            subprocess.check_call([sys.executable, "-m", "pip", "install", module])

install_requirements()

postgres_config = {
    "dbname": "portier",
    "user": "postgres",
    "password": "postgres",
    "host": os.getenv("POSTGRES_HOST", "postgres"),
    "port": 5432,
}

meilisearch_url = f"http://{os.getenv('MEILISEARCH_HOST', 'meilisearch')}:7700"
meilisearch_master_key = os.getenv("MEILI_MASTER_KEY", "um_gjlsyTHkt3bCA4GH19boGGq_jdjiwvqaquutamL8")

def datetime_converter(value):
    if isinstance(value, datetime.datetime):
        return value.isoformat()
    elif isinstance(value, Decimal):
        return float(value)
    return value

tables_to_index = [
    "access", "building", "copy", "cylinder", "cylinderhistory",
    "key", "staff", "door"
]

def fetch_table_data(table_name):
    conn = psycopg2.connect(**postgres_config)
    cursor = conn.cursor()
    
    query = f"SELECT * FROM dbo.\"{table_name}\""
    cursor.execute(query)
    rows = cursor.fetchall()
    column_names = [desc[0].lower() for desc in cursor.description]
    
    cursor.close()
    conn.close()
    
    return [
        {column_names[i]: datetime_converter(row[i]) for i in range(len(row))}
        for row in rows
    ]

def create_or_index_meilisearch(table_name, documents, primary_key):
    index_name = f"{table_name}_index"
    url = f"{meilisearch_url}/indexes/{index_name}/documents"
    headers = {"Authorization": f"Bearer {meilisearch_master_key}"}
    
    create_index_url = f"{meilisearch_url}/indexes"
    payload = {
        "uid": index_name,
        "primaryKey": primary_key
    }
    
    response = requests.post(create_index_url, json=payload, headers=headers)
    if response.status_code == 201:
        print(f"Index '{index_name}' created with primary key '{primary_key}'")
    elif response.status_code == 409:
        print(f"Index '{index_name}' already exists.")
    
    try:
        response = requests.post(url, json=documents or [], headers=headers)
        if response.status_code == 202:
            print(f"Documents for table '{table_name}' indexed successfully.")
        else:
            print(f"Failed to index documents for table '{table_name}': {response.text}")
    except requests.exceptions.RequestException as e:
        print(f"Error indexing {table_name}: {e}")

def sync(table_name=None):
    if table_name:
        tables_to_index = [table_name]
    
    for table_name in tables_to_index:
        primary_key = {
            "access": "zugriff_id",
            "building": "gebaeude_id",
            "copy": "exemplar_id",
            "cylinder": "zylinder_id",
            "cylinderhistory": "zylinder_id",
            "key": "schluessel_id",
            "staff": "personal_id",
            "door": "tuer_id"
        }.get(table_name, None)

        if not primary_key:
            print(f"No primary key defined for table {table_name}")
            continue

        documents = fetch_table_data(table_name)
        result = create_or_index_meilisearch(table_name, documents, primary_key)
        if result:
            print(f"Indexed {table_name} successfully: {result}")
        else:
            print(f"Failed to index {table_name}")

def listen_for_changes():
    conn = psycopg2.connect(**postgres_config)
    conn.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_AUTOCOMMIT)
    cursor = conn.cursor()

    cursor.execute("LISTEN sync_notify;")
    print("Listening for changes...")

    try:
        while True:
            conn.poll()

            while conn.notifies:
                notify = conn.notifies.pop()
                payload = notify.payload.split(":")
                table_name = payload[0]
                operation = payload[1]

                if operation in ["INSERT", "UPDATE"]:
                    print(f"Received {operation} notification: {table_name}")
                    sync(table_name)
                
            time.sleep(1)
    except KeyboardInterrupt:
        print("Listening stopped.")
    finally:
        cursor.close()
        conn.close()

def create_indexes_on_startup():
    for table_name in tables_to_index:
        primary_key = {
            "access": "zugriff_id",
            "building": "gebaeude_id",
            "copy": "exemplar_id",
            "cylinder": "zylinder_id",
            "cylinderhistory": "zylinder_id",
            "key": "schluessel_id",
            "staff": "personal_id",
            "door": "tuer_id"
        }.get(table_name, None)

        if not primary_key:
            print(f"No primary key defined for table {table_name}")
            continue
        
        documents = fetch_table_data(table_name)
        create_or_index_meilisearch(table_name, documents, primary_key)

def main():
    create_indexes_on_startup()

    listen_for_changes()

if __name__ == "__main__":
    main()
