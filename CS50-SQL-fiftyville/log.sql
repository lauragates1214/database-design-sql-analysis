-- Keep a log of any SQL queries you execute as you solve the mystery.
-- get crime scene report from Humphrey Street on July 28, 2021
SELECT csr.description
  FROM crime_scene_reports AS csr
 WHERE csr.year = 2021
   AND csr.month = 7
   AND csr.day = 28
   AND csr.street LIKE "Humphrey%";
   -- relevant info retrieved:
      -- theft at 10:15am from Humphrey St bakery
      -- interviews w 3 witnesses who were present at time
      -- each interview mentions the bakery
      -- ACTION retrieve interviews

-- retrieve interviewee name and transcript from same day with "bakery" in transcript
SELECT i.name,
       i.transcript
  FROM interviews AS i
 WHERE i.year = 2021
   AND i.month = 7
   AND i.day = 28
   AND i.transcript LIKE "%bakery%";
   -- relevant info retrieved:
      -- Ruth: within 10 minutes of theft, thief got into car in bakery parking lot & drove away
         -- ACTION check security footage between 10:15-10:25am
      -- Eugene: recognized the thief from ATM on Leggett Street withdrawing money earlier that morning
         -- ACTION check atm withdrawals before 10:15am
         -- Emma owns bakery (relevant?)
      -- Raymond: as thief left bakery, called someone. Call info:
         -- less than a minute
         -- thief said planning to take earliest flight out of Fiftyville tomorrow (29 July 2021)
         -- asked person on phone to purchase flight ticket
         -- ACTION retrieve call logs, flight & passenger info
            -- how get flight purchase info? maybe just proof that it's accomplice

-- retrieve name of thief
SELECT p.name
  FROM people AS p
 WHERE p.license_plate IN
       -- retrieve license plate from security logs leaving bakery within 10 minutes of theft
       (SELECT bsl.license_plate
          FROM bakery_security_logs AS bsl
          -- year and month all 2021 and 7 respectively, so just use day
          WHERE bsl.day = 28
            AND bsl.hour = 10
            AND bsl.minute BETWEEN 15 AND 25)
            -- returns 8 results
   -- narrow down by id of person who made a withdrawal from the relevant atm on the relevant date
   AND p.id IN
       (SELECT ba.person_id
          FROM bank_accounts AS ba
         WHERE ba.account_number IN
               (SELECT atm.account_number
                  FROM atm_transactions AS atm
                  -- year all 2021 so only use month and day
                 WHERE atm.month = 7
                   AND atm.day = 28
                   AND atm.transaction_type = "withdraw"
                   AND atm.atm_location = "Leggett Street"))
                   --narrows down to 4
    -- narrow down by phone number of caller that morning
    AND p.phone_number IN
        (SELECT pc.caller
           FROM phone_calls AS pc
           -- year and month all 2021 and 7 respectively, so just use day
          WHERE pc.day = 28
            AND pc.duration < 60)
            -- narrows down to 2
    -- narrow down by passport number of person on earliest flight next morning
    AND p.passport_number IN
        (SELECT p1.passport_number
           FROM passengers AS p1
          WHERE p1.flight_id IN
                (SELECT f.id
                   FROM flights AS f
                    -- year and month all 2021 and 7 respectively, so just use day
                  WHERE f.day = 29
                    AND f.hour IN
                        (SELECT f.hour
                           FROM flights AS f
                          WHERE f.day = 29
                          ORDER BY f.hour
                          LIMIT 1)
                     AND f.minute IN
                         (SELECT f.minute
                            FROM flights AS f
                           WHERE f.day = 29
                           ORDER BY f.hour
                           LIMIT 1)));

-- retrieve city thief escaped to
SELECT a.city
  FROM airports AS a
 WHERE a.id IN
       -- retrieve destination airport of earliest flight the following day
       (SELECT f.destination_airport_id
          FROM flights AS f
          -- years and months 2021 and 7 respectively, so just use day
         WHERE f.day = 29
           AND f.hour IN
               (SELECT f.hour
                  FROM flights AS f
                 WHERE f.day = 29
                 ORDER BY f.hour
                 LIMIT 1)
           -- don't actually need to filter minutes but want to try for scenarios where there might be multiple
           -- flights in a one-hour range
           AND f.minute IN
               (SELECT f.minute
                  FROM flights AS f
                 WHERE f.day = 29
                 ORDER BY f.hour
                 LIMIT 1));

-- retrieve accomplice
SELECT p.name
  FROM people AS p
 WHERE p.phone_number IN
       -- retrieve call receiver for relevant phone call
       (SELECT pc.receiver
          FROM phone_calls AS pc
           -- year and month all 2021 and 7 respectively so just use day
         WHERE pc.day = 28
           AND pc.duration < 60
           AND pc.caller IN
               -- narrow down by caller as Bruce
               (SELECT p.phone_number
                  FROM people AS p
                 WHERE p.name = "Bruce"));







