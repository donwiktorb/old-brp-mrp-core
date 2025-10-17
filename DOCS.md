• Scoreboard
    ○ Open
    ○ Close
    ○ Set
        § Title
    ○ Stats
        § Action
            □ Set
                ® Stats
                    ◊ []
            □ Add
                ® Name
                ® Value
                ® label
            □ Update
                ® Name
                ® value
    ○ Players
        § Action
            □ Add
                ® Id
                ® Name
                ® ping
            □ Remove
                ® id
            □ updateMulti
                ® [{id: id, ping:ping}]
            □ Set
                ® [{id,name,ping}]
            □ Update
                ® Id
                ® Ping
    ○ Fractions
        § Action
            □ Add
                ® Count
                ® Icon
                ® Name
                ® Color
            □ Set
                ® [{count, icon name color}]
            □ Getcount
            □ Update
                ® Name
                ® count
            □ updateMulti
                ® [{name, count}]
    ○ Progbar
        § Action
            □ createBar
                ® Time
                ® Task
                ® Retrun progbar_completed, task
    ○ Notify
        § Add
            □ Title
            □ content
        § Clear
    ○ MilitaryHud
        § Open
        § close
    ○ MenuPicker 
        § Open
            title
            name
            align
        § close
    ○ MenuList 
        § Open
            title
            namespace
            name
            rows
            head
        § close
    ○ MenuDialog 
        § Open
            name
            title
            align
            type ex. 'big'
        § close
            name
    ○ MenuCircle 
        § Open
            name
            title
            elements
        § close
            name
    ○ Menu 
        § Open
            name
            title
            align
            elements
        § close
            name
        § scroll
            up  
        § cancel 
        § scrollSide 
            right
    ○ LoadingScreen 
        § playerLoaded
        § loadingEvents 
        § loadMeIn 
            returns loadMeIn
    ○ Inventory 
        § open
            id
            inventories:[
                name
                label
                weight
                maxWeight
                items: [
                    slot
                    name
                    ammo
                    weight
                    label
                    description
                ]
            ]
        § close
    ○ Team 
        § open
        § close
    ○ Chat 
        § open
        § manage
            enable
        § messages
            add
        § suggestions
        § close
        cancel
            chat_state, active

