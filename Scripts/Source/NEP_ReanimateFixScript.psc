Scriptname NEP_ReanimateFixScript extends Quest
{Main Reanimate Fix control script.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

ReferenceAlias[] Property ZombieAliases Auto
{Aliases for storing reanimated thrall references.}

FormList Property NEP_ZombieFormList Auto
{Form list of tracked Zombies.}

Faction Property NEP_ReanimateFixNoDisintegrateFaction Auto
{Faction for zombies that should not disintegrate on death.}

Actor Property PlayerRef Auto
{The player.}

Perk Property NEP_ReanimateFixPerk Auto
{Perk that applies entry point for reanimate effect fix.}

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function TrackZombie(Actor Target)

  Bool AliasFound = False
  Int Index = ZombieAliases.Length

  If NEP_ZombieFormList.HasForm(Target)
    Return
  EndIf

  While Index && !AliasFound
    Index -= 1

    ReferenceAlias ZombieAlias = ZombieAliases[Index]
    Actor Zombie = ZombieAlias.GetReference() as Actor

    If Zombie != None
      If Zombie.IsDead() || Zombie.IsDisabled() || Zombie.IsDeleted()
        CleanUpZombie(ZombieAlias, Zombie)

        Zombie = None
      EndIf
    EndIf

    If Zombie == None
      AliasFound = True
      NEP_ZombieFormList.AddForm(Target)
      ZombieAlias.ForceRefTo(Target as ObjectReference)
    EndIf
  EndWhile

EndFunction

Function CleanUpZombie(ReferenceAlias ZombieAlias, Actor Zombie)

  ZombieAlias.Clear()
  Zombie.Kill()
  NEP_ZombieFormList.RemoveAddedForm(Zombie)
  Zombie.RemoveFromFaction(NEP_ReanimateFixNoDisintegrateFaction)

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnInit()

  If !PlayerRef.HasPerk(NEP_ReanimateFixPerk)
    PlayerRef.AddPerk(NEP_ReanimateFixPerk)
  EndIf

EndEvent
