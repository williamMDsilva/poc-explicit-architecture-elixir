## **Send Notification to all subscribers**

### **Endpoint**

- **URI**: `http://localhost:4000/api/notification/send/:push_token`
- **Method**: `POST`

### **Description**

This route send a notification to all subscriber in database

### **Headers**

- `access_token`: `<access_token>` (required)
- `Content-Type`: `application/json`

### **Query Parameters**

List any query parameters that can be passed in the URL.
| Parameter | Type | Description |
|-----------|--------|------------------------------|
| `-` | string | - |

### **Path Parameters**

List any path parameters that are part of the URL.
| Parameter | Type | Required | Description |
|-----------|--------|----------|------------------------------|
| `push_token` | string | Yes | With **all** will send a message to all subscribers. With expo token will send just to this subiscriber

### **Request Body**

Body parameters.
| Parameter | Type | Description |
|-----------|--------|------------------------------|
| `body` | string | body of the message (required) |
| `title` | string | title of the message (required) |

- **Content-Type**: `application/json`

```json
{
  "body": "you has been notified",
  "title": "hey!"
}
```

### **Response**

If the request has success, the endpoint will return 201

#### **Success Response**

- **Status**: `200 OK`

```json
{ "response": {...} }
```

```json
{ "response": "empty" }
```

#### **Error Responses**

- **Status**: `401 Unauthorized`

```json
{
  "error": "unauthorized",
  "message": "Check the access_token on header"
}
```

- **Status**: `400 Bad Request`

```json
{
  "error": "invalid_data",
  "message": "Check the token provide by expo"
}
```

- **Status**: `500 Internal Server Error`

```json
{
  "error": "error_server",
  "message": "Something went wrong!"
}
```

### **Examples**

#### **cURL**

To send notification to all

```bash
curl -X POST "http://localhost:4000/api/notification/send/all" \
-H "access_token: <access_token>" \
-H "Content-Type: application/json" \
-d '{
    "body": "you has been notified",
    "title": "hey!"
    }'
```

To send notification to some token

```bash
curl -X POST "http://localhost:4000/api/notification/send/asdaf123[12345afsd]" \
-H "access_token: <access_token>" \
-H "Content-Type: application/json" \
-d '{
    "body": "you has been notified",
    "title": "hey!"
    }'
```

#### **JavaScript (Fetch API)**

```javascript
fetch("http://localhost:4000/api/notification/send/all", {
  method: "POST",
  headers: {
    access_token: "<access_token>",
    "Content-Type": "application/json",
  },
  body: JSON.stringfy({
    body: "you has been notified",
    title: "hey!",
  }),
})
  .then((response) => response.json())
  .then((data) => console.log(data))
  .catch((error) => console.error("Error:", error));
```

```javascript
fetch("http://localhost:4000/api/notification/send/asdaf123[12345afsd]", {
  method: "POST",
  headers: {
    access_token: "<access_token>",
    "Content-Type": "application/json",
  },
  body: JSON.stringfy({
    body: "you has been notified",
    title: "hey!",
  }),
})
  .then((response) => response.json())
  .then((data) => console.log(data))
  .catch((error) => console.error("Error:", error));
```

### **Notes**

---
