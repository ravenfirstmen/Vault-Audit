# Audit events structure


```
{
    "time": "2023-11-02T22:32:36.640232094Z",  // The date and time when the event occurred, typically in ISO 8601 format.
    "type": "response", // "request" or "response"
    "auth": {
        ...
        "display_name": "admin-approle", // fancy name
        "policies": [ // All policies associated with authenticated token
            "default",
            "vault-admin-approle-policy"
        ],
        "token_policies": [ // Policies associated only with authenticated token
            "default",
            "vault-admin-approle-policy"
        ],
        "metadata": { // usualy metadata passed during the request
            "role_name": "admin"
        },
        "entity_id": "7c3d2fe9-3665-e5f3-7c9e-8ae125c6f3f5", // backend authenticated entity 
        "token_type": "service", // type of token "batch" or "service"
        "token_ttl": 2764800 // Max age of the token
    },
    "request": {
        "id": "d7d8b670-6cb0-f3bb-6c4e-1c174b01a4c8", // the id of the request and serve to correlate with responses
        "client_id": "0DHqvq2D77kL2/JTPSZkTMJbkFVmUu0TzMi0jiXcFy8=", 
        "operation": "update", // type of operation create/update/delete,etc...
        "mount_point": "auth/admin-approle/", // engine accessed
        "mount_type": "approle", // type of the mount 
        "mount_accessor": "auth_approle_8e3308f6", // the acessor for the entity (related the auth method with entity)
        "mount_running_version": "v1.15.1+builtin.vault", // version of vault
        "mount_class": "auth", // "secrets" or "auth"
        ...
        "path": "auth/admin-approle/login", // the path accessed
        "data": { // data send in request
            "role_id": ...
            "secret_id": ...
        },
        "remote_address": "127.0.0.1", // ip who request
        "remote_port": 45120 // port
    },
    "response": {
        "auth": {
            ....
            "display_name": "admin-approle",
            "policies": [ // All policies associated with authenticated token
                "default",
                "vault-admin-approle-policy"
            ],
            "token_policies": [ // Policies associated only with authenticated token
                "default",
                "vault-admin-approle-policy"
            ],
            "metadata": {
                "role_name": "admin"
            },
            "entity_id": "7c3d2fe9-3665-e5f3-7c9e-8ae125c6f3f5", // backend authenticated entity 
            "token_type": "service",  // type of token "batch" or "service"
            "token_ttl": 2764800
        },
        "mount_point": "auth/admin-approle/",
        "mount_type": "approle",
        "mount_accessor": "auth_approle_8e3308f6",
        ...
        "mount_class": "auth",
        errors:[
            // list of errors 
        ] 
    }
}
```

# Sample of queries (jq based)

https://developer.hashicorp.com/vault/tutorials/monitoring/query-audit-device-logs

# More samples

https://github.com/hashicorp-education/learn-vault-monitoring/blob/main/vault-audit.log
https://developer.hashicorp.com/vault/tutorials/monitoring/troubleshooting-vault#audit-logs

