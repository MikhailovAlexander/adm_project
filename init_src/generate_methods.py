import random
from mimesis.providers import Person, Datetime


from init_src import YEAR, GENDER_DICT


def gen_person_data():
    person = Person('en')
    dt = Datetime()
    start_year = YEAR - 60
    end_year = YEAR - 18
    new_gender = random.choice([1, 2])
    new_person_data = [person.full_name(GENDER_DICT[new_gender]),
                       dt.date(start_year, end_year),
                       new_gender,
                       person.telephone(mask='89#########'),
                       person.email()]
    return new_person_data


def gen_phone():
    return Person('en').telephone(mask='89#########')


def gen_email():
    return Person('en').email()


def gen_horse_data():
    person = Person('en')
    dt = Datetime()
    start_year = YEAR - 20
    end_year = YEAR - 1
    new_horse_data = [person.first_name(), dt.date(start_year, end_year)]
    return new_horse_data
