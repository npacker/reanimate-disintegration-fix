Scriptname NEP_ReanimateFixScript extends Quest
{Main Reanimate Fix control script.}

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

Function CleanUpZombie(ReferenceAlias ZombieAlias, Actor Zombie)

  Zombie.Kill()
  ZombieAlias.Clear()

  Int Index = NEP_ReanimateFixSpellFactionList.GetSize()

  While Index
    Index -= 1

    Zombie.RemoveFromFaction(NEP_ReanimateFixSpellFactionList.GetAt(Index) as Faction)
  EndWhile

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
