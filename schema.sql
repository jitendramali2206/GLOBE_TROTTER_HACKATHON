CREATE TABLE users (
  id            SERIAL PRIMARY KEY,
  email         VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at    TIMESTAMP DEFAULT NOW()
);

CREATE TABLE trips (
  id            SERIAL PRIMARY KEY,
  user_id       INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  name          VARCHAR(255) NOT NULL,
  description   TEXT,
  start_date    DATE NOT NULL,
  end_date      DATE NOT NULL,
  cover_emoji   VARCHAR(8),
  is_public     BOOLEAN DEFAULT FALSE,
  share_slug    VARCHAR(32) UNIQUE,
  created_at    TIMESTAMP DEFAULT NOW()
);

CREATE TABLE stops (
  id            SERIAL PRIMARY KEY,
  trip_id       INTEGER NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
  city          VARCHAR(255) NOT NULL,
  country       VARCHAR(255),
  start_date    DATE,
  end_date      DATE,
  sort_order    INTEGER DEFAULT 0
);

CREATE TABLE activities (
  id            SERIAL PRIMARY KEY,
  stop_id       INTEGER NOT NULL REFERENCES stops(id) ON DELETE CASCADE,
  name          VARCHAR(255) NOT NULL,
  category      VARCHAR(50) NOT NULL,  -- Sightseeing, Food, Transport, Lodging, Activity, Shopping, Other
  cost          NUMERIC(10,2) DEFAULT 0,
  date          DATE,
  time          TIME,
  notes         TEXT
);

-- Discovery catalog (destinations/activities users can search & add)
CREATE TABLE catalog_destinations (
  id      SERIAL PRIMARY KEY,
  city    VARCHAR(255) NOT NULL,
  country VARCHAR(255) NOT NULL
);

CREATE TABLE catalog_activities (
  id             SERIAL PRIMARY KEY,
  destination_id INTEGER REFERENCES catalog_destinations(id),
  name           VARCHAR(255) NOT NULL,
  category       VARCHAR(50),
  est_cost       NUMERIC(10,2)
);
