webhook = {}


--------------------
-- Admin Webhooks --
--------------------

-- Whitelist
webhook.Whitelist = ''
webhook.Unwhitelist = ''

-- Rank
webhook.AddGroup = ''
webhook.RemoveGroup = ''

-- Basic
webhook.Kick = ''

-- Ban
webhook.Ban = ''
webhook.Unban = ''
webhook.UnbanAlle = ''

--Advarsel
webhook.Warn = ''
webhook.ClearWarn = ''

-- Revive andre spillere
webhook.Revive = ''
webhook.ReviveAlle = ''

-- Reperation af køretøj
webhook.Repair = ''

-- Teleport
webhook.TpToMe = ''
webhook.TpTo = ''

-- Spawn ting
webhook.SpawnMoney = ''
webhook.SpawnItem = ''

-- Admin call
webhook.AdminCall = ''

-- Salg af køretøj
webhook.SellCar = ''

-- Noclip
webhook.Noclip = ''

-- Spawn køretøj
webhook.SpawnVehicle = ''

-----------------------
-- Bussines Webhooks --
-----------------------

-- Virksomhed oprettelse
webhook.CreateBussines = ''

------------------
-- Item Webhook --
------------------

-- Item logs
webhook.GiveItem = ''
webhook.DestroyItem = ''

--------------------
-- Penge Webhooks --
--------------------

-- Money logs
webhook.SetMoney = ''
webhook.GiveMoney = ''

---------------------
-- System Webhooks --
---------------------

-- Base logs
webhook.Join = ''
webhook.Leave = ''

webhook.Errorlog = ''
-------------------
-- Bilforhandler --
-------------------

-- Køb af køretøj
webhook.BuyCar = ''

---------------------
-- Røveri Webhooks --
---------------------

-- Bankrøveri
webhook.Robbery = ''

---------------------
-- Market Webhooks --
---------------------

--Køb af våben
webhook.BuyWeapon = ''

------------------------
-- Anticheat Webhooks --
------------------------

webhook.HoneyPot = ''


------------------------
-- Politi Webhooks --
------------------------

webhook.Panik = ''
webhook.Gps = ''

return webhook
