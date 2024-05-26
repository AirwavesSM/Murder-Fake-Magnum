# Murder Fake Magnum (EN)

Attention!!! This addon is designed and works only in the Murder gamemode.

## Description

Adds a "Fake Magnum" weapon to the game, which is automatically issued to murder at beginning of each round (or any another role). It looks exactly like a regular magnum, but has much less damage than the original, which allows murder to pretend to be an bystander with a secret weapon.

## Settings/Console commands

### Server

-   **mu_fakemagnum_lootneed [0/15]** _(default: 2)_ - sets the required amount of loot needed to obtain the fake magnum
-   **mu_fakemagnum_lootneed_multiplier [0/1]** _(default: 1)_ - should the weapon be given for every X loot specified by the above command or given once (1 - yes, 0 - no)
-   **mu_fakemagnum_giveonstartrole [all/mur/bys/nil]** _(default: mur)_ - which roles should be given the weapon at the start of the round (all - killer and a random innocent, mur - killer, bys - random innocent, nil - none)
-   **mu_fakemagnum_autoselect [0/1]** _(default: 1)_ - should the magnum automatically be selected upon obtaining it (1 - yes, 0 - no)
-   **mu_fakemagnum_canpickup [all/mur/bys/nil]** _(default: all)_ - who can pick up and collect the magnum for loot. Also affects who can obtain it at the start of the round (all - anyone, mur - only killer, bys - only innocents, nil - no one)
-   **mu_fakemagnum_damage [0/500]** _(default: 17)_ - the damage dealt by the magnum. Changing this parameter may require a server restart.
-   **mu_english [english/russian and ect.]** _(default: english)_ - Magnum name and gamememode language

### Client

-   **mu_halo_render [0/1]** _(default: 1)_ - should outlines be displayed around all objects in the Murder gamemode (1 - yes, 0 - no)
-   **mu_halo_fake magnum [0/1]** _(default: 1)_ - should an outline be displayed around the fake magnum (1 - yes, 0 - no)

## Improvement plans

-   Setting up the ability to issue a weapon to an bystander ✔
-   Setting up the issue of weapons for clues ✔
-   Customize the dropout and selection of weapons by other players ✔
-   Damage Adjustment ✔
-   Possible support for all Murder languages ✔

Addon in workshop - https://steamcommunity.com/sharedfiles/filedetails/?id=2897038687

###### Addon version - v1.1.0
