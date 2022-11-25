# FlaxHosting-Filer
 Dette er nogle simple clean server filer med henblik på at optimere måden danske vRP servere køre på


# Optimering
- Hele serverens SQL system er baseret på oxmysql istedet for det tidligere kendte og outdatede system vrp_mysql
- Tilføjet et simpelt webhook system som giver mulighed for at man nemt kan gå ind og configurere sine webhook (vrp>cfg>webhooks)
- Fjernet bugs og fejl som kunne misbruges af moddere herunder (vrp_trucker, vrp_bilskrot, vrp_mysql og andre små ting)
- Optimeret responsen mellem database og server så såkaldte "vrp fejl" ikke skulle ske for fremtiden
- Tilføjet små ændringer til UI for at forbedrer oplevelse
- Tilføjet advarsel system under admin menuen
- Tilføjet en command til at revive alle, /revivealle
- Tilføjet en command til at unbanne alle (kun id 1 kan) /unbanalle
- Tilføjet impound system, så politiet kan impounde andres køretøjer



# FlaxHosting
- Server filerne er lavet i sammenarbejde med FlaxHosting og deres kunder men er ment som at være et open source projekt for at genoplive vRP frameworket


- Credits til DevoNetwork for filerne som grundbase



# Fejl og Mangler
- Hvis du finder en fejl eller mener der er noget som burde ændres er du velkommen til at oprette en issue så vi kan kigge nærmere på det
