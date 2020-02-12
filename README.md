# docker-dynamodb-demo
Ejemplo simple de instancia DynamoDB Local sobre entorno Docker

## Para habilitar ambiente local

- Para crear una imagen docker local:
```
docker build -t db-dynlocal .
```

- Para lanzar imagen por defecto
```
docker run --rm -it --name db-dynlocal -p 8100:8000 amazon/dynamodb-local
```

- Para acceder a la interfaz web de DynamoDB Local
```
http://localhost:8100/shell/
```


## Crear Tabla

- Para crear tabla demo mediante interfaz web (API JS)

```
var params = {
    TableName: 'farm_family',
    KeySchema: [ // The type of of schema.  Must start with a HASH type, with an optional second RANGE.
        { // Required HASH type attribute
            AttributeName: 'farm_id',
            KeyType: 'HASH',
        },
        { // Optional RANGE key type for HASH + RANGE tables
            AttributeName: 'family_id', 
            KeyType: 'RANGE', 
        }
    ],
    AttributeDefinitions: [ // The names and types of all primary and index key attributes only
        {
            AttributeName: 'farm_id',
            AttributeType: 'S', // (S | N | B) for string, number, binary
        },
        {
            AttributeName: 'family_id',
            AttributeType: 'S', // (S | N | B) for string, number, binary
        }
        
        // ... more attributes ...
    ],
    ProvisionedThroughput: { // required provisioned throughput for the table
        ReadCapacityUnits: 1, 
        WriteCapacityUnits: 1, 
    },
    GlobalSecondaryIndexes: [ // optional (list of GlobalSecondaryIndex)
        { 
            IndexName: 'idx_farm_family', 
            KeySchema: [
                { // Required HASH type attribute
                    AttributeName: 'farm_id',
                    KeyType: 'HASH',
                },
                { // Optional RANGE key type for HASH + RANGE secondary indexes
                    AttributeName: 'family_id', 
                    KeyType: 'RANGE', 
                }
            ],
            Projection: { // attributes to project into the index
                ProjectionType: 'INCLUDE', // (ALL | KEYS_ONLY | INCLUDE)
                NonKeyAttributes: [ // required / allowed only for INCLUDE
                    'created_at',
                    // ... more attribute names ...
                ],
            },
            ProvisionedThroughput: { // throughput to provision to the index
                ReadCapacityUnits: 1,
                WriteCapacityUnits: 1,
            },
        },
        // ... more global secondary indexes ...
    ],
    /*
    LocalSecondaryIndexes: [ // optional (list of LocalSecondaryIndex)
        { 
            IndexName: 'index_farm_updated',
            KeySchema: [ 
                { // Required HASH type attribute - must match the table's HASH key attribute name
                    AttributeName: 'farm_id',
                    KeyType: 'HASH',
                },
                { // alternate RANGE key attribute for the secondary index
                    AttributeName: 'updated_at', 
                    KeyType: 'RANGE', 
                }
            ],
            Projection: { // required
                ProjectionType: 'INCLUDE', // (ALL | KEYS_ONLY | INCLUDE)
                NonKeyAttributes: [ // required / allowed only for INCLUDE
                    'updated_at',
                    // ... more attribute names ...
                ],
            },
        },
        // ... more local secondary indexes ...
    ],
    */
};
dynamodb.createTable(params, function(err, data) {
    if (err) ppJson(err); // an error occurred
    else ppJson(data); // successful response

});
```
