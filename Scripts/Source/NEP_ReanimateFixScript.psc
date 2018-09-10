Scriptname NEP_ReanimateFixScript extends Quest
{Main Reanimate Fix control script.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

ReferenceAlias[] Property ZombieAliases Auto
{Aliases for storing reanimated thrall references.}

Faction Property NEP_ReanimateFixNoDisintegrateFaction Auto
{Faction for zombies that should not disintegrate on death.}

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function CleanUpZombie(ReferenceAlias ZombieAlias, Actor Zombie)

  Zombie.Kill()
  ZombieAlias.Clear()
  Zombie.RemoveFromFaction(NEP_ReanimateFixNoDisintegrateFaction)

EndFunction

Bool Function TrackZombie(Actor Target)

  GoToState("Busy")

  ReferenceAlias SelectedAlias = None
  ReferenceAlias CurrentAlias = None
  Actor Current = None
  Int Index = ZombieAliases.Length

  While Index
    Index -= 1
    CurrentAlias = ZombieAliases[Index]
    Current = CurrentAlias.GetReference() as Actor

    If Current
      If Current.IsDead() || Current.IsDisabled() || Current.IsDeleted()
        CleanUpZombie(CurrentAlias, Current)

        Current = None
      EndIf
    EndIf

    If !Current && !SelectedAlias
      SelectedAlias = CurrentAlias
    ElseIf Current == Target
      SelectedAlias = None
      Index = 0
    EndIf
  EndWhile

  If SelectedAlias
    SelectedAlias.ForceRefTo(Target as ObjectReference)
  EndIf

  GoToState("")

  Return True

EndFunction

Bool Function UntrackZombie(ReferenceAlias ZombieAlias, Actor Zombie)

  GoToState("Busy")
  CleanUpZombie(ZombieAlias, Zombie)
  GoToState("")

  Return True

EndFunction

State Busy

  Bool Function TrackZombie(Actor Target)
    Return False
  EndFunction

  Bool Function UntrackZombie(ReferenceAlias ZombieAlias, Actor Zombie)
    Return False
  EndFunction

EndState
