-module(gleam@time@calendar).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/gleam/time/calendar.gleam").
-export([local_offset/0, month_to_string/1, month_to_int/1, month_from_int/1, is_leap_year/1, is_valid_date/1, is_valid_time_of_day/1, naive_date_compare/2]).
-export_type([date/0, time_of_day/0, month/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " This module is for working with the Gregorian calendar, established by\n"
    " Pope Gregory XIII in 1582!\n"
    "\n"
    " ## When should you use this module?\n"
    "\n"
    " > **tldr:** You probably want to use [`gleam/time/timestamp`](./timestamp.html)\n"
    " > instead!\n"
    "\n"
    " Calendar time is difficult to work with programmatically, it is the source\n"
    " of most time-related bugs in software. Compared to _epoch time_, which the\n"
    " `gleam/time/timestamp` module uses, there are many disadvantages to\n"
    " calendar time:\n"
    "\n"
    " - They are ambiguous if you don't know what time-zone is being used.\n"
    "\n"
    " - A time-zone database is required to understand calendar time even when\n"
    "   you have the time zone. These are large and your program has to\n"
    "   continously be updated as new versions of the database are published.\n"
    "\n"
    " - The type permits invalid states. e.g. `days` could be set to the number\n"
    "   32, but this should not be possible!\n"
    "\n"
    " - There is not a single unique canonical value for each point in time,\n"
    "   thanks to time zones. Two different `Date` + `TimeOfDay` value pairs\n"
    "   could represent the same point in time. This means that you can't check\n"
    "   for time equality with `==` when using calendar types.\n"
    "\n"
    " - They are computationally complex, using a more memory to represent and\n"
    "   requiring a lot more CPU time to manipulate.\n"
    "\n"
    " There are also advantages to calendar time:\n"
    "\n"
    " - Calendar time is how human's talk about time, so if you want to show a\n"
    "   time or take a time from a human user then calendar time will make it\n"
    "   easier for them.\n"
    "\n"
    " - They can represent more abstract time periods such as \"New Year's Day\".\n"
    "   This may seem like an exact window of time at first, but really the\n"
    "   definition of \"New Year's Day\" is more fuzzy than that. When it starts\n"
    "   and ends will depend where in the world you are, so if you want to refer\n"
    "   to a day as a global concept instead of a fixed window of time for that\n"
    "   day in a specific location, then calendar time can represent that.\n"
    "\n"
    " So when should you use calendar time? These are our recommendations:\n"
    "\n"
    " - Default to `gleam/time/timestamp`, which is epoch time. It is\n"
    "   unambiguous, efficient, and significantly less likely to result in logic\n"
    "   bugs.\n"
    "\n"
    " - When writing time to a database or other data storage use epoch time,\n"
    "   using whatever epoch format it supports. For example, PostgreSQL\n"
    "   `timestamp` and `timestampz` are both epoch time, and `timestamp` is\n"
    "   preferred as it is more straightforward to use as your application is\n"
    "   also using epoch time.\n"
    "\n"
    " - When communicating with other computer systems continue to use epoch\n"
    "   time. For example, when sending times to another program you could\n"
    "   encode time as UNIX timestamps (seconds since 00:00:00 UTC on 1 January\n"
    "   1970).\n"
    "\n"
    " - When communicating with humans use epoch time internally, and convert\n"
    "   to-and-from calendar time at the last moment, when iteracting with the\n"
    "   human user. It may also help the users to also show the time as a fuzzy\n"
    "   duration from the present time, such as \"about 4 days ago\".\n"
    "\n"
    " - When representing \"fuzzy\" human time concepts that don't exact periods\n"
    "   in time, such as \"one month\" (varies depending on which month, which\n"
    "   year, and in which time zone) and \"Christmas Day\" (varies depending on\n"
    "   which year and time zone) then use calendar time.\n"
    "\n"
    " Any time you do use calendar time you should be extra careful! It is very\n"
    " easy to make mistake with. Avoid it where possible.\n"
    "\n"
    " ## Time zone offsets\n"
    "\n"
    " This package includes the `utc_offset` value and the `local_offset`\n"
    " function, which are the offset for the UTC time zone and get the time\n"
    " offset the computer running the program is configured to respectively.\n"
    "\n"
    " If you need to use other offsets in your program then you will need to get\n"
    " them from somewhere else, such as from a package which loads the\n"
    " [IANA Time Zone Database](https://www.iana.org/time-zones), or from the\n"
    " website visitor's web browser, which your frontend can send for you.\n"
    "\n"
    " ## Use in APIs\n"
    "\n"
    " If you are making an API such as a HTTP JSON API you are encouraged to use\n"
    " Unix timestamps instead of calendar times.\n"
).

-type date() :: {date, integer(), month(), integer()}.

-type time_of_day() :: {time_of_day, integer(), integer(), integer(), integer()}.

-type month() :: january |
    february |
    march |
    april |
    may |
    june |
    july |
    august |
    september |
    october |
    november |
    december.

-file("src/gleam/time/calendar.gleam", 147).
?DOC(
    " Get the offset for the computer's currently configured time zone.\n"
    "\n"
    " Note this may not be the time zone that is correct to use for your user.\n"
    " For example, if you are making a web application that runs on a server you\n"
    " want _their_ computer's time zone, not yours.\n"
    "\n"
    " This is the _current local_ offset, not the current local time zone. This\n"
    " means that while it will result in the expected outcome for the current\n"
    " time, it may result in unexpected output if used with other timestamps. For\n"
    " example: a timestamp that would locally be during daylight savings time if\n"
    " is it not currently daylight savings time when this function is called.\n"
).
-spec local_offset() -> gleam@time@duration:duration().
local_offset() ->
    gleam@time@duration:seconds(gleam_time_ffi:local_time_offset_seconds()).

-file("src/gleam/time/calendar.gleam", 163).
?DOC(
    " Returns the English name for a month.\n"
    "\n"
    " # Examples\n"
    "\n"
    " ```gleam\n"
    " month_to_string(April)\n"
    " // -> \"April\"\n"
    " ```\n"
).
-spec month_to_string(month()) -> binary().
month_to_string(Month) ->
    case Month of
        january ->
            <<"January"/utf8>>;

        february ->
            <<"February"/utf8>>;

        march ->
            <<"March"/utf8>>;

        april ->
            <<"April"/utf8>>;

        may ->
            <<"May"/utf8>>;

        june ->
            <<"June"/utf8>>;

        july ->
            <<"July"/utf8>>;

        august ->
            <<"August"/utf8>>;

        september ->
            <<"September"/utf8>>;

        october ->
            <<"October"/utf8>>;

        november ->
            <<"November"/utf8>>;

        december ->
            <<"December"/utf8>>
    end.

-file("src/gleam/time/calendar.gleam", 188).
?DOC(
    " Returns the number for the month, where January is 1 and December is 12.\n"
    "\n"
    " # Examples\n"
    "\n"
    " ```gleam\n"
    " month_to_int(January)\n"
    " // -> 1\n"
    " ```\n"
).
-spec month_to_int(month()) -> integer().
month_to_int(Month) ->
    case Month of
        january ->
            1;

        february ->
            2;

        march ->
            3;

        april ->
            4;

        may ->
            5;

        june ->
            6;

        july ->
            7;

        august ->
            8;

        september ->
            9;

        october ->
            10;

        november ->
            11;

        december ->
            12
    end.

-file("src/gleam/time/calendar.gleam", 213).
?DOC(
    " Returns the month for a given number, where January is 1 and December is 12.\n"
    "\n"
    " # Examples\n"
    "\n"
    " ```gleam\n"
    " month_from_int(1)\n"
    " // -> Ok(January)\n"
    " ```\n"
).
-spec month_from_int(integer()) -> {ok, month()} | {error, nil}.
month_from_int(Month) ->
    case Month of
        1 ->
            {ok, january};

        2 ->
            {ok, february};

        3 ->
            {ok, march};

        4 ->
            {ok, april};

        5 ->
            {ok, may};

        6 ->
            {ok, june};

        7 ->
            {ok, july};

        8 ->
            {ok, august};

        9 ->
            {ok, september};

        10 ->
            {ok, october};

        11 ->
            {ok, november};

        12 ->
            {ok, december};

        _ ->
            {error, nil}
    end.

-file("src/gleam/time/calendar.gleam", 290).
?DOC(
    " Determines if a given year is a leap year.\n"
    "\n"
    " A leap year occurs every 4 years, except for years divisible by 100,\n"
    " unless they are also divisible by 400.\n"
    "\n"
    " # Examples\n"
    "\n"
    " ```gleam\n"
    " is_leap_year(2024)\n"
    " // -> True\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " is_leap_year(2023)\n"
    " // -> False\n"
    " ```\n"
).
-spec is_leap_year(integer()) -> boolean().
is_leap_year(Year) ->
    case (Year rem 400) =:= 0 of
        true ->
            true;

        false ->
            case (Year rem 100) =:= 0 of
                true ->
                    false;

                false ->
                    (Year rem 4) =:= 0
            end
    end.

-file("src/gleam/time/calendar.gleam", 254).
?DOC(
    " Checks if a given date is valid.\n"
    "\n"
    " This function properly accounts for leap years when validating February days.\n"
    " A leap year occurs every 4 years, except for years divisible by 100,\n"
    " unless they are also divisible by 400.\n"
    "\n"
    " # Examples\n"
    "\n"
    " ```gleam\n"
    " is_valid_date(Date(2023, April, 15))\n"
    " // -> True\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " is_valid_date(Date(2023, April, 31))\n"
    " // -> False\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " is_valid_date(Date(2024, February, 29))\n"
    " // -> True (2024 is a leap year)\n"
    " ```\n"
).
-spec is_valid_date(date()) -> boolean().
is_valid_date(Date) ->
    {date, Year, Month, Day} = Date,
    case Day < 1 of
        true ->
            false;

        false ->
            case Month of
                january ->
                    Day =< 31;

                march ->
                    Day =< 31;

                may ->
                    Day =< 31;

                july ->
                    Day =< 31;

                august ->
                    Day =< 31;

                october ->
                    Day =< 31;

                december ->
                    Day =< 31;

                april ->
                    Day =< 30;

                june ->
                    Day =< 30;

                september ->
                    Day =< 30;

                november ->
                    Day =< 30;

                february ->
                    Max_february_days = case is_leap_year(Year) of
                        true ->
                            29;

                        false ->
                            28
                    end,
                    Day =< Max_february_days
            end
    end.

-file("src/gleam/time/calendar.gleam", 313).
?DOC(
    " Checks if a time of day is valid.\n"
    "\n"
    " Validates that hours are 0-23, minutes are 0-59, seconds are 0-59,\n"
    " and nanoseconds are 0-999,999,999.\n"
    "\n"
    " # Examples\n"
    "\n"
    " ```gleam\n"
    " is_valid_time_of_day(TimeOfDay(12, 30, 45, 123456789))\n"
    " // -> True\n"
    " ```\n"
).
-spec is_valid_time_of_day(time_of_day()) -> boolean().
is_valid_time_of_day(Time) ->
    {time_of_day, Hours, Minutes, Seconds, Nanoseconds} = Time,
    (((((((Hours >= 0) andalso (Hours =< 23)) andalso (Minutes >= 0)) andalso (Minutes
    =< 59))
    andalso (Seconds >= 0))
    andalso (Seconds =< 59))
    andalso (Nanoseconds >= 0))
    andalso (Nanoseconds =< 999999999).

-file("src/gleam/time/calendar.gleam", 340).
?DOC(
    " Naively compares two dates without any time zone information, returning an\n"
    " order.\n"
    "\n"
    " ## Correctness\n"
    "\n"
    " This function compares dates without any time zone information, only using\n"
    " the rules for the gregorian calendar. This is typically sufficient, but be\n"
    " aware that in reality some time zones will change their calendar date\n"
    " occasionally. This can result in days being skipped, out of order, or\n"
    " happening multiple times.\n"
    "\n"
    " If you need real-world correct time ordering then use the\n"
    " `gleam/time/timestamp` module instead.\n"
).
-spec naive_date_compare(date(), date()) -> gleam@order:order().
naive_date_compare(One, Other) ->
    _pipe = gleam@int:compare(erlang:element(2, One), erlang:element(2, Other)),
    _pipe@1 = gleam@order:lazy_break_tie(
        _pipe,
        fun() ->
            gleam@int:compare(
                month_to_int(erlang:element(3, One)),
                month_to_int(erlang:element(3, Other))
            )
        end
    ),
    gleam@order:lazy_break_tie(
        _pipe@1,
        fun() ->
            gleam@int:compare(erlang:element(4, One), erlang:element(4, Other))
        end
    ).
