import * as $int from "../../../gleam_stdlib/gleam/int.mjs";
import * as $order from "../../../gleam_stdlib/gleam/order.mjs";
import { Ok, Error, CustomType as $CustomType } from "../../gleam.mjs";
import * as $duration from "../../gleam/time/duration.mjs";
import { local_time_offset_seconds } from "../../gleam_time_ffi.mjs";

export class Date extends $CustomType {
  constructor(year, month, day) {
    super();
    this.year = year;
    this.month = month;
    this.day = day;
  }
}
export const Date$Date = (year, month, day) => new Date(year, month, day);
export const Date$isDate = (value) => value instanceof Date;
export const Date$Date$year = (value) => value.year;
export const Date$Date$0 = (value) => value.year;
export const Date$Date$month = (value) => value.month;
export const Date$Date$1 = (value) => value.month;
export const Date$Date$day = (value) => value.day;
export const Date$Date$2 = (value) => value.day;

export class TimeOfDay extends $CustomType {
  constructor(hours, minutes, seconds, nanoseconds) {
    super();
    this.hours = hours;
    this.minutes = minutes;
    this.seconds = seconds;
    this.nanoseconds = nanoseconds;
  }
}
export const TimeOfDay$TimeOfDay = (hours, minutes, seconds, nanoseconds) =>
  new TimeOfDay(hours, minutes, seconds, nanoseconds);
export const TimeOfDay$isTimeOfDay = (value) => value instanceof TimeOfDay;
export const TimeOfDay$TimeOfDay$hours = (value) => value.hours;
export const TimeOfDay$TimeOfDay$0 = (value) => value.hours;
export const TimeOfDay$TimeOfDay$minutes = (value) => value.minutes;
export const TimeOfDay$TimeOfDay$1 = (value) => value.minutes;
export const TimeOfDay$TimeOfDay$seconds = (value) => value.seconds;
export const TimeOfDay$TimeOfDay$2 = (value) => value.seconds;
export const TimeOfDay$TimeOfDay$nanoseconds = (value) => value.nanoseconds;
export const TimeOfDay$TimeOfDay$3 = (value) => value.nanoseconds;

export class January extends $CustomType {}
export const Month$January = () => new January();
export const Month$isJanuary = (value) => value instanceof January;

export class February extends $CustomType {}
export const Month$February = () => new February();
export const Month$isFebruary = (value) => value instanceof February;

export class March extends $CustomType {}
export const Month$March = () => new March();
export const Month$isMarch = (value) => value instanceof March;

export class April extends $CustomType {}
export const Month$April = () => new April();
export const Month$isApril = (value) => value instanceof April;

export class May extends $CustomType {}
export const Month$May = () => new May();
export const Month$isMay = (value) => value instanceof May;

export class June extends $CustomType {}
export const Month$June = () => new June();
export const Month$isJune = (value) => value instanceof June;

export class July extends $CustomType {}
export const Month$July = () => new July();
export const Month$isJuly = (value) => value instanceof July;

export class August extends $CustomType {}
export const Month$August = () => new August();
export const Month$isAugust = (value) => value instanceof August;

export class September extends $CustomType {}
export const Month$September = () => new September();
export const Month$isSeptember = (value) => value instanceof September;

export class October extends $CustomType {}
export const Month$October = () => new October();
export const Month$isOctober = (value) => value instanceof October;

export class November extends $CustomType {}
export const Month$November = () => new November();
export const Month$isNovember = (value) => value instanceof November;

export class December extends $CustomType {}
export const Month$December = () => new December();
export const Month$isDecember = (value) => value instanceof December;

/**
 * The offset for the [Coordinated Universal Time (UTC)](https://en.wikipedia.org/wiki/Coordinated_Universal_Time)
 * time zone.
 *
 * The utc zone has no time adjustments, it is always zero. It never observes
 * daylight-saving time and it never shifts around based on political
 * restructuring.
 */
export const utc_offset = $duration.empty;

/**
 * Get the offset for the computer's currently configured time zone.
 *
 * Note this may not be the time zone that is correct to use for your user.
 * For example, if you are making a web application that runs on a server you
 * want _their_ computer's time zone, not yours.
 *
 * This is the _current local_ offset, not the current local time zone. This
 * means that while it will result in the expected outcome for the current
 * time, it may result in unexpected output if used with other timestamps. For
 * example: a timestamp that would locally be during daylight savings time if
 * is it not currently daylight savings time when this function is called.
 */
export function local_offset() {
  return $duration.seconds(local_time_offset_seconds());
}

/**
 * Returns the English name for a month.
 *
 * # Examples
 *
 * ```gleam
 * month_to_string(April)
 * // -> "April"
 * ```
 */
export function month_to_string(month) {
  if (month instanceof January) {
    return "January";
  } else if (month instanceof February) {
    return "February";
  } else if (month instanceof March) {
    return "March";
  } else if (month instanceof April) {
    return "April";
  } else if (month instanceof May) {
    return "May";
  } else if (month instanceof June) {
    return "June";
  } else if (month instanceof July) {
    return "July";
  } else if (month instanceof August) {
    return "August";
  } else if (month instanceof September) {
    return "September";
  } else if (month instanceof October) {
    return "October";
  } else if (month instanceof November) {
    return "November";
  } else {
    return "December";
  }
}

/**
 * Returns the number for the month, where January is 1 and December is 12.
 *
 * # Examples
 *
 * ```gleam
 * month_to_int(January)
 * // -> 1
 * ```
 */
export function month_to_int(month) {
  if (month instanceof January) {
    return 1;
  } else if (month instanceof February) {
    return 2;
  } else if (month instanceof March) {
    return 3;
  } else if (month instanceof April) {
    return 4;
  } else if (month instanceof May) {
    return 5;
  } else if (month instanceof June) {
    return 6;
  } else if (month instanceof July) {
    return 7;
  } else if (month instanceof August) {
    return 8;
  } else if (month instanceof September) {
    return 9;
  } else if (month instanceof October) {
    return 10;
  } else if (month instanceof November) {
    return 11;
  } else {
    return 12;
  }
}

/**
 * Returns the month for a given number, where January is 1 and December is 12.
 *
 * # Examples
 *
 * ```gleam
 * month_from_int(1)
 * // -> Ok(January)
 * ```
 */
export function month_from_int(month) {
  if (month === 1) {
    return new Ok(new January());
  } else if (month === 2) {
    return new Ok(new February());
  } else if (month === 3) {
    return new Ok(new March());
  } else if (month === 4) {
    return new Ok(new April());
  } else if (month === 5) {
    return new Ok(new May());
  } else if (month === 6) {
    return new Ok(new June());
  } else if (month === 7) {
    return new Ok(new July());
  } else if (month === 8) {
    return new Ok(new August());
  } else if (month === 9) {
    return new Ok(new September());
  } else if (month === 10) {
    return new Ok(new October());
  } else if (month === 11) {
    return new Ok(new November());
  } else if (month === 12) {
    return new Ok(new December());
  } else {
    return new Error(undefined);
  }
}

/**
 * Determines if a given year is a leap year.
 *
 * A leap year occurs every 4 years, except for years divisible by 100,
 * unless they are also divisible by 400.
 *
 * # Examples
 *
 * ```gleam
 * is_leap_year(2024)
 * // -> True
 * ```
 *
 * ```gleam
 * is_leap_year(2023)
 * // -> False
 * ```
 */
export function is_leap_year(year) {
  let $ = (year % 400) === 0;
  if ($) {
    return $;
  } else {
    let $1 = (year % 100) === 0;
    if ($1) {
      return false;
    } else {
      return (year % 4) === 0;
    }
  }
}

/**
 * Checks if a given date is valid.
 *
 * This function properly accounts for leap years when validating February days.
 * A leap year occurs every 4 years, except for years divisible by 100,
 * unless they are also divisible by 400.
 *
 * # Examples
 *
 * ```gleam
 * is_valid_date(Date(2023, April, 15))
 * // -> True
 * ```
 *
 * ```gleam
 * is_valid_date(Date(2023, April, 31))
 * // -> False
 * ```
 *
 * ```gleam
 * is_valid_date(Date(2024, February, 29))
 * // -> True (2024 is a leap year)
 * ```
 */
export function is_valid_date(date) {
  let year;
  let month;
  let day;
  year = date.year;
  month = date.month;
  day = date.day;
  let $ = day < 1;
  if ($) {
    return false;
  } else {
    if (month instanceof January) {
      return day <= 31;
    } else if (month instanceof February) {
      let _block;
      let $1 = is_leap_year(year);
      if ($1) {
        _block = 29;
      } else {
        _block = 28;
      }
      let max_february_days = _block;
      return day <= max_february_days;
    } else if (month instanceof March) {
      return day <= 31;
    } else if (month instanceof April) {
      return day <= 30;
    } else if (month instanceof May) {
      return day <= 31;
    } else if (month instanceof June) {
      return day <= 30;
    } else if (month instanceof July) {
      return day <= 31;
    } else if (month instanceof August) {
      return day <= 31;
    } else if (month instanceof September) {
      return day <= 30;
    } else if (month instanceof October) {
      return day <= 31;
    } else if (month instanceof November) {
      return day <= 30;
    } else {
      return day <= 31;
    }
  }
}

/**
 * Checks if a time of day is valid.
 *
 * Validates that hours are 0-23, minutes are 0-59, seconds are 0-59,
 * and nanoseconds are 0-999,999,999.
 *
 * # Examples
 *
 * ```gleam
 * is_valid_time_of_day(TimeOfDay(12, 30, 45, 123456789))
 * // -> True
 * ```
 */
export function is_valid_time_of_day(time) {
  let hours;
  let minutes;
  let seconds;
  let nanoseconds;
  hours = time.hours;
  minutes = time.minutes;
  seconds = time.seconds;
  nanoseconds = time.nanoseconds;
  return (((((((hours >= 0) && (hours <= 23)) && (minutes >= 0)) && (minutes <= 59)) && (seconds >= 0)) && (seconds <= 59)) && (nanoseconds >= 0)) && (nanoseconds <= 999_999_999);
}

/**
 * Naively compares two dates without any time zone information, returning an
 * order.
 *
 * ## Correctness
 *
 * This function compares dates without any time zone information, only using
 * the rules for the gregorian calendar. This is typically sufficient, but be
 * aware that in reality some time zones will change their calendar date
 * occasionally. This can result in days being skipped, out of order, or
 * happening multiple times.
 *
 * If you need real-world correct time ordering then use the
 * `gleam/time/timestamp` module instead.
 */
export function naive_date_compare(one, other) {
  let _pipe = $int.compare(one.year, other.year);
  let _pipe$1 = $order.lazy_break_tie(
    _pipe,
    () => {
      return $int.compare(month_to_int(one.month), month_to_int(other.month));
    },
  );
  return $order.lazy_break_tie(
    _pipe$1,
    () => { return $int.compare(one.day, other.day); },
  );
}
