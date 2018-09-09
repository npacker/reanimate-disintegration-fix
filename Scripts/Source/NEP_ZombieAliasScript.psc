Scriptname NEP_ZombieAliasScript extends ReferenceAlias
{Script attached to aliases on the reanimated thralls tracking quest.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

FormList Property NEP_ZombieFormList Auto
{Form List of tracked Zombies.}

Faction Property NEP_ReanimateFixNoDisintegrateFaction Auto
{Faction for zombies that should not disintegrate on death.}

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Float fDelay = 4.0

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function CleanUpZombie(Actor Zombie)

  Self.Clear()
  NEP_ZombieFormList.RemoveAddedForm(Zombie)
  Zombie.RemoveFromFaction(NEP_ReanimateFixNoDisintegrateFaction)

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnUnload()

  Actor Zombie = Self.GetReference() as Actor

  If Zombie == None
    Return
  EndIf

  If Zombie.IsDisabled() || Zombie.IsDeleted()
    Zombie.Kill()
  Else
    RegisterForSingleUpdate(fDelay)
  EndIf

EndEvent

Event OnUpdate()

  Actor Zombie = Self.GetReference() as Actor

  If Zombie == None
    Return
  EndIf

  If Zombie.IsDead()
    CleanUpZombie(Zombie)
  EndIf

EndEvent

Event OnDying(Actor Killer)

  Actor Zombie = Self.GetReference() as Actor

  If Zombie == None
    Return
  EndIf

  CleanUpZombie(Zombie)

EndEvent

Event OnDeath(Actor Killer)

  Actor Zombie = Self.GetReference() as Actor

  If Zombie == None
    Return
  EndIf

  CleanUpZombie(Zombie)

EndEvent
