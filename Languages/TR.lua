TR = {
    ["Main"] = {
        Title = "Mek91 House Robbery",
        Response = "Sonuç"
    },

    ["Webhook"] = {
        ["Door"] = { 
            BackDoor = "Arka Kapıdan Kaçtı!",
            Out = "Girdiği Kapıdan Çıktı,",
            Login = "Kapıdan Girdi.",
            HouseLogin = "Girdiği Ev",
            HouseOut = "Çıkış Yaptığı Ev"
        },

        ["Combatlog"] = {
            Quit = "Polisten Kaçmak İçin Oyundan Çıktı!",
            Spawn = "Hırsız Evin İçinde Doğdu",
            House = "Ev Adı"
        },

        ["ControllingTheDoor"] = {
            ControlDoor = "Kapıyı Polis Kontrol Etti.",
            House = "Kontrol Ettiği Ev"
        },

        ["TryingToRobbery"] = { 
            TryDoor = "Kapıyı Denedi!",
            TryDoorLockPick = "Kapıyı Maymuncukla Denedi!",
            House = "Denediği Ev"
        },

        ["CurrentlyBeingRobbed"] = {
            Robbed = "Şu Anda Birisi Evi Soyuyor!",
            House = "Soyduğu Ev"
        },

        ["FoundedItem"] = {
            ItemName = "Bulduğu Item",
            Amount = "Adet",
            Place = "Bulduğu Yer",
            House = "Bulduğu Ev"
        },

        ["Captured"] = {
            Surrender = "Teslim Oldu!",
            NoSurrender = "Teslim Olmadı!",
            House = "Evin Adı"
        },

        ["Dead"] = {
            KilledByNpc = "Npc \' ler dümdüz etti! Kapının Önüne Attı.",
            StarvedToDeath = "Açlıktan Geberdi! Kapının Önüne Attı Npc \' ler",
            House = "Evin Adı"
        },

        ["PlayerInfo"] = {
            Title = "Oyuncu Bilgileri",
            PlayerId = "Oyuncu ID",
            Name = "İsim",
            Steam = "Steam",
            Discord = "Discord",
            License = "License",
            Xbox = "Xbox",
            Live = "Live",
            Ip = "Oyuncu IP"
        }
    },

    ["Ui"] = {
        ["PlayerSpeed"] = {
            Text = "Ses seviyesi"
        },

        ["SoundLevel"] = {
            SoHigh = "Çok Yüksek",
            High = "Yüksek",
            Normal = "Normal",
            Good = "İyi"
        },

        ["YesOrNo"] = {
            Surrounded = "Polis Etrafını Sardı",
            Yes = "Teslim Ol",
            Or = "Ya Da",
            No = "Teslim Olma"
        }
    },

    ["Notifications"] = {
        ["Police"] = {
            ["Door"] = {
                YouAreOffDuty = "Mesaide Değilsin!",
                InsufficientProfession = "Bunu Yapmak İçin Polis Olmalısın!",
                DoorControl = "İçeriyi Kolaçan Ettin. Temiz Görünüyor. Ya da Kaçtı!",
                CurrentRobberyExists = "Birisinin İçeriyi Talan Ettiğini Görüyorsun!",
                FollowingYou = "Artık Kapıyı Gözetliyorsun!",
                AlreadyFollowingYou = "Zaten Kapıyı Gözetliyorsun!",
                YourPolice = "Polisler Bu İşlemi Yapamaz!",
                
                ["Escape"] = {
                    Logout = "Gözetlediğin Kapıdan Kaçıyor!",
                    BackDoor = "Arka Kapıdan Kaçıyor!"
                }
            },

            ["Surrounded"] = {
                Surrendered = "\"Teslim Oluyorum\" Diye Bağrıyor! Kapının Önüne Diz Çökücekmiş!",
                NoSurrender = "\"Teslim Olmam\" Diye Bağırdı! Kapıları Tutuyorsun!",
                Announce = "\"Teslim Ol\" Diye Bağırdın! Cevap Bekliyorsun."
            },

            ["CombatlogThief"] = {
                Escaped = "Ev Sahipleriyle Beraber Uyuyor! Uyandığında Ev Sahipleri Onu Evden Atacak! Kapıda Erketeye Yat!"
            },

            ["Robbering"] = {
                ActiveHouseRoberring = "Ev Soygunu Yapılıyor!"  
            }
        },

        ["Thief"] = {
            ["Door"] = {
                NotFoundLockPick = "Maymuncuğunu Unutmuşsun Git Al Gel!",
                TryingTheDoor = "Kapıyı Maymuncukla Kurcalıyorsun!",
                CurrentRobberyExists = "Birisi Senden Önce Davranmış. Kapı Kilidinden Anladın!",
                ForceTheDoor = "Birisi Kapıyı Zorluyor. Polis ya da Başka Birisi!",
                InsufficientNumberOfPolice = "Şehirde Yeteri Kadar Polis Yok!"
            },

            ["Surrounded"] = {
                NoSurrender = "Polislere \"Teslim Olmuyorum!\" Diye Bağırdın. Başka Bir yol Bul!",
                TheresNoPlaceToEscape = "Kaçabileceğin Alanda Yok! Geldiğin Kapı Hariç!"
            },

            ["Npc"] = {
                KeepQuiet = "Ev Sahipleri \"One Amq?\" Şeklinde Mırıldandı Geri Uyudu.",
                YouWokeThem = "Onlar Silahlı Ve Uyandırdın. Kaç!!!",
                KillerNpc = "Ev Sahipleri Seni Pataklayıp Önce Tecavüz Edip. Sonra da Seni Dışarı Attılar."
            },

            ["Combatlog"] = {
                ThrownOut = "Ev Sahipleri Evlerinde Uyuduğunu Görünce Önce Seni Taciz Edip Sonra Dışarı Attılar!",
            },

            ["Dead"] = {
                StarvingToDeath = "Açlıktan Bayıldığını Görünce: \"Açın Halinden Anlayıp.\" Ağzına Verdiler."
            },

            ["FoundedItem"] = {
                Cash = "Para Buldun",
                ItemName = "Eşya Adı",
                Amount = "Adet"
            },

            ["Searchs"] = {
                Nightstand = "Kurcalıyorsun"
            },

            ["Duration"] = {
                Exiting = "Bok Kokusu Öldürecekti! Kendini Dışarı Attın.",
                Minute = "Dakika",
                Second = "Saniye",
                NotifyDuration = "Bok Kokusu Seni Zehirlemesine Kalan Süre"
            }
        }
    },

    ["AddItem"] = {
        Label = "Maymuncuk",
        Descrptn = "Kitli Kapıları Açmaya Yarar."
    }
}