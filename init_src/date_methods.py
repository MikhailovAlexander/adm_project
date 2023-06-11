import datetime
import calendar
import random


def get_random_date(start, end):
    seconds = random.randint(0, int((end - start).total_seconds()))
    return start + datetime.timedelta(seconds=seconds)


def get_month_end(dt):
    first_of_month = datetime.datetime(dt.year, dt.month, 1)
    next_month_date = first_of_month + datetime.timedelta(days=32)
    new_dt = datetime.datetime(next_month_date.year, next_month_date.month, 1)
    return (new_dt - datetime.timedelta(days=1)).date()


def add_months(dt, months):
    month = dt.month - 1 + months
    year = dt.year + month // 12
    month = month % 12 + 1
    day = min(dt.day, calendar.monthrange(year, month)[1])
    return datetime.date(year, month, day)
