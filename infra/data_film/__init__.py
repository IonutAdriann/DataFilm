from azure.cosmos import CosmosClient

# Initialize Cosmos DB client
endpoint = "https://eddie-db.documents.azure.com:443/"
key = "AsrbkVIF7bbfNsUSrC1WM2fJ44JG60qnPZQfMywGpbep3UrCKyl2d0DkfVsidfB9EwAO9Hmxh7E7ACDbrUendA=="
client = CosmosClient(endpoint, key)

# Create database and container
database_name = "datafilm-db"
container_name = "container2"
database = client.create_database_if_not_exists(id=database_name)
container = database.create_container_if_not_exists(id=container_name, partition_key="/partition_key_path")

# Insert data into Cosmos DB
data = {"id": "1", "title": "Titanic", "genre": "Drama"}
container.create_item(body=data)

# Implement Function App with Python to retrieve data
def get_movies(context, req):
    query = "SELECT * FROM c"
    items = container.query_items(query=query, enable_cross_partition_query=True)
    movies = [item for item in items]
    return {
        "status": 200,
        "body": movies,
        "headers": {
            "Content-Type": "application/json"
        }
    }
