# Mek91-HouseRobbery
👇 VIDEO 👇

[![Watch Script Usage Video](https://cdn.discordapp.com/attachments/1085584380723994684/1140297075301568542/M91HR.png)](https://youtu.be/5k2A2PTvZe8 "Watch Script Usage Video")


👇WEBHOOKS IMAGE👇

![alt text](https://cdn.discordapp.com/attachments/1085584380723994684/1140295959658627249/COMBATLOG.png)

![alt text](https://cdn.discordapp.com/attachments/1085584380723994684/1140295959931260968/CURRENTLYBEINGROBBED.png)

![alt text](https://cdn.discordapp.com/attachments/1085584380723994684/1140295960216485898/DEAD.png)

![alt text](https://cdn.discordapp.com/attachments/1085584380723994684/1140295960526848010/FOUNDITEM.png)

![alt text](https://cdn.discordapp.com/attachments/1085584380723994684/1140295960753344593/BACKDOOR.png)

![alt text](https://cdn.discordapp.com/attachments/1085584380723994684/1140295960996626472/CAPTURED.png)

![alt text](https://cdn.discordapp.com/attachments/1085584380723994684/1140295989509500968/LOGINDOOR.png)

![alt text](https://cdn.discordapp.com/attachments/1085584380723994684/1140295989735981107/OUTDOOR.png)

![alt text](https://cdn.discordapp.com/attachments/1085584380723994684/1140295990126067813/POLICECONTROLDOOR.png)

![alt text](https://cdn.discordapp.com/attachments/1085584380723994684/1140295990381916333/TRYINGTOROBBERY.png)

👇PURPOSE OF SCRIPT👇

It is superior to all scripts on the market and the main reason why it is superior is that it is superior (resmon value: 0.0) and you can add as many peelable areas as you wish and you can set which item and how much chance range you want the peelable areas to give the number of items.

👇EXAMPLE👇

Command: /+Mek91HR ExampleHouse1 | ["SpawnInsideTheHouse"] To check the status, you can check this way by entering the house name after the script is restarted and check if the size of the radius is enough for the corners of the house.

```
Mek91_HR.Fields = {
    ["ExampleHouseRobbery"] = { -- You can give any name you wish. ||| EXAMPLE |||
        HouseName = "ExampleHouse1", -- It is mandatory to enter the house name here!
        RobberyDuration = 4, -- Max minutes he can stay inside the house. Min Minute "1"

        ["Door"] = { -- Don't touch!

            ["Login"] = { -- Don't touch!
                ["Target"] = { -- Don't touch!
                    ["Location"] = { -- Don't touch!
                        TargetLocation = vector3(1265.63, -648.67, 68.12), -- If you want it to be triggered from where, write the coordinate as Vector3 here!
                        TargetMinZ = 67.9, -- Enter the Minimum Z Height so that it can trigger This is usually the option with vector3(none, none, 34) "34" and it varies.
                        TargetMaxZ = 69, -- Enter the Maximum Z Height so that it can trigger This is usually the option with vector3(none, none, 35) "35" and it varies.
                        LeftWidth = 5.3, -- Adjust the LeftWidth of the Area!
                        RightWidth = 4.0 -- Adjust the RightWidth of the Area!
                    },

                    ["PublicOption"] = { -- Don't touch!
                        label = "Example Open the door with a lockpick",
                        icon = "far fa-credit-card"
                    },

                    ["PoliceOption"] = { -- Don't touch!
                        label = "Example Police",
                        icon = "far fa-credit-card",
                        job = "police"
                    }
                },

                AfterCoord = vector4(346.5, -1012.96, -99.2, 5.69) -- vector3() and Player Head = vector4(x, y, z, Heading) "Entrance Gate"
            },

            ["Logout"] = { -- Don't touch!
                ["Target"] = { -- Don't touch!
                    ["Location"] = { -- Don't touch!
                        TargetLocation = vector3(346.51, -1013.17, -99.2),
                        TargetMinZ = -100,
                        TargetMaxZ = -98,
                        LeftWidth = 5.3,
                        RightWidth = 4.0
                    },

                    ["PublicOption"] = { -- Don't touch!
                        label = "Example Exit out the door",
                        icon = "far fa-credit-card"
                    },
                },

                AfterCoord = vector4(1265.8, -648.28, 67.92, 296.39) -- vector3() and Player Head = vector4(x, y, z, Heading) "Exit Gate"
            },

            ["BackDoorOut"] = { -- Don't touch!
                BackDoor = false, -- You can use "true" in places with rear doors. And the police will be notified to hold the rear and front entrances.

                ["Target"] = { -- Don't touch!
                    ["Location"] = { -- Don't touch!
                        TargetLocation = vector3(0, 0, 0),
                        TargetMinZ = 0,
                        TargetMaxZ = 0,
                        LeftWidth = 0.0,
                        RightWidth = 0.0
                    },

                    ["PublicOption"] = { -- Don't touch!
                        label = "Example Run out the back door",
                        icon = "far fa-credit-card"
                    },
                },

                AfterCoord = vector4(0, 0, 0, 0) -- vector3() and Player Head = vector4(x, y, z, Heading) "BackDoor Gate"
            }
        },

        ["Npc"] = { -- Don't touch!
            ["Location"] = { -- Enter vector4() as many times as you want to add. Increase the "NpcList" content in "Mek91_HR.Npc" for diversity.
                vector4(350.16, -994.64, -99.2, 27.01),
                vector4(340.42, -998.31, -99.2, 33.24),
                vector4(346.55, -1006.9, -99.2, 236.46)
            }
        },

        ["Places"] = { -- Don't touch! | In this "EXAMPLE", you can place robbery areas in as many houses as you want in the name you want by taking it tolerance.
            
            ["Kitchen"] = { -- EXAMPLE
                ["Target"] = {
                    ["Location"] = {
                        TargetLocation = vector3(343.21, -1003.24, -99.2),
                        TargetMinZ = -100,
                        TargetMaxZ = -98,
                        LeftWidth = 5.3,
                        RightWidth = 4.0
                    },

                    ["PublicOption"] = {
                        label = "Example Kitchen",
                        icon = "far fa-credit-card",
                        name = "Kitchen", -- It must be an independent name and must be written down!
                    },
                },

                ["Items"] = {
                    {item = "tosti", min = 1, max = 3},
                    {item = "sandwich", min = 1, max = 2},
                    {item = "water_bottle", min = 1, max = 1}
                }
            },

            ["Chest"] = {
                ["Target"] = {
                    ["Location"] = {
                        TargetLocation = vector3(351.96, -998.89, -99.2),
                        TargetMinZ = -100,
                        TargetMaxZ = -98,
                        LeftWidth = 5.3,
                        RightWidth = 4.0
                    },

                    ["PublicOption"] = {
                        label = "Example Chest",
                        icon = "far fa-credit-card",
                        name = "Chest",
                    },
                },

                ["Items"] = {
                    {item = "cash", min = 500, max = 10000},
                    {item = "plastic", min = 1, max = 4},
                    {item = "rolex", min = 1, max = 2},
                    {item = "diamond_ring", min = 1, max = 1},
                    {item = "goldchain", min = 1, max = 1},
                    {item = "weed_skunk", min = 1, max = 5},
                    {item = "thermite", min = 1, max = 1}
                }
            },

            ["LivingRoom"] = { 
                ["Target"] = {
                    ["Location"] = {
                        TargetLocation = vector3(338.11, -996.73, -99.2),
                        TargetMinZ = -100,
                        TargetMaxZ = -98,
                        LeftWidth = 5.3,
                        RightWidth = 4.0
                    },

                    ["PublicOption"] = {
                        label = "Example LivingRoom",
                        icon = "far fa-credit-card",
                        name = "LivingRoom",
                    },
                },

                ["Items"] = {
                    {item = "cash", min = 500, max = 10000},
                    {item = "plastic", min = 1, max = 4},
                    {item = "rolex", min = 1, max = 2},
                    {item = "diamond_ring", min = 1, max = 1},
                    {item = "goldchain", min = 1, max = 1},
                    {item = "weed_skunk", min = 1, max = 5},
                    {item = "thermite", min = 1, max = 1}
                }
            },

            ["Wardrobe"] = { 
                ["Target"] = {
                    ["Location"] = {
                        TargetLocation = vector3(350.71, -993.52, -99.2),
                        TargetMinZ = -100,
                        TargetMaxZ = -98,
                        LeftWidth = 5.3,
                        RightWidth = 4.0
                    },

                    ["PublicOption"] = {
                        label = "Example Wardrobe",
                        icon = "far fa-credit-card",
                        name = "Wardrobe",
                    },
                },

                ["Items"] = {
                    {item = "cash", min = 500, max = 10000},
                    {item = "plastic", min = 1, max = 4},
                    {item = "rolex", min = 1, max = 2},
                    {item = "diamond_ring", min = 1, max = 1},
                    {item = "goldchain", min = 1, max = 1},
                    {item = "weed_skunk", min = 1, max = 5},
                    {item = "thermite", min = 1, max = 1}
                }
            },

            ["Bathroom"] = { 
                ["Target"] = {
                    ["Location"] = {
                        TargetLocation = vector3(347.23, -994.19, -99.2),
                        TargetMinZ = -100,
                        TargetMaxZ = -98,
                        LeftWidth = 5.3,
                        RightWidth = 4.0
                    },

                    ["PublicOption"] = {
                        label = "Example Bathroom",
                        icon = "far fa-credit-card",
                        name = "Bathroom",
                    },
                },

                ["Items"] = {
                    {item = "cash", min = 500, max = 10000},
                    {item = "plastic", min = 1, max = 4},
                    {item = "rolex", min = 1, max = 2},
                    {item = "diamond_ring", min = 1, max = 1},
                    {item = "goldchain", min = 1, max = 1},
                    {item = "weed_skunk", min = 1, max = 5},
                    {item = "thermite", min = 1, max = 1}
                }
            },

            ["Nightstand"] = { 
                ["Target"] = {
                    ["Location"] = {
                        TargetLocation = vector3(346.17, -1001.68, -99.2),
                        TargetMinZ = -100,
                        TargetMaxZ = -98,
                        LeftWidth = 5.3,
                        RightWidth = 4.0
                    },

                    ["PublicOption"] = {
                        label = "Example Nightstand",
                        icon = "far fa-credit-card",
                        name = "Nightstand",
                    },
                },

                ["Items"] = {
                    {item = "cash", min = 500, max = 10000},
                    {item = "plastic", min = 1, max = 4},
                    {item = "rolex", min = 1, max = 2},
                    {item = "diamond_ring", min = 1, max = 1},
                    {item = "goldchain", min = 1, max = 1},
                    {item = "weed_skunk", min = 1, max = 5},
                    {item = "thermite", min = 1, max = 1}
                }
            },

            ["Drawer"] = { 
                ["Target"] = {
                    ["Location"] = {
                        TargetLocation = vector3(339.28, -1003.35, -99.2),
                        TargetMinZ = -100,
                        TargetMaxZ = -98,
                        LeftWidth = 5.3,
                        RightWidth = 4.0
                    },

                    ["PublicOption"] = {
                        label = "Example Drawer",
                        icon = "far fa-credit-card",
                        name = "Drawer",
                    },
                },

                ["Items"] = {
                    {item = "cash", min = 500, max = 10000},
                    {item = "plastic", min = 1, max = 4},
                    {item = "rolex", min = 1, max = 2},
                    {item = "diamond_ring", min = 1, max = 1},
                    {item = "goldchain", min = 1, max = 1},
                    {item = "weed_skunk", min = 1, max = 5},
                    {item = "thermite", min = 1, max = 1}
                }
            },

        },

        ["SpawnInsideTheHouse"] = { -- Don't touch!
            -- Open f8 and type +Mek91HR HouseName so you can check if you have set the field correctly.
            Zone = vector3(343.53, -1000.07, -99.2), -- House Centre Coordinate.
            Radius = 15, -- House Centre Coordinate Width And adjust here by examining the Debugs!

            ["Height"] = { -- Don't touch!
                Min = -100, -- House Minimum Height
                Max = -96, -- House Maximum Height
            }
        },

        ["Blip"] = { -- Don't touch!
            Blip = true, -- Do you want it on the map?
            BlipName = "Example House Robbery", -- Write Blip Name!
            BlipId = 40, -- Select the Icon Id to be displayed on the map. https://docs.fivem.net/docs/game-references/blips
            BlipColorId = 1, -- Select Icon Colour. https://docs.fivem.net/docs/game-references/blips
            BlipDisplay = 4, -- Determines how the blip will appear on the map.
            BlipScale = 0.6, -- Adjusting the size of the blip.
            BlipLocation = vector2(1265.63, -648.67), -- Write as vector2() or vector3() at which location you want it to appear on the map.
        },
    },

    ["ExampleHouseRobbery2"] = { -- You can give any name you wish. ||| EXAMPLE |||
        HouseName = "ExampleHouse2", -- It is mandatory to enter the house name here!
        RobberyDuration = 6, -- Max minutes he can stay inside the house. Min Minute "1"

        ["Door"] = { -- Don't touch!

            ["Login"] = { -- Don't touch!
                ["Target"] = { -- Don't touch!
                    ["Location"] = { -- Don't touch!
                        TargetLocation = vector3(-500.7, 551.91, 120.6), -- If you want it to be triggered from where, write the coordinate as Vector3 here!
                        TargetMinZ = 120, -- Enter the Minimum Z Height so that it can trigger This is usually the option with vector3(none, none, 34) "34" and it varies.
                        TargetMaxZ = 122, -- Enter the Maximum Z Height so that it can trigger This is usually the option with vector3(none, none, 35) "35" and it varies.
                        LeftWidth = 5.3, -- Adjust the LeftWidth of the Area!
                        RightWidth = 4.0 -- Adjust the RightWidth of the Area!
                    },

                    ["PublicOption"] = { -- Don't touch!
                        label = "Example Open the door with a lockpick",
                        icon = "far fa-credit-card"
                    },

                    ["PoliceOption"] = { -- Don't touch!
                        label = "Example Police",
                        icon = "far fa-credit-card",
                        job = "police"
                    }
                },

                AfterCoord = vector4(-606.29, 60.4, -182.38, 120.21) -- vector3() and Player Head = vector4(x, y, z, Heading) "Entrance Gate"
            },

            ["Logout"] = { -- Don't touch!
                ["Target"] = { -- Don't touch!
                    ["Location"] = { -- Don't touch!
                        TargetLocation = vector3(-606.28, 60.54, -182.38),
                        TargetMinZ = -184,
                        TargetMaxZ = -181,
                        LeftWidth = 3.0,
                        RightWidth = 3.0
                    },

                    ["PublicOption"] = { -- Don't touch!
                        label = "Example Exit out the door",
                        icon = "far fa-credit-card"
                    },
                },

                AfterCoord = vector4(-500.54, 552.26, 120.59, 343.77) -- vector3() and Player Head = vector4(x, y, z, Heading) "Exit Gate"
            },

            ["BackDoorOut"] = { -- Don't touch!
                BackDoor = true, -- You can use "true" in places with rear doors. And the police will be notified to hold the rear and front entrances.

                ["Target"] = { -- Don't touch!
                    ["Location"] = { -- Don't touch!
                        TargetLocation = vector3(-602.09, 53.57, -183.58),
                        TargetMinZ = -184,
                        TargetMaxZ = -181,
                        LeftWidth = 2.5,
                        RightWidth = 2.5
                    },

                    ["PublicOption"] = { -- Don't touch!
                        label = "Example Run out the back door",
                        icon = "far fa-credit-card"
                    },
                },

                AfterCoord = vector4(-496.84, 523.97, 116.76, 164.11) -- vector3() and Player Head = vector4(x, y, z, Heading) "BackDoor Gate"
            }
        },

        ["Npc"] = { -- Don't touch!
            ["Location"] = { -- Enter vector4() as many times as you want to add. Increase the "NpcList" content in "Mek91_HR.Npc" for diversity.
                vector4(-616.36, 59.1, -182.38, 63.73),
                vector4(-622.53, 53.98, -182.98, 0.28),
                vector4(-611.99, 46.62, -182.98, 46.46),
                vector4(-594.57, 50.78, -183.58, 62.4),
                vector4(-603.3, 41.97, -183.18, 273.44)
            }
        },

        ["Places"] = { -- Don't touch! | In this "EXAMPLE", you can place robbery areas in as many houses as you want in the name you want by taking it tolerance.
            
            ["Kitchen"] = { -- EXAMPLE
                ["Target"] = {
                    ["Location"] = {
                        TargetLocation = vector3(-618.5, 41.79, -182.98),
                        TargetMinZ = -184,
                        TargetMaxZ = -181,
                        LeftWidth = 5.3,
                        RightWidth = 4.0
                    },

                    ["PublicOption"] = {
                        label = "Example Kitchen",
                        icon = "far fa-credit-card",
                        name = "Kitchen", -- It must be an independent name and must be written down!
                    },
                },

                ["Items"] = {
                    {item = "tosti", min = 1, max = 3},
                    {item = "sandwich", min = 1, max = 2},
                    {item = "water_bottle", min = 1, max = 1}
                }
            },

            ["Printer"] = {
                ["Target"] = {
                    ["Location"] = {
                        TargetLocation = vector3(-625.27, 55.59, -182.98),
                        TargetMinZ = -184,
                        TargetMaxZ = -181,
                        LeftWidth = 5.3,
                        RightWidth = 4.0
                    },

                    ["PublicOption"] = {
                        label = "Example Chest",
                        icon = "far fa-credit-card",
                        name = "Printer",
                    },
                },

                ["Items"] = {
                    {item = "cash", min = 500, max = 10000},
                    {item = "plastic", min = 1, max = 4},
                    {item = "rolex", min = 1, max = 2},
                    {item = "diamond_ring", min = 1, max = 1},
                    {item = "goldchain", min = 1, max = 1},
                    {item = "weed_skunk", min = 1, max = 5},
                    {item = "thermite", min = 1, max = 1}
                }
            },

            ["LivingRoom"] = { 
                ["Target"] = {
                    ["Location"] = {
                        TargetLocation = vector3(-601.69, 44.88, -183.18),
                        TargetMinZ = -184,
                        TargetMaxZ = -181,
                        LeftWidth = 5.3,
                        RightWidth = 4.0
                    },

                    ["PublicOption"] = {
                        label = "Example LivingRoom",
                        icon = "far fa-credit-card",
                        name = "LivingRoom",
                    },
                },

                ["Items"] = {
                    {item = "cash", min = 500, max = 10000},
                    {item = "plastic", min = 1, max = 4},
                    {item = "rolex", min = 1, max = 2},
                    {item = "diamond_ring", min = 1, max = 1},
                    {item = "goldchain", min = 1, max = 1},
                    {item = "weed_skunk", min = 1, max = 5},
                    {item = "thermite", min = 1, max = 1}
                }
            },

            ["Wardrobe"] = { 
                ["Target"] = {
                    ["Location"] = {
                        TargetLocation = vector3(-595.66, 56.32, -183.58),
                        TargetMinZ = -184,
                        TargetMaxZ = -181,
                        LeftWidth = 4.0,
                        RightWidth = 4.0
                    },

                    ["PublicOption"] = {
                        label = "Example Wardrobe",
                        icon = "far fa-credit-card",
                        name = "Wardrobe",
                    },
                },

                ["Items"] = {
                    {item = "cash", min = 500, max = 10000},
                    {item = "plastic", min = 1, max = 4},
                    {item = "rolex", min = 1, max = 2},
                    {item = "diamond_ring", min = 1, max = 1},
                    {item = "goldchain", min = 1, max = 1},
                    {item = "weed_skunk", min = 1, max = 5},
                    {item = "thermite", min = 1, max = 1}
                }
            },

            ["Bathroom"] = { 
                ["Target"] = {
                    ["Location"] = {
                        TargetLocation = vector3(-589.82, 52.44, -183.58),
                        TargetMinZ = -184,
                        TargetMaxZ = -181,
                        LeftWidth = 5.3,
                        RightWidth = 4.0
                    },

                    ["PublicOption"] = {
                        label = "Example Bathroom",
                        icon = "far fa-credit-card",
                        name = "Bathroom",
                    },
                },

                ["Items"] = {
                    {item = "cash", min = 500, max = 10000},
                    {item = "plastic", min = 1, max = 4},
                    {item = "rolex", min = 1, max = 2},
                    {item = "diamond_ring", min = 1, max = 1},
                    {item = "goldchain", min = 1, max = 1},
                    {item = "weed_skunk", min = 1, max = 5},
                    {item = "thermite", min = 1, max = 1}
                }
            },

            ["Nightstand"] = { 
                ["Target"] = {
                    ["Location"] = {
                        TargetLocation = vector3(-593.65, 46.93, -183.58),
                        TargetMinZ = -184,
                        TargetMaxZ = -181,
                        LeftWidth = 2.0,
                        RightWidth = 2.0
                    },

                    ["PublicOption"] = {
                        label = "Example Nightstand",
                        icon = "far fa-credit-card",
                        name = "Nightstand",
                    },
                },

                ["Items"] = {
                    {item = "cash", min = 500, max = 10000},
                    {item = "plastic", min = 1, max = 4},
                    {item = "rolex", min = 1, max = 2},
                    {item = "diamond_ring", min = 1, max = 1},
                    {item = "goldchain", min = 1, max = 1},
                    {item = "weed_skunk", min = 1, max = 5},
                    {item = "thermite", min = 1, max = 1}
                }
            },

        },

        ["SpawnInsideTheHouse"] = { -- Don't touch!
            -- Open f8 and type +Mek91HR HouseName so you can check if you have set the field correctly.
            Zone = vector3(-609.57, 50.28, -182.98), -- House Centre Coordinate.
            Radius = 23, -- House Centre Coordinate Width And adjust here by examining the Debugs!

            ["Height"] = { -- Don't touch!
                Min = -185, -- House Minimum Height
                Max = -180, -- House Maximum Height
            }
        },

        ["Blip"] = { -- Don't touch!
            Blip = true, -- Do you want it on the map?
            BlipName = "Example House2 Robbery", -- Write Blip Name!
            BlipId = 40, -- Select the Icon Id to be displayed on the map. https://docs.fivem.net/docs/game-references/blips
            BlipColorId = 1, -- Select Icon Colour. https://docs.fivem.net/docs/game-references/blips
            BlipDisplay = 4, -- Determines how the blip will appear on the map.
            BlipScale = 0.6, -- Adjusting the size of the blip.
            BlipLocation = vector2(-500.7, 551.91), -- Write as vector2() or vector3() at which location you want it to appear on the map.
        },
    },
}
```
["Places"] you can add as much as you want to the content of the field. and you can remove what you want. and you can add as many houses as you want, like the 2 house examples here...
