Scriptname NEP_ReanimateFixScript extends Quest
{Main Reanimate Fix control script.}

;-------------------------------------------------------------------------------
;
; IMPORTS
;
;-------------------------------------------------------------------------------

Import NEP_ReanimateFixLib

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

ReferenceAlias[] Property ZombieAliases Auto
{Aliases for storing reanimated thrall references.}

FormList Property NEP_ReanimateFixSpellFactionList Auto
{Form List of factions that are applied to reanimated zombies.}

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

State Busy

  Bool Function TrackZombie(Actor Target)
    Return False
  EndFunction

  Bool Function UntrackZombie(ReferenceAlias ZombieAlias, Actor Zombie)
    Return False
  EndFunction

EndState

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
      If ZombieHasExpired(Current)
        CleanUpZombie(CurrentAlias, Current, NEP_ReanimateFixSpellFactionList)
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
  CleanUpZombie(ZombieAlias, Zombie, NEP_ReanimateFixSpellFactionList)
  GoToState("")

  Return True

EndFunction
