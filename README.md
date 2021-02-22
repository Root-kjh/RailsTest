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

## API Documentation(Post man JSON Document)
    
```json
{
	"info": {
		"_postman_id": "1ef883f9-edbb-4918-8d2d-f8dbdddd152d",
		"name": "AW API Coding Test",
		"description": "## IMPORTANT\r\nPlease pay attention to the **API Specification** and implement as instructed.\r\n\r\n### Request Structure\r\nThe request payload/body must match as the API Specification.\r\n\r\n### Response Structure\r\n- All the endpoints must return JSON response\r\n- The response examples included in this documentation are for successful requests only.\r\n- For any other requests that fails, **please return appropriate response with appropriate response code.**",
		"schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
	},
	"item": [
		{
			"name": "User",
			"item": [
				{
					"name": "Sign-Up",
					"request": {
						"method": "POST",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n    \"firstName\": \"\", // Required\r\n    \"lastName\": \"\", // Required\r\n    \"email\": \"\", // Required\r\n    \"password\": \"\", // Required\r\n    \"country\": \"\" // Optional\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/users/signup",
							"protocol": "{{SCHEME}}",
							"host": [
								"{{SERVER}}"
							],
							"path": [
								"{{VERSION}}",
								"users",
								"signup"
							]
						},
						"description": "Create new user."
					},
					"response": [
						{
							"name": "Sign-Up Response Example",
							"originalRequest": {
								"method": "POST",
								"header": [
									{
										"key": "Content-Type",
										"value": "application/json",
										"type": "text"
									}
								],
								"body": {
									"mode": "raw",
									"raw": "{\r\n    \"firstName\": \"John\", // Required\r\n    \"lastName\": \"Doe\", // Required\r\n    \"email\": \"john@email.com\", // Required\r\n    \"password\": \"complex_password\", // Required\r\n    \"country\": \"USA\" // Optional\r\n}",
									"options": {
										"raw": {
											"language": "json"
										}
									}
								},
								"url": {
									"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/users/signup",
									"protocol": "{{SCHEME}}",
									"host": [
										"{{SERVER}}"
									],
									"path": [
										"{{VERSION}}",
										"users",
										"signup"
									]
								}
							},
							"code": 201,
							"_postman_previewlanguage": "json",
							"header": null,
							"cookie": [],
							"body": "{\n    \"data\": {\n        \"id\": 1,\n        \"type\": \"users\",\n        \"attributes\": {\n            \"token\": \"asdf.qwer.zxcv (JWT)\",\n            \"email\": \"john@email.com\",\n            \"name\": \"John Doe\",\n            \"country\": \"USA\",\n            \"createdAt\": \"2020-06-11T11:34+01:00\",\n            \"updatedAt\": \"2020-06-11T11:34+01:00\"\n        }\n    }\n}\n"
						},
						{
							"name": "Sign-Up Validation Error",
							"originalRequest": {
								"method": "POST",
								"header": [],
								"body": {
									"mode": "raw",
									"raw": "{\r\n    \"firstName\": \"Mark\", // Required\r\n    \"lastName\": \"Doe\", // Required\r\n    \"email\": \"not_an_email.com\", // Required\r\n    \"password\": \"password\", // Required\r\n    \"country\": \"\" // Optional\r\n}",
									"options": {
										"raw": {
											"language": "json"
										}
									}
								},
								"url": {
									"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/users/signup",
									"protocol": "{{SCHEME}}",
									"host": [
										"{{SERVER}}"
									],
									"path": [
										"{{VERSION}}",
										"users",
										"signup"
									]
								}
							},
							"code": 422,
							"_postman_previewlanguage": "Text",
							"header": null,
							"cookie": [],
							"body": null
						}
					]
				},
				{
					"name": "Sign-In",
					"request": {
						"method": "POST",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n    \"auth\": {\r\n        \"email\": \"\", // Required\r\n        \"password\": \"\" // Required\r\n    }\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/auth/signin",
							"protocol": "{{SCHEME}}",
							"host": [
								"{{SERVER}}"
							],
							"path": [
								"{{VERSION}}",
								"auth",
								"signin"
							]
						},
						"description": "API Endpoint to authenticate and obtain authentication token."
					},
					"response": [
						{
							"name": "Sign-In Request-Response Example",
							"originalRequest": {
								"method": "POST",
								"header": [
									{
										"key": "Content-Type",
										"value": "application/json",
										"type": "text"
									}
								],
								"body": {
									"mode": "raw",
									"raw": "{\r\n    \"auth\": {\r\n        \"email\": \"john@email.com\", // Email, Required\r\n        \"password\": \"complex_password\" // String, Required\r\n    }\r\n}",
									"options": {
										"raw": {
											"language": "json"
										}
									}
								},
								"url": {
									"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/auth/signin",
									"protocol": "{{SCHEME}}",
									"host": [
										"{{SERVER}}"
									],
									"path": [
										"{{VERSION}}",
										"auth",
										"signin"
									]
								}
							},
							"code": 201,
							"_postman_previewlanguage": "json",
							"header": null,
							"cookie": [],
							"body": "{\n  \"data\": {\n    \"id\": 1,\n    \"type\": \"users\",\n    \"attributes\": {\n      \"token\": \"asdf.qwer.zxcv (JWT)\",\n      \"email\": \"john@email.com\",\n      \"name\": \"John Doe\",\n      \"country\": \"USA\",\n      \"createdAt\": \"2020-06-11T11:34+01:00\",\n      \"updatedAt\": \"2020-06-11T11:34+01:00\"\n    }\n  }\n}"
						}
					]
				}
			]
		},
		{
			"name": "Project",
			"item": [
				{
					"name": "Create Project",
					"request": {
						"auth": {
							"type": "bearer",
							"bearer": [
								{
									"key": "token",
									"value": "eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MTMwMTc1ODksInN1YiI6MX0.2A1mS-fVykzGfhOMjyMSb3cVWwYKQEfB0NMtCFwR-s8",
									"type": "string"
								}
							]
						},
						"method": "POST",
						"header": [],
						"body": {
							"mode": "formdata",
							"formdata": [
								{
									"key": "title",
									"value": "",
									"description": "String (REQUIRED)",
									"type": "text"
								},
								{
									"key": "description",
									"value": "",
									"description": "Text (OPTIONAL)",
									"type": "text"
								},
								{
									"key": "type",
									"value": "",
									"description": "String { in_house: 0, external: 1, international: 2 } (REQUIRED)",
									"type": "text"
								},
								{
									"key": "location",
									"value": "",
									"description": "String (REQUIRED)",
									"type": "text"
								},
								{
									"key": "thumbnail",
									"description": "Image File (REQUIRED)",
									"type": "file",
									"src": "/F:/My Downloads/evil.jpg"
								}
							]
						},
						"url": {
							"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects",
							"protocol": "{{SCHEME}}",
							"host": [
								"{{SERVER}}"
							],
							"path": [
								"{{VERSION}}",
								"projects"
							]
						},
						"description": "#### Important Notes:\r\n**For request body:**\r\n- `type`: The datatype of type in DB is integer, but the API accepts and returns string (Please refer to parameter description). *Hint: Enumeration*\r\n- `thumbnail`: Upload image"
					},
					"response": [
						{
							"name": "Create Project Response Example",
							"originalRequest": {
								"method": "POST",
								"header": [],
								"body": {
									"mode": "formdata",
									"formdata": [
										{
											"key": "title",
											"value": "Project A",
											"description": "String (REQUIRED)",
											"type": "text"
										},
										{
											"key": "description",
											"value": "",
											"description": "Text (OPTIONAL)",
											"type": "text"
										},
										{
											"key": "type",
											"value": "international",
											"description": "{ in_house: 0, external: 1, international: 2 } (REQUIRED)",
											"type": "text"
										},
										{
											"key": "location",
											"value": "Seoul",
											"description": "String (REQUIRED)",
											"type": "text"
										},
										{
											"key": "thumbnail",
											"description": "Image File (REQUIRED)",
											"type": "file",
											"src": "/F:/My Downloads/story.jpg"
										}
									],
									"options": {
										"raw": {
											"language": "json"
										}
									}
								},
								"url": {
									"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects",
									"protocol": "{{SCHEME}}",
									"host": [
										"{{SERVER}}"
									],
									"path": [
										"{{VERSION}}",
										"projects"
									]
								}
							},
							"code": 201,
							"_postman_previewlanguage": "json",
							"header": null,
							"cookie": [],
							"body": "{\n    \"data\": {\n        \"id\": 1,\n        \"type\": \"project\",\n        \"attributes\": {\n            \"title\": \"Project A\",\n            \"thumbnail\": \"http://ondronemap.com/story.jpg\",\n            \"description\": \"\",\n            \"location\": \"Seoul\",\n            \"type\": \"international\",\n            \"ownerName\": \"John Doe\",\n            \"createdAt\": \"2020-06-11T11:34+01:00\",\n            \"updatedAt\": \"2020-06-11T11:34+01:00\"\n        }\n    }\n}"
						}
					]
				},
				{
					"name": "Get Project",
					"request": {
						"method": "GET",
						"header": [],
						"url": {
							"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects/:id",
							"protocol": "{{SCHEME}}",
							"host": [
								"{{SERVER}}"
							],
							"path": [
								"{{VERSION}}",
								"projects",
								":id"
							],
							"variable": [
								{
									"key": "id",
									"value": "",
									"description": "REQUIRED"
								}
							]
						}
					},
					"response": [
						{
							"name": "Get Project Response Example",
							"originalRequest": {
								"method": "GET",
								"header": [],
								"url": {
									"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects/:id",
									"protocol": "{{SCHEME}}",
									"host": [
										"{{SERVER}}"
									],
									"path": [
										"{{VERSION}}",
										"projects",
										":id"
									],
									"variable": [
										{
											"key": "id",
											"value": "1",
											"description": "Number, <REQUIRED>"
										}
									]
								}
							},
							"code": 200,
							"_postman_previewlanguage": "json",
							"header": null,
							"cookie": [],
							"body": "{\r\n    \"data\": {\r\n        \"id\": 1,\r\n        \"type\": \"project\",\r\n        \"attributes\": {\r\n            \"title\": \"Project A\",\r\n            \"thumbnail\": \"http://ondronemap.com/story.jpg\",\r\n            \"description\": \"\",\r\n            \"location\": \"Seoul\",\r\n            \"type\": \"international\",\r\n            \"ownerName\": \"John Doe\",\r\n            \"createdAt\": \"2020-06-11T11:34+01:00\",\r\n            \"updatedAt\": \"2020-06-11T11:34+01:00\"\r\n        }\r\n    }\r\n}"
						}
					]
				},
				{
					"name": "Get all Projects",
					"request": {
						"method": "GET",
						"header": [],
						"url": {
							"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects",
							"protocol": "{{SCHEME}}",
							"host": [
								"{{SERVER}}"
							],
							"path": [
								"{{VERSION}}",
								"projects"
							]
						}
					},
					"response": [
						{
							"name": "Get all Projects Response Example",
							"originalRequest": {
								"method": "GET",
								"header": [],
								"url": {
									"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects",
									"protocol": "{{SCHEME}}",
									"host": [
										"{{SERVER}}"
									],
									"path": [
										"{{VERSION}}",
										"projects"
									]
								}
							},
							"code": 200,
							"_postman_previewlanguage": "json",
							"header": null,
							"cookie": [],
							"body": "{\r\n    \"data\": [\r\n        {\r\n            \"id\": 1,\r\n            \"type\": \"project\",\r\n            \"attributes\": {\r\n                \"title\": \"Project A\",\r\n                \"thumbnail\": \"http://ondronemap.com/story.jpg\",\r\n                \"description\": \"\",\r\n                \"location\": \"Seoul\",\r\n                \"type\": \"international\",\r\n                \"ownerName\": \"John Doe\",\r\n                \"createdAt\": \"2020-06-11T11:34+01:00\",\r\n                \"updatedAt\": \"2020-06-11T11:34+01:00\"\r\n            }\r\n        },\r\n        {\r\n            \"id\": 2,\r\n            \"type\": \"project\",\r\n            \"attributes\": {\r\n                \"title\": \"Project B\",\r\n                \"thumbnail\": \"http://ondronemap.com/story2.jpg\",\r\n                \"description\": \"\",\r\n                \"location\": \"Bushan\",\r\n                \"type\": \"in_house\",\r\n                \"ownerName\": \"Jane Doe\",\r\n                \"createdAt\": \"2020-11-16T11:34+01:00\",\r\n                \"updatedAt\": \"2020-11-16T11:34+01:00\"\r\n            }\r\n        }\r\n    ]\r\n}"
						}
					]
				},
				{
					"name": "Get all Owned Projects",
					"request": {
						"auth": {
							"type": "bearer",
							"bearer": [
								{
									"key": "token",
									"value": "",
									"type": "string"
								}
							]
						},
						"method": "GET",
						"header": [],
						"url": {
							"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects/my_projects",
							"protocol": "{{SCHEME}}",
							"host": [
								"{{SERVER}}"
							],
							"path": [
								"{{VERSION}}",
								"projects",
								"my_projects"
							]
						},
						"description": "Can only be called by logged-in (authenticated) user.\r\nReturns only the projects owned by the logged-in users."
					},
					"response": [
						{
							"name": "Get all Owned Projects",
							"originalRequest": {
								"method": "GET",
								"header": [],
								"url": {
									"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects/my_projects",
									"protocol": "{{SCHEME}}",
									"host": [
										"{{SERVER}}"
									],
									"path": [
										"{{VERSION}}",
										"projects",
										"my_projects"
									]
								}
							},
							"_postman_previewlanguage": "json",
							"header": null,
							"cookie": [],
							"body": "{\n    \"data\": [\n        {\n            \"id\": 1,\n            \"type\": \"projects\",\n            \"attributes\": {\n                \"title\": \"Project A\",\n                \"thumbnail\": \"http://ondronemap.com/story.jpg\",\n                \"description\": \"\",\n                \"location\": \"Seoul\",\n                \"type\": \"international\",\n                \"createdAt\": \"2020-06-11T11:34+01:00\",\n                \"updatedAt\": \"2020-06-11T11:34+01:00\"\n            }\n        },\n        {\n            \"id\": 2,\n            \"type\": \"projects\",\n            \"attributes\": {\n                \"title\": \"Project Z\",\n                \"thumbnail\": \"http://ondronemap.com/story26.jpg\",\n                \"description\": \"\",\n                \"location\": \"Incheon\",\n                \"type\": \"external\",\n                \"createdAt\": \"2020-11-16T11:34+01:00\",\n                \"updatedAt\": \"2020-11-16T11:34+01:00\"\n            }\n        }\n    ]\n}"
						}
					]
				},
				{
					"name": "Update Project",
					"request": {
						"auth": {
							"type": "bearer",
							"bearer": [
								{
									"key": "token",
									"value": "",
									"type": "string"
								}
							]
						},
						"method": "PUT",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n    \"title\": \"\",\r\n    \"description\": \"\",\r\n    \"type\": 0, // { in-house: 0, external: 1, international: 2 }\r\n    \"location\": \"\"\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects/:id",
							"protocol": "{{SCHEME}}",
							"host": [
								"{{SERVER}}"
							],
							"path": [
								"{{VERSION}}",
								"projects",
								":id"
							],
							"variable": [
								{
									"key": "id",
									"value": ""
								}
							]
						},
						"description": "#### Important Notes:\r\n**For request body:**\r\n- `type`: The datatype of type in DB is integer, but the API accepts and returns string (Please refer to parameter description). *Hint: Enumeration*\r\n- `thumbnail`: Upload image"
					},
					"response": [
						{
							"name": "Update Project Response Example",
							"originalRequest": {
								"method": "PUT",
								"header": [],
								"body": {
									"mode": "raw",
									"raw": "{\r\n    \"title\": \"Project A Updated\",\r\n    \"thumbnail\": \"http://ondronemap.com/story.jpg\",\r\n    \"description\": \"Edited description in.\",\r\n    \"location\": \"Seoul\",\r\n    \"type\": \"international\"\r\n}",
									"options": {
										"raw": {
											"language": "json"
										}
									}
								},
								"url": {
									"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects/:id",
									"protocol": "{{SCHEME}}",
									"host": [
										"{{SERVER}}"
									],
									"path": [
										"{{VERSION}}",
										"projects",
										":id"
									],
									"variable": [
										{
											"key": "id",
											"value": "1"
										}
									]
								}
							},
							"code": 200,
							"_postman_previewlanguage": "json",
							"header": null,
							"cookie": [],
							"body": "{\r\n    \"data\": {\r\n        \"id\": 1,\r\n        \"type\": \"project\",\r\n        \"attributes\": {\r\n            \"title\": \"Project A Updated\",\r\n            \"thumbnail\": \"http://ondronemap.com/story.jpg\",\r\n            \"description\": \"Edited description in.\",\r\n            \"location\": \"Seoul\",\r\n            \"type\": \"international\",\r\n            \"ownerName\": \"John Doe\",\r\n            \"createdAt\": \"2020-06-11T11:34+01:00\",\r\n            \"updatedAt\": \"2020-06-11T11:34+01:00\"\r\n        }\r\n    }\r\n}"
						}
					]
				},
				{
					"name": "Delete Project",
					"request": {
						"auth": {
							"type": "bearer",
							"bearer": [
								{
									"key": "token",
									"value": "",
									"type": "string"
								}
							]
						},
						"method": "DELETE",
						"header": [],
						"url": {
							"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects/:id",
							"protocol": "{{SCHEME}}",
							"host": [
								"{{SERVER}}"
							],
							"path": [
								"{{VERSION}}",
								"projects",
								":id"
							],
							"variable": [
								{
									"key": "id",
									"value": ""
								}
							]
						}
					},
					"response": [
						{
							"name": "Delete Project Response Example",
							"originalRequest": {
								"method": "DELETE",
								"header": [],
								"url": {
									"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects/:id",
									"protocol": "{{SCHEME}}",
									"host": [
										"{{SERVER}}"
									],
									"path": [
										"{{VERSION}}",
										"projects",
										":id"
									],
									"variable": [
										{
											"key": "id",
											"value": "1"
										}
									]
								}
							},
							"code": 200,
							"_postman_previewlanguage": "json",
							"header": null,
							"cookie": [],
							"body": "{\r\n    \"message\": \"Deleted\"\r\n}"
						}
					]
				}
			]
		},
		{
			"name": "Content",
			"item": [
				{
					"name": "Create Content",
					"request": {
						"auth": {
							"type": "bearer",
							"bearer": [
								{
									"key": "token",
									"value": "",
									"type": "string"
								}
							]
						},
						"method": "POST",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n    \"title\": \"\", // Required\r\n    \"body\": \"\" // Required\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects/:project_id/contents",
							"protocol": "{{SCHEME}}",
							"host": [
								"{{SERVER}}"
							],
							"path": [
								"{{VERSION}}",
								"projects",
								":project_id",
								"contents"
							],
							"variable": [
								{
									"key": "project_id",
									"value": ""
								}
							]
						}
					},
					"response": [
						{
							"name": "Create Content Response Example",
							"originalRequest": {
								"method": "POST",
								"header": [],
								"body": {
									"mode": "raw",
									"raw": "{\r\n    \"title\": \"Content A\", // Required\r\n    \"body\": \"This will be the actual long body for the content.\" // Required\r\n}",
									"options": {
										"raw": {
											"language": "json"
										}
									}
								},
								"url": {
									"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects/:project_id/contents",
									"protocol": "{{SCHEME}}",
									"host": [
										"{{SERVER}}"
									],
									"path": [
										"{{VERSION}}",
										"projects",
										":project_id",
										"contents"
									],
									"variable": [
										{
											"key": "project_id",
											"value": "1"
										}
									]
								}
							},
							"code": 201,
							"_postman_previewlanguage": "json",
							"header": null,
							"cookie": [],
							"body": "{\n    \"data\": {\n        \"id\": 1,\n        \"type\": \"content\",\n        \"attributes\": {\n            \"projectId\": 1,\n            \"projectOwnerName\": \"John Doe\",\n            \"title\": \"Content A\",\n            \"body\": \"This will be the actual long body for the content.\",   \n            \"createdAt\": \"2020-06-11T11:34+01:00\",\n            \"updatedAt\": \"2020-06-11T11:34+01:00\"\n        }\n    }\n}"
						}
					]
				},
				{
					"name": "Get Contents",
					"request": {
						"method": "GET",
						"header": [],
						"url": {
							"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects/:project_id/contents",
							"protocol": "{{SCHEME}}",
							"host": [
								"{{SERVER}}"
							],
							"path": [
								"{{VERSION}}",
								"projects",
								":project_id",
								"contents"
							],
							"variable": [
								{
									"key": "project_id",
									"value": ""
								}
							]
						}
					},
					"response": [
						{
							"name": "Get Contents Response Example",
							"originalRequest": {
								"method": "GET",
								"header": [],
								"url": {
									"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects/:project_id/contents",
									"protocol": "{{SCHEME}}",
									"host": [
										"{{SERVER}}"
									],
									"path": [
										"{{VERSION}}",
										"projects",
										":project_id",
										"contents"
									],
									"variable": [
										{
											"key": "project_id",
											"value": "1"
										}
									]
								}
							},
							"code": 200,
							"_postman_previewlanguage": "json",
							"header": null,
							"cookie": [],
							"body": "{\r\n    \"data\": [\r\n        {\r\n            \"id\": 1,\r\n            \"type\": \"content\",\r\n            \"attributes\": {\r\n                \"projectId\": 1,\r\n                \"projectOwnerName\": \"John Doe\",\r\n                \"title\": \"Content A\",\r\n                \"body\": \"This will be the actual long body for the content.\",   \r\n                \"createdAt\": \"2020-06-11T11:34+01:00\",\r\n                \"updatedAt\": \"2020-06-11T11:34+01:00\"\r\n            }\r\n        },\r\n        {\r\n            \"id\": 2,\r\n            \"type\": \"content\",\r\n            \"attributes\": {\r\n                \"projectId\": 1,\r\n                \"projectOwnerName\": \"Jane Doe\",\r\n                \"title\": \"Content B\",\r\n                \"body\": \"This will be the another actual long awesome body for the content.\",   \r\n                \"createdAt\": \"2020-06-11T11:34+01:00\",\r\n                \"updatedAt\": \"2020-06-11T11:34+01:00\"\r\n            }\r\n        }\r\n    ]\r\n}"
						}
					]
				},
				{
					"name": "Get Specific Content",
					"request": {
						"method": "GET",
						"header": [],
						"url": {
							"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects/:project_id/contents/:id",
							"protocol": "{{SCHEME}}",
							"host": [
								"{{SERVER}}"
							],
							"path": [
								"{{VERSION}}",
								"projects",
								":project_id",
								"contents",
								":id"
							],
							"variable": [
								{
									"key": "project_id",
									"value": "",
									"description": "Project ID"
								},
								{
									"key": "id",
									"value": "",
									"description": "Content ID"
								}
							]
						}
					},
					"response": [
						{
							"name": "Get Specific Content Response Example",
							"originalRequest": {
								"method": "GET",
								"header": [],
								"url": {
									"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/projects/:project_id/contents/:id",
									"protocol": "{{SCHEME}}",
									"host": [
										"{{SERVER}}"
									],
									"path": [
										"{{VERSION}}",
										"projects",
										":project_id",
										"contents",
										":id"
									],
									"variable": [
										{
											"key": "project_id",
											"value": "1",
											"description": "Project ID"
										},
										{
											"key": "id",
											"value": "1",
											"description": "Content ID"
										}
									]
								}
							},
							"code": 200,
							"_postman_previewlanguage": "json",
							"header": null,
							"cookie": [],
							"body": "{\r\n  \"data\": {\r\n        \"id\": 1,\r\n        \"type\": \"content\",\r\n        \"attributes\": {\r\n            \"projectId\": 1,\r\n            \"projectOwnerName\": \"John Doe\",\r\n            \"title\": \"Project 1 Content 1\",\r\n            \"body\": \"Village did removed enjoyed explain nor ham saw calling talking.\",\r\n            \"createdAt\": \"2020-06-11T11:34+01:00\",\r\n            \"updatedAt\": \"2020-06-11T11:34+01:00\"\r\n      }\r\n    }\r\n}"
						}
					]
				},
				{
					"name": "Update Content",
					"request": {
						"auth": {
							"type": "bearer",
							"bearer": [
								{
									"key": "token",
									"value": "",
									"type": "string"
								}
							]
						},
						"method": "PUT",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n    \"title\": \"\",\r\n    \"body\": \"\"\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/contents/:id",
							"protocol": "{{SCHEME}}",
							"host": [
								"{{SERVER}}"
							],
							"path": [
								"{{VERSION}}",
								"contents",
								":id"
							],
							"variable": [
								{
									"key": "id",
									"value": "",
									"description": "Content ID"
								}
							]
						}
					},
					"response": [
						{
							"name": "Update Content Response Example",
							"originalRequest": {
								"method": "PUT",
								"header": [],
								"body": {
									"mode": "raw",
									"raw": "{\r\n    \"title\": \"Content 1 Updated\",\r\n    \"body\": \"This body was updated using the awesome API.\"\r\n}",
									"options": {
										"raw": {
											"language": "json"
										}
									}
								},
								"url": {
									"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/contents/:id",
									"protocol": "{{SCHEME}}",
									"host": [
										"{{SERVER}}"
									],
									"path": [
										"{{VERSION}}",
										"contents",
										":id"
									],
									"variable": [
										{
											"key": "id",
											"value": "1",
											"description": "Content ID"
										}
									]
								}
							},
							"code": 200,
							"_postman_previewlanguage": "json",
							"header": null,
							"cookie": [],
							"body": "{\r\n  \"data\": {\r\n    \"id\": 1,\r\n    \"type\": \"content\",\r\n    \"attributes\": {\r\n        \"project_id\": 1,\r\n        \"projectOwnerName\": \"John Doe\",\r\n        \"title\": \"Content 1 Updated\",\r\n        \"body\": \"This body was updated using the awesome API.\",\r\n        \"createdAt\": \"2020-06-11T11:34+01:00\",\r\n        \"updatedAt\": \"2020-07-11T11:34+01:00\"\r\n    }\r\n  }\r\n}"
						}
					]
				},
				{
					"name": "Delete Content",
					"request": {
						"auth": {
							"type": "bearer",
							"bearer": [
								{
									"key": "token",
									"value": "",
									"type": "string"
								}
							]
						},
						"method": "DELETE",
						"header": [],
						"url": {
							"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/contents/:id",
							"protocol": "{{SCHEME}}",
							"host": [
								"{{SERVER}}"
							],
							"path": [
								"{{VERSION}}",
								"contents",
								":id"
							],
							"variable": [
								{
									"key": "id",
									"value": ""
								}
							]
						}
					},
					"response": [
						{
							"name": "Delete Content Response Example",
							"originalRequest": {
								"method": "DELETE",
								"header": [],
								"url": {
									"raw": "{{SCHEME}}://{{SERVER}}/{{VERSION}}/contents/:id",
									"protocol": "{{SCHEME}}",
									"host": [
										"{{SERVER}}"
									],
									"path": [
										"{{VERSION}}",
										"contents",
										":id"
									],
									"variable": [
										{
											"key": "id",
											"value": "1"
										}
									]
								}
							},
							"code": 200,
							"_postman_previewlanguage": "json",
							"header": null,
							"cookie": [],
							"body": "{\r\n    \"message\": \"Deleted\"\r\n}"
						}
					]
				}
			]
		}
	]
}
```

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