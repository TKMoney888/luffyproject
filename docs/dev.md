# 2020-09-08

```
Traceback (most recent call last):
  File "/usr/lib/python3.6/threading.py", line 916, in _bootstrap_inner
    self.run()
  File "/usr/lib/python3.6/threading.py", line 864, in run
    self._target(*self._args, **self._kwargs)
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/utils/autoreload.py", line 54, in wrapper
    fn(*args, **kwargs)
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/core/management/commands/runserver.py", line 120, in inner_run
    self.check_migrations()
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/core/management/base.py", line 453, in check_migrations
    executor = MigrationExecutor(connections[DEFAULT_DB_ALIAS])
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/db/migrations/executor.py", line 18, in __init__
    self.loader = MigrationLoader(self.connection)
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/db/migrations/loader.py", line 49, in __init__
    self.build_graph()
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/db/migrations/loader.py", line 212, in build_graph
    self.applied_migrations = recorder.applied_migrations()
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/db/migrations/recorder.py", line 73, in applied_migrations
    if self.has_table():
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/db/migrations/recorder.py", line 56, in has_table
    return self.Migration._meta.db_table in self.connection.introspection.table_names(self.connection.cursor())
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/db/backends/base/base.py", line 256, in cursor
    return self._cursor()
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/db/backends/base/base.py", line 233, in _cursor
    self.ensure_connection()
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/db/backends/base/base.py", line 217, in ensure_connection
    self.connect()
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/db/backends/base/base.py", line 197, in connect
    self.init_connection_state()
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/db/backends/mysql/base.py", line 231, in init_connection_state
    if self.features.is_sql_auto_is_null_enabled:
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/utils/functional.py", line 80, in __get__
    res = instance.__dict__[self.name] = self.func(instance)
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/db/backends/mysql/features.py", line 82, in is_sql_auto_is_null_enabled
    cursor.execute('SELECT @@SQL_AUTO_IS_NULL')
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/db/backends/utils.py", line 103, in execute
    sql = self.db.ops.last_executed_query(self.cursor, sql, params)
  File "/home/moluo/.virtualenvs/luffy/lib/python3.6/site-packages/django/db/backends/mysql/operations.py", line 146, in last_executed_query
    query = query.decode(errors='replace')
AttributeError: 'str' object has no attribute 'decode'
```

??????:

```python
            query = query.decode(errors='replace')
    ??????:
            query = query.encode(errors='replace')
```



