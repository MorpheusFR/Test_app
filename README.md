# Ruby on Rails Tutorial [*My app*](https://morph-app.herokuapp.com)</a>

This is the sample application for
[*Ruby on Rails Tutorial:
Learn Web Development with Rails*](http://www.railstutorial.org/)
by [Michael Hartl](http://www.michaelhartl.com/).

## License

All source code in the [Ruby on Rails Tutorial](http://railstutorial.org/)
is available jointly under the MIT License and the Beerware License. See
[LICENSE.md](LICENSE.md) for details.

For more information, see the
[*Ruby on Rails Tutorial* book](http://www.railstutorial.org/book).

Given tables:

    todo_items (id, content, todo_list_id, created_at, updated_at, completed_at, priority)
    todo_lists (id, title, description, created_at, updated_at, user_id)

Queries for:

1.Get all statuses, not repeating, alphabetically ordered

```
$ select DISTINCT completed_at from todo_items order by completed_at
```

2.Get the count of all tasks in each project, order by tasks count descending

```
select count(*) as count_todo_items from todo_items group by todo_list_id order by count_todo_items desc
```

3.Get the count of all tasks in each project, order by project names

```
select (select count(*) from todo_items where todo_list_id=todo_lists.id) as Tasks, todo_lists.title as Projects from todo_lists order by title desc
```

4.Get the tasks for all projects having the name beginning with "N" letter

```
select todo_items.id, todo_items.content, todo_items.completed_at from todo_items,todo_lists where todo_items.todo_list_id=todo_lists.id and todo_lists.title like 'N%'
```

5.Get the list of all projects containing the 'a' letter in the middle of the name, and show the tasks count near each project. Mention that there can exist projects without tasks and tasks with project_id = NULL.

```
select todo_lists.title, (select count(*) from todo_items where todo_items.todo_list_id=todo_lists.id) from todo_lists where todo_lists.title like '_%a%_'
```

6.Get the list of tasks with duplicate names. Order alphabetically.

```
select id, content as Task_name, completed_at as Status, todo_list_id from todo_items where content in (select content from todo_items group by content having (COUNT(content)>1)) order by content
```

7.Get the list of tasks having several exact matches of both name and status, from the project 'Garage'. Order by matches count.

```
select count(*) as matches_count, todo_items.content ,todo_items.completed_at from todo_items, todo_lists where todo_lists.title='Garage' and todo_list_id = todo_lists.id group by todo_items.content, todo_items.completed_at having (count(*) >1) order by matches_count
```

8.Get the list of project names having more than 10 tasks in status 'completed'. Order by project_id

```
select title from todo_lists where id in (select todo_list_id from todo_items, todo_lists where completed_at='completed' and todo_list_id = todo_lists.id group by todo_list_id having (count(*) >10)) order by id
```
