from pymongo import MongoClient


# Function to insert a user and their resume
def insert_user_and_resume(users_collection, user, resume):
    user_id = users_collection.insert_one(user).inserted_id
    resume['user_id'] = user_id
    resumes_collection.insert_one(resume)


# Function to get a specific user's resume
def get_resume(users_collection, resumes_collection, user_login):
    user = users_collection.find_one({'login': user_login})
    resume = resumes_collection.find_one({'user_id': user['_id']})

    return user, resume


# Get all hobbies of particular user
def get_user_hobbies(resumes_collection, user_login):
    resume = resumes_collection.find_one({'user_id': users_collection.find_one({'login': user_login})['_id']})
    return resume['hobbies']


# Get hobbies which are common for all users
def get_common_hobbies(resumes_collection):
    # Get all distinct hobbies
    all_hobbies = resumes_collection.distinct('hobbies')

    # Initialize common hobbies with all hobbies
    common_hobbies = set(all_hobbies)

    # For each user, get their hobbies and intersect with common hobbies
    for resume in resumes_collection.find():
        user_hobbies = set(resume['hobbies'])
        common_hobbies &= user_hobbies

    return list(common_hobbies)


# Get cities which are common for all users
def get_common_cities(resumes_collection):
    cities = resumes_collection.distinct('city')
    return cities


# Get all hobbies from users from a specific city
def get_hobbies_in_city(resumes_collection, city):
    hobbies = resumes_collection.find({'city': city}).distinct('hobbies')
    return hobbies


# Get all users who worked at same institution, don't specify the institution
from collections import defaultdict


def get_users_from_same_workplaces(users_collection, resumes_collection):
    # get all distinct institutions and previous_workplaces
    institutions = resumes_collection.distinct('institution')
    previous_workplaces = resumes_collection.distinct('previous_workplaces')

    # find distinct companies
    companies = set(institutions + previous_workplaces)

    # create a dictionary to store users for each company
    users_by_company = defaultdict(list)

    # for each company, find users who worked there
    for company in companies:
        users = resumes_collection.find({'$or': [{'institution': company}, {'previous_workplaces': company}]})
        for user in users:
            users_by_company[company].append(user['user_id'])

    # if company has more than 1 user, add users to the result
    result = set()
    for company, users in users_by_company.items():
        if len(users) > 1:
            result |= set(users)

            # map the user ids to user logins
    result = [users_collection.find_one({'_id': user_id})['login'] for user_id in result]

    return result


if __name__ == '__main__':
    # Create a connection to MongoDB
    client = MongoClient('127.0.0.1', 27017)

    # authenticate
    client.admin.authenticate('mongo', 'mongo')

    # Create a database
    db = client['mongo']

    # Create a collection for users
    users_collection = db['users']

    # Create a collection for resumes
    resumes_collection = db['resumes']

    # Define some users and their resumes
    users_and_resumes = [
        {
            'user': {'login': 'Andrii', 'password': 'pass1'},
            'resume': {'hobbies': ['Football', 'Gaming', 'Reading'], 'previous_workplaces': ['Apple', 'Samsung'],
                       'city': 'Kyiv', 'institution': 'Apple'}
        },
        {
            'user': {'login': 'Nazar', 'password': 'pass2'},
            'resume': {'hobbies': ['Basketball', 'Reading'], 'previous_workplaces': ['Samsung', 'Apple'],
                       'city': 'Kyiv', 'institution': 'Samsung'}
        },
        {
            'user': {'login': 'Ivan', 'password': 'pass3'},
            'resume': {'hobbies': ['Swimming', 'Coding', 'Reading'], 'previous_workplaces': ['Apple', 'Samsung'],
                       'city': 'Kharkiv', 'institution': 'Apple'}
        },
        {
            'user': {'login': 'Petro', 'password': 'pass4'},
            'resume': {'hobbies': ['Hiking', 'Photography', 'Reading'], 'previous_workplaces': ['Samsung', 'Apple'],
                       'city': 'Odesa', 'institution': 'Samsung'}
        },
        {
            'user': {'login': 'Oleg', 'password': 'pass34'},
            'resume': {'hobbies': ['Reading'], 'previous_workplaces': ['Kyivstar'],
                       'city': 'Odesa', 'institution': 'Kyivstar'}
        },
    ]

    # Insert each user and their resume into the database
    for item in users_and_resumes:
        insert_user_and_resume(users_collection, item['user'], item['resume'])

    user_login = 'Andrii'

    print(f"User {user_login} and his resume: {get_resume(users_collection, resumes_collection, user_login)}")

    user_login = 'Nazar'

    print(f"User {user_login} and his hobbies: {get_user_hobbies(resumes_collection, user_login)}")

    print(f"Common hobbies: {get_common_hobbies(resumes_collection)}")

    print(f"Common cities: {get_common_cities(resumes_collection)}")

    print(f"Hobbies in Kyiv: {get_hobbies_in_city(resumes_collection, 'Kyiv')}")

    print(f"Users from same workplaces: {get_users_from_same_workplaces(users_collection, resumes_collection)}")

    # Close the connection
    client.close()
