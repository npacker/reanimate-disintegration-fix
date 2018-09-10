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

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function InternalCleanUpZombie(ReferenceAlias ZombieAlias, Actor Zombie)

  ZombieAlias.Clear()
  Zombie.Kill()
  NEP_ZombieFormList.RemoveAddedForm(Zombie)
  Zombie.RemoveFromFaction(NEP_ReanimateFixNoDisintegrateFaction)

EndFunction

Bool Function TrackZombie(Actor Target)

  GoToState("Busy")

  Bool AliasFound = False
  Int Index = ZombieAliases.Length

  If NEP_ZombieFormList.HasForm(Target)
    GoToState("")

    Return True
  EndIf

  While Index && !AliasFound
    Index -= 1

    ReferenceAlias ZombieAlias = ZombieAliases[Index]
    Actor Zombie = ZombieAlias.GetReference() as Actor

    If Zombie != None
      If Zombie.IsDead() || Zombie.IsDisabled() || Zombie.IsDeleted()
        InternalCleanUpZombie(ZombieAlias, Zombie)

        Zombie = None
      EndIf
    EndIf

    If Zombie == None
      AliasFound = True
      NEP_ZombieFormList.AddForm(Target)
      ZombieAlias.ForceRefTo(Target as ObjectReference)
    EndIf
  EndWhile

  GoToState("")

  Return True

EndFunction

Bool Function CleanUpZombie(ReferenceAlias ZombieAlias, Actor Zombie)

  GoToState("Busy")
  InternalCleanUpZombie(ZombieAlias, Zombie)
  GoToState("")

  Return True

EndFunction

State Busy

  Bool Function TrackZombie(Actor Target)
    Return False
  EndFunction

  Bool Function CleanUpZombie(ReferenceAlias ZombieAlias, Actor Zombie)
    Return False
  EndFunction

EndState
