module todolist_addr::todolist {
    struct TodoList has key {
        tasks: Table<u64, Task>,
        set_task_event: event::EventHandle<Task>,
        task_counter: u64
    }

    struct Task has store, drop, copy {
        task_id: u64,
        address:address,
        content: String,
        completed: bool,
    }

}
