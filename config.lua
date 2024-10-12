Config = {}

Config.ShopRob = {
    Rewards = math.random(500, 5000), -- ilość kasy z napadu.
    
    Webhook = '', -- kanał discord, na który zostaną wysłane informacje o napadach
    
    Cooldown = 20, -- odstęp między napadami w sekundach (tu: 20 sekund).
    
    Police = 'police', -- nazwa pracy policjantów.
    
    Sheriff = 'sheriff', -- nazwa drugiej pracy np. szeryfów.
    
    Potrzebni = 1, -- ilość potrzebnych policjantów, szeryfów do zrobienia napadu.
    
    Minigame = true, -- true/false czy chcemy minigrę: tak (true), nie (false).

    Duration = 5, -- ile czasu robi się napad w sekundach (tu: 4 sekundy).

    Anuluj = true -- true/false czy można anulować napad.
}

Config.Sejfy = {
    [1] = vector3(1126.6758, -980.1246, 45.4158),
    [2] = vector3(-43.7296, -1748.1484, 28.9946),
    [3] = vector3(28.2096, -1338.6373, 28.9837),
    [4] = vector3(-3048.3040, 585.4412, 7.2527),
    [5] = vector3(2548.8218, 384.8529, 108.0685),
    [6] = vector3(378.2469, 333.8123, 102.8874)
}

Config.Lang = {
    BrakPD = 'W mieście brakuje policji, aby zrobić napad.',

    ClickX = 'Kliknij X, aby anulować okradanie.',

    Cancel = 'Anulowałeś napad!',

    Fail = 'Nie udało ci się zrobić napadu!'
}
