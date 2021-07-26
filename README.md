# Rundeck Community + OpenLDAP + Oracle11g

Rundeck community example with OpenLDAP and Oracle as backend.

## Setup:

1) Download the Oracle JDBC driver and place in lib/ .

2) Bring up the Oracle container first: `docker-composer up -d oracle`

3) Connect and setup: `su - oracle` and later start sqlplus: `sqlplus / as sysdba`

4) Under sqlplus execute the following commands:

```sql
create tablespace rundeck datafile 'rundeck.dat' size 10M autoextend on;
alter session set "_ORACLE_SCRIPT"=true;
create user rundeckuser identified by mypassword default tablespace rundeck;
grant create session to rundeckuser;
grant create sequence to rundeckuser;
grant create table to rundeckuser;
grant unlimited tablespace to rundeckuser;
```

5) Exit Sqlplus with the `Ctrl+D` keys combination and exit the oracle/root session with the `exit` command.

6) Now start Rundeck+LDAP containers: `docker-compose up -d rundeck ldap` (this action may take a few seconds).

7) Open your favorite browser and go to `http://localhost:4440` and you can enter to Rundeck with some users defined in the [ldif file](https://github.com/rundeck/docker-zoo/blob/master/ldap/ldif/50-bootstrap.ldif), for example, for admin user: user: `admin` password: `admin`, or another profile like user: `test` password: `test`.

By default, for non "admin" users you need to define [ACL rules](https://docs.rundeck.com/docs/manual/document-format-reference/aclpolicy-v10.html#aclpolicy) to give/restrict access to projects and jobs.
