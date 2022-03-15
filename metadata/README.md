Dependencies:
1. Java 8
2. PostgresSQL
3. Maven


Steps to perform local setup and start the server:
1. Import the project via pom.mxml in IDE of your choice (Recommended: Intellij)
2. Create a database on your local
3. Point to local database, user-name, password in application.properties file by editing the following properties
    spring.datasource.url= jdbc:postgresql://localhost:5432/<db-name>
    spring.datasource.username=<psql-user-name>
    spring.datasource.password=<psql-user-password>
4. Run the spring boot app by running org.storage.metadata.MetadataApplication class, this should create the tables in
   your local db as well as run the server.
5. run the following query from psql shell or GUI
        insert into roles(name) values ('ROLE_ADMIN');
6. Navigate to localhost:8083/swagger-ui.html in browser to view the API docs and test them.
