register_command('exitgame', 

    array(
        'description': 'Unplugs from The Matrix',
        'permission': 'command.exitgame',
        'noPermMsg': 'Sorry you don\'t have permission to use this command.',
        'executor': closure() {        
            
            @plr = player()
            assign(@cooldown, 10)
            
            assign(@lastUsedMindLock, import(@plr."lastUsedMortal"))
            if(@lastUsedMindLock + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedMindLock, @cooldown), divide(time(),1000)))
                tmsg(@plr,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use this again!'))
                die()
            )

            include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
            _mortal(@plr)

            @ploc = ploc(@plr)
            @world = @ploc['world']

            if(has_permission(@plr,'is.ingame')){
                queue_push(closure(runas('~console','/warp vrexit '.@plr)))
                queue_push(closure(broadcast(@plr.color('RED').' has disconnected from Infinity:One')))
            }else{
                queue_push(closure(runas('~console','/warp '.@world.'exit '.@plr)))
                queue_push(closure(msg(color('RED').' Welcome back to the arcade!')))
            }
        }
    )
)
