# Meeting Rooms Reservation API

A simple **Rails API** for managing rooms and reservations, designed for scheduling meetings without conflicts. Demonstrates **ActiveRecord associations, validations, nested routes, and custom business logic**.  

---

## 🏗️ Tech Stack

- **Backend:** Ruby on Rails
- **Database:** SQLite (default for Rails) 
- **API:** JSON REST endpoints  

---

## 🔹 Models

### Room

Represents a meeting room.

| Column | Type | Notes |
|--------|------|-------|
| id     | integer | Primary key |
| name   | string  | Required |

**Validations:**

- `name` must be present  
- `has_many :reservations, dependent: :destroy` association  

---

### Reservation

Represents a booking for a room.

| Column       | Type     | Notes |
|--------------|---------|-------|
| id           | integer | Primary key |
| room_id      | integer | Foreign key to Room |
| reserved_by  | string  | Name of the person reserving |
| start_time   | datetime | Reservation start |
| end_time     | datetime | Reservation end |


**Validations:**

1. **Presence validations:** `reserved_by`, `start_time`, `end_time`  
2. **Custom validations:**  
   - `validate_time_order`: Ensures `end_time` is after `start_time`  
   - `no_time_conflicts`: Prevents overlapping reservations in the same room  

---

## 📦 API Endpoints

### Rooms (CRUD)

| Method | Endpoint       | Description |
|--------|---------------|-------------|
| GET    | `/rooms`      | List all rooms |
| POST   | `/rooms`      | Create a new room |
| GET    | `/rooms/:id`  | Show a specific room |
| PUT | `/rooms/:id` | Update an existing room |
| DELETE | `/rooms/:id`  | Delete a room and its reservations |

### Reservations (Nested under Rooms)

| Method | Endpoint                         | Description |
|--------|---------------------------------|-------------|
| GET    | `/rooms/:room_id/reservations`   | List all reservations for a room |
| POST   | `/rooms/:room_id/reservations`   | Create a new reservation |
| GET    | `/rooms/:room_id/reservations/:id` | Show a specific reservation |
| DELETE | `/rooms/:room_id/reservations/:id` | Cancel a reservation |


---
 ## 📬 Sample JSON Requests & Responses

### Rooms

**Create a Room**
```json
POST /rooms
{
  "room": {
    "name": "Conference Room A"
  }
}
```

 

**Update a Room**
```json
PUT /rooms/1
{
  "room": {
    "name": "Conference Room B"
  }
}
```
**Delete a Room**

```json
 DELETE /rooms/1
 ```

**Create a Reservation**
 ```json
 POST /rooms/1/reservations
{
  "reservation": {
    "reserved_by": "Alice",
    "start_time": "2026-03-20T14:00:00-05:00",
    "end_time": "2026-03-20T15:00:00-05:00"
  }
}
```
**Delete a Reservation**

```json
DELETE /rooms/1/reservations/1
```

**Overlapping Reservations**

**First Reservation**

```json
{
  "reservation": {
    "reserved_by": "Alice",
    "start_time": "2026-03-20T14:00:00-05:00",
    "end_time": "2026-03-20T15:00:00-05:00"
  }
}
```
**Second Reservation overlaps first Reservation**
```json
POST /rooms/1/reservations
{
  "reservation": {
    "reserved_by": "Bob",
    "start_time": "2026-03-20T14:30:00-05:00",
    "end_time": "2026-03-20T15:30:00-05:00"
  }
}
```
 
**Reponse** 
```json

{
    "errors": [
        "Room already booked at this time."
    ]
}
```
**Bad Reservation (start time is not before end time)**
```json

POST /rooms/1/reservations
{
  "reservation": {
    "reserved_by": "Charlie",
    "start_time": "2026-03-20T15:00:00-05:00",
    "end_time": "2026-03-20T14:00:00-05:00"
  }
}

```
```json
{
    "errors": [
        "End time must be after start time."
    ]
}
```
