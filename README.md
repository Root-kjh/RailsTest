# README

## Additional gems

```
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# use jwt authentication
gem 'knock', git: 'https://github.com/nsarno/knock', branch: 'master', ref: '9214cd027422df8dc31eb67c60032fbbf8fc100b'

# use file upload
gem 'carrierwave'
```

The reasons for using knockgem as the corresponding version are as follows.

* There was an error when using the authenticate_user method on the controller, and it was to fix it.

## API Docs

* version: v1

* UserInfo
	* data
		* id
		* type(users)
		* attributes
			* token(jwt)
			* email
			* name(firstName+lastName)
			* country
			* createAt
			* updatedAt
```
{
  "data": {
    "id": 1,
    "type": "users",
    "attributes": {
      "token": "asdf.qwer.zxcv (JWT)",
      "email": "john@email.com",
      "name": "John Doe",
      "country": "USA",
      "createdAt": "2020-06-11T11:34+01:00",
      "updatedAt": "2020-06-11T11:34+01:00"
    }
  }
}
```

* ProjectData
	* data
		* id
		* type(project)
		* attributes
			* title
			* thumbnail(uri)
			* description
			* location
			* type
			* ownerName
			* createdAt
			* updatedAt

* ContentData
	* data
		* id
		* type(content)
		* attributes
			* projectId
			* projectOnwerName
			* title
			* body
			* createdAt
			* updatedAt

### User

* signup(/users/signup)
	* Request(POST)
		* Json: firstName, lastName, email, password, country
	* Response: UserInfo

* signin(/users/signin)
	* Request(POST)
		* Json: auth -> email, password
		> "auth": {"email": "", "password": ""}
### Project

* createProject(/projects)
	* Request(POST)
		* auth: jwt
		* form: title, description, type, location, thumbnail

* getProject(/projects/:id)
	* Request(GET)
	* Response: ProjectData

* getAllProjects(/projects)
	* Request(GET)
	* Response: ProjectDataList

* getAllOwnedProjects(/projects/my_projects)
	* Request(GET)
		* auth: jwt
	* Response: ProjectDataList

* updateProject(/projects/:id)
	* Request(PUT)
		* auth: jwt
		* Json: title, description, type, location, thumbnail
	* Response: ProjectData

* deleteProject(/projects/:id)
	* Request(DELETE)
		* auth: jwt
	* Response: Success/ Fail

### Content
    
* createContent(/projects/:project_id/contents)
	* Request(POST)
		* auth: jwt
		* Json: title, body
	* Response: ContentData

* getContents(/projects/:project_id/contents)
	* Request(GET)
	* Response: ContentDataList

* getSpecificContent(/projects/:project_id/contents/:id)
	* Request(GET)
	* Response: ContentData

* updateContent(/contents/:id)
	* Request(PUT)
		* auth: jwt
		* Json: title, body
	* Response: ContentData

* deleteContent(/contents/:id)
	* Request(DELETE)
		* auth: jwt
	* Response: Success/ Fail

## steps that are necessary

It is written based on Centos8.3.

1. Install ruby-2.7.2

2. Export Environment variable
```
export SECRET_KEY_BASE=GENERATED_CODE
```

3. db migrate
```
rake db:migrate RAILS_ENV=production
```

4. run rails server on production level
```
rails s -e production
```