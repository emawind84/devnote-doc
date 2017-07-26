Elasticsearch Reindex
==================================

Create the new index with the new mappings::

    PUT /sense
    {
    "mappings": {
        "stats": {
        "properties": {
            "acc_x": {
            "type": "float",
            "index": "not_analyzed"
            }
        }
        }
    }
    }

Reindex with the following request::

    POST /_reindex
    {
        "conflicts": "proceed",
        "source": {
            "index": "twitter"
        },
        "dest": {
            "index": "new_twitter",
            "version_type": "external",
            "op_type": "create"
        }
    }

Cancel the reindex task::

    GET /_tasks/?pretty&detailed=true&actions=*reindex
    POST /_tasks/{task_id}/_cancel

Create an alias to the new index::

    POST _aliases
    {
        "actions": [
            { "add": {
                "alias": "my_index",
                "index": "my_index_v1"
            }}
        ]
    }