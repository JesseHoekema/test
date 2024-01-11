#!/bin/bash

TODO_FILE="todo.txt"

initialize_todo_file() {
    touch "$TODO_FILE"
}

add_task() {
    local task="$1"
    echo "$task" >> "$TODO_FILE"
    echo "Taak toegevoegd: $task"
}

list_tasks() {
    echo "To-Do Lijst:"
    if [ -s "$TODO_FILE" ]; then
        cat -n "$TODO_FILE"
    else
        echo "Geen taken gevonden."
    fi
}

remove_task() {
    local task_number="$1"
    if [ -s "$TODO_FILE" ]; then
        sed -i "${task_number}d" "$TODO_FILE"
        echo "Taak verwijderd."
    else
        echo "Geen taken om te verwijderen."
    fi
}

clear_tasks() {
    > "$TODO_FILE"
    echo "Alle taken zijn verwijderd."
}

# Controleer of het todo-bestand bestaat, anders maak het aan
initialize_todo_file

while true; do
    echo -e "\n1. Voeg taak toe"
    echo "2. Toon taken"
    echo "3. Verwijder taak"
    echo "4. Wis alle taken"
    echo "5. Exit"

    read -p "Voer het nummer van de gewenste actie in: " choice

    case $choice in
        1)
            read -p "Voer de nieuwe taak in: " new_task
            add_task "$new_task"
            ;;
        2)
            list_tasks
            ;;
        3)
            list_tasks
            read -p "Voer het nummer van de taak in om te verwijderen: " task_number
            remove_task "$task_number"
            ;;
        4)
            clear_tasks
            ;;
        5)
            echo "Tot ziens!"
            exit 0
            ;;
        *)
            echo "Ongeldige keuze. Probeer opnieuw."
            ;;
    esac
done
