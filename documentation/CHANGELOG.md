# Entity Relationship Diagram

## High-level overview

- Added `Point` table.
- Added `UserSession` table.
- Renamed `PricingScheme` table to `Pricing`.
- Renamed `Charge` table to `ChargeSession`.
- Removed `Card` table.
- Removed `UserCar` table.
- Removed `ChargeEvents` table.

## Detailed overview

### ChargeSession

- Replaced `station_id` with `point_id`.
    - One-to-Many relationship with `Point` table.
- Add `payment` field.
    - Enum {Card,Cash}
- Add `protocol` field.
    - Enum {Wired,Wireless}
- Removed `card_id`.
- Renamed `start_time` to `start`.
- Renamed `completed_time` to `end`.
- Renamed `total_energy` to `energy_delivered`.

### UserSession

- Created Table.
- Fields
    - `id`: Primary key, integer.
    - `user_id`: Foreign key, `User` table.
    - `token`: String.
    - `expires`: Datetime.

### Point

- Created Table.
- Fields
    - `id`: Primary key, integer.
    - `station_id`: Foreign key, `Station` table.

### Station

- Added field `operator`.
- Removed field `slots`.

### Car

- Added field `type`.
- Added field `user_id`.
    - One to many relationship between User and Car tables.
