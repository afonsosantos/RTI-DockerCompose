# RTI - Docker

## Setup

1. Change passwords and users

2. Change the IP address in `services/dashboard/Dockerfile`, lines **18** and **19**

3. Run `docker compose up` (`-d` for background)

## Port Mapping

- `8082:80` - API
- `8083:3000` - Dashboard
- `8084:3000` - Socket
- `3306:3306` - Database
